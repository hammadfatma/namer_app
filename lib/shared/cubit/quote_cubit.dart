import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namerapp/models/quote.dart';
import 'package:namerapp/shared/network/remote/dio_helper.dart';
import 'package:sqflite/sqflite.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteStates> {
  QuoteCubit(this.dioHelper) : super(QuoteInitialState());
  static QuoteCubit get(context) => BlocProvider.of(context);
  final DioHelper dioHelper;
  Quote quoteModel = Quote();
  IconData favorite = Icons.favorite_border_outlined;
  Future<void> generateQuote() async {
    emit(QuoteLoadingState());
    await dioHelper.getQuate().then((value) {
      favorite = Icons.favorite_border_outlined;
      quoteModel = Quote.fromJson(value);
      emit(QuoteSuccessState());
    }).catchError((error) {
      emit(QuoteFailureState());
    });
  }

  void addQuoteToFavorite({required Quote model}) async {
    print("id: ${model.id}");
    favorite = Icons.favorite;
    await insertToDatabase(quote: model);
    emit(AddQuoteToFavoriteState());
  }

  late Database database;
  List<Map> favoriteQuotes = [];
  Future<void> createDatabase() async {
    await openDatabase(
      'favorite.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE quotes (id TEXT PRIMARY KEY, content TEXT, author TEXT)')
            .then((value) async {
          await generateQuote();
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) async {
        await generateQuote();
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  Future<void> insertToDatabase({
    required Quote quote,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO quotes(id, content, author) VALUES("${quote.id}", "${quote.content}", "${quote.author}")')
          .then((value) {
        print('$value inserted successfully');
        emit(InsertToDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future<void> getDataFromDatabase(database) async {
    favoriteQuotes = [];
    emit(GetDatabaseLoadingState());
    await database.rawQuery('SELECT * FROM quotes').then((value) {
      value.forEach((element) {
        favoriteQuotes.add(element);
      });
      emit(GetDatabaseSuccessState());
    }).catchError((error) {
      print('Error When Getting Record ${error.toString()}');
    });
  }

  Future<void> deleteData({
    required String id,
  }) async {
    await database.rawDelete(
      'DELETE FROM quotes WHERE id = ?',
      [id],
    ).then((value) {
      print('$value deleted successfully');
      getDataFromDatabase(database);
      emit(DeleteFromDatabaseState());
    }).catchError((error) {
      print('Error When Deleting Record ${error.toString()}');
    });
  }
}
