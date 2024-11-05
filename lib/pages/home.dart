import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeLoadedState) {
          return Center(
              child: ListView.separated(
            itemBuilder: (context, index) => Container(
              child: Text("data"),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
            itemCount: state.productsList.length,
          ));
        }

        return SizedBox();
      },
    ));
  }
}
