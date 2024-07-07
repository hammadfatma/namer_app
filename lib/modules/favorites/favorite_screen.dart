import 'package:flutter/material.dart';
import 'package:namerapp/layouts/home_screen.dart';
import 'package:namerapp/shared/styles/app_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var searchController = TextEditingController();
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
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 24,
                        color: Color(0xff808194),
                      ),
                    ),
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
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Color(0xffFBFBFB),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border(
                    top: BorderSide(color: Color(0xff8249B5), width: 2),
                    right: BorderSide(color: Color(0xff8249B5), width: 2),
                    bottom: BorderSide(color: Color(0xff8249B5), width: 2),
                    left: BorderSide(color: Color(0xff8249B5), width: 2),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '“All I required to be happy was friendship and people I could admire.”',
                        textAlign: TextAlign.justify,
                        style: AppStyles.styleRegular26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(),
                          ),
                          Text(
                            'Christian Dior',
                            style: AppStyles.styleRegular22.copyWith(
                              color: Color(0xff323232).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
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
                            top: BorderSide(color: Color(0xff8249B5), width: 2),
                            right:
                                BorderSide(color: Color(0xff8249B5), width: 2),
                            bottom:
                                BorderSide(color: Color(0xff8249B5), width: 2),
                            left:
                                BorderSide(color: Color(0xff8249B5), width: 2),
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
                                style: AppStyles.styleRegular22.copyWith(
                                  color: Color(0xff8249B5),
                                ),
                              ),
                            ],
                          ),
                        ),
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
