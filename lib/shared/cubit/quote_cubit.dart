import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namerapp/models/quote.dart';
import 'package:namerapp/shared/network/remote/dio_helper.dart';

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

  void addQuoteToFavorite() {
    favorite = Icons.favorite;
    emit(AddQuoteToFavoriteState());
  }
}
