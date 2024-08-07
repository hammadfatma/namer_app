import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namerapp/models/quote.dart';
import 'package:namerapp/modules/favorites/favorite_screen.dart';
import 'package:namerapp/shared/cubit/quote_cubit.dart';
import 'package:namerapp/shared/styles/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    QuoteCubit.get(context).generateQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff5D13E7),
            Color(0xff8249B5),
          ],
        ),
      ),
      child: BlocConsumer<QuoteCubit, QuoteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          QuoteCubit cubit = QuoteCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoriteScreen(
                                cubit: cubit,
                                favoritesList: cubit.favoriteQuotes
                                    .map((element) => Quote(
                                        id: element['id'],
                                        content: element['content'],
                                        author: element['author']))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB).withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              topRight: Radius.circular(6.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Click Here To View Favorite Quotes',
                              textAlign: TextAlign.justify,
                              style: AppStyles.styleRegular26,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -15,
                        right: -15,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Color(0xff323232),
                          ),
                          child: Center(
                            child: Text(
                              '${cubit.favoriteQuotes.length}',
                              textAlign: TextAlign.justify,
                              style: AppStyles.styleRegular22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFBFBFB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      ),
                      border: Border(
                        top: BorderSide(color: Color(0xff8249B5), width: 2),
                        right: BorderSide(color: Color(0xff8249B5), width: 2),
                        bottom: BorderSide(color: Color(0xff8249B5), width: 2),
                        left: BorderSide(color: Color(0xff8249B5), width: 2),
                      ),
                    ),
                    child: ConditionalBuilder(
                      condition: state is! QuoteLoadingState,
                      builder: (context) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                '“${cubit.quoteModel.content}”',
                                textAlign: TextAlign.justify,
                                style: AppStyles.styleRegular26,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Text(
                                    '${cubit.quoteModel.author}',
                                    style: AppStyles.styleRegular22.copyWith(
                                      color: Color(0xff323232).withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cubit.generateQuote();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 13,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xff8249B5),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          bottomLeft: Radius.circular(6.0),
                                          bottomRight: Radius.circular(0.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Generate Another Quote',
                                          textAlign: TextAlign.justify,
                                          style: AppStyles.styleRegular22
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.addQuoteToFavorite(
                                          model: cubit.quoteModel);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 34.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xffFBFBFB),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(6.0),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                              color: Color(0xff8249B5),
                                              width: 2),
                                          right: BorderSide(
                                              color: Color(0xff8249B5),
                                              width: 2),
                                          bottom: BorderSide(
                                              color: Color(0xff8249B5),
                                              width: 2),
                                          left: BorderSide(
                                              color: Color(0xff8249B5),
                                              width: 2),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          cubit.favorite,
                                          size: 30,
                                          color: Color(0xff8249B5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
