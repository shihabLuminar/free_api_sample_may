import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_event.dart';
import 'package:free_api_sample_may/blocs/login/login_bloc.dart';
import 'package:free_api_sample_may/blocs/product_adding/adding_bloc.dart';
import 'package:free_api_sample_may/pages/splash_screen.dart';

void main(List<String> args) {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginBloc()),
    BlocProvider(create: (context) => AddingBloc()),
    BlocProvider(create: (context) => HomeBloc()..add(FetchProductsEvent())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
