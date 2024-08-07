import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:namerapp/layouts/home_screen.dart';
import 'package:namerapp/models/quote.dart';
import 'package:namerapp/shared/cubit/quote_cubit.dart';
import 'package:namerapp/shared/styles/app_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen(
      {super.key, required this.favoritesList, required this.cubit});
  final List<Quote> favoritesList;
  final QuoteCubit cubit;
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Quote> searchList = [];
  @override
  void initState() {
    super.initState();
    searchList = widget.favoritesList;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    searchController.dispose();
    super.dispose();
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 60,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFBFBFB).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 20,
                          color: Color(0xff323232),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Back To Home Screen',
                          textAlign: TextAlign.justify,
                          style: AppStyles.styleRegular26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xffFBFBFB),
                ),
                child: TextField(
                  onChanged: (value) {
                    List<Quote> result = [];
                    if (value.isEmpty) {
                      result = widget.favoritesList;
                    } else {
                      result = widget.favoritesList
                          .where((element) => element.content
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }
                    setState(() {
                      searchList = result;
                    });
                  },
                  controller: searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    suffixIcon: _focusNode.hasFocus
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: 24,
                              color: Color(0xff808194),
                            ),
                          )
                        : null,
                    hintText: 'Type Something Here To Search..',
                    hintStyle: AppStyles.styleRegular22.copyWith(
                      color: Color(0xff323232).withOpacity(0.7),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ConditionalBuilder(
                condition: searchList.isNotEmpty,
                builder: (context) {
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Color(0xffFBFBFB),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border(
                              top: BorderSide(
                                  color: Color(0xff8249B5), width: 2),
                              right: BorderSide(
                                  color: Color(0xff8249B5), width: 2),
                              bottom: BorderSide(
                                  color: Color(0xff8249B5), width: 2),
                              left: BorderSide(
                                  color: Color(0xff8249B5), width: 2),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '“${searchList[index].content}”',
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
                                      '${searchList[index].author}',
                                      style: AppStyles.styleRegular22.copyWith(
                                        color:
                                            Color(0xff323232).withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.cubit
                                        .deleteData(id: searchList[index].id!);
                                    setState(() {
                                      searchList.removeAt(index);
                                    });
                                    print("length: ${searchList.length}");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 50.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFBFBFB),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                        bottomLeft: Radius.circular(6.0),
                                        bottomRight: Radius.circular(6.0),
                                      ),
                                      border: Border(
                                        top: BorderSide(
                                            color: Color(0xff8249B5), width: 2),
                                        right: BorderSide(
                                            color: Color(0xff8249B5), width: 2),
                                        bottom: BorderSide(
                                            color: Color(0xff8249B5), width: 2),
                                        left: BorderSide(
                                            color: Color(0xff8249B5), width: 2),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.favorite_border_outlined,
                                            size: 30,
                                            color: Color(0xff8249B5),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Remove From Favorite',
                                            textAlign: TextAlign.justify,
                                            style: AppStyles.styleRegular22
                                                .copyWith(
                                              color: Color(0xff8249B5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: searchList.length,
                    ),
                  );
                },
                fallback: (context) => Center(
                  child: Column(
                    children: [
                      Text(
                        'Oops!',
                        style: AppStyles.styleRegular26,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'No items found',
                        style: AppStyles.styleRegular22,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
