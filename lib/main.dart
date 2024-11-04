import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/login/login_bloc.dart';
import 'package:free_api_sample_may/pages/login.dart';
import 'package:free_api_sample_may/pages/registration.dart';

void main(List<String> args) {
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginBloc())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
