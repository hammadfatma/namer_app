import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namerapp/layouts/home_screen.dart';
import 'package:namerapp/shared/cubit/quote_cubit.dart';
import 'package:namerapp/shared/network/remote/dio_helper.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => QuoteCubit(DioHelper(Dio()))..createDatabase(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GemunuLibre',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
