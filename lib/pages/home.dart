import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_event.dart';
import 'package:free_api_sample_may/blocs/home/home_state.dart';
import 'package:free_api_sample_may/pages/add_products.dart';
import 'package:free_api_sample_may/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeBloc>().add(FetchProductsEvent());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeLoadedState) {
              return Center(
                  child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: state.productsList[index].name.toString(),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.image),
                  ),
                  title: Text(state.productsList[index].name.toString()),
                  subtitle:
                      Text(state.productsList[index].description.toString()),
                  trailing: IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(DeleteAProductEvent(
                            productId: state.productsList[index].id!));
                      },
                      icon: Icon(Icons.delete)),
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
