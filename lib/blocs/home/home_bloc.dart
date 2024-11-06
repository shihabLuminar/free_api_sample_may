import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_event.dart';
import 'package:free_api_sample_may/blocs/home/home_state.dart';
import 'package:free_api_sample_may/models/products_res_model.dart';
import 'package:free_api_sample_may/utils/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(HomeLoadingState());

      final url =
          Uri.parse("https://freeapi.luminartechnohub.com/products-all/");

      try {
        final response = await http.get(url, headers: {
          "Authorization": "Bearer ${await AppUtils.getAccesToken()}"
        });

        log(response.statusCode.toString());
        log(response.body.toString());
        if (response.statusCode == 200) {
          ProductsResModel resModel = productsResModelFromJson(response.body);

          emit(HomeLoadedState(productsList: resModel.productsList ?? []));
        } else {
          emit(HomeInitial());
        }
      } catch (e) {
        emit(HomeErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteAProductEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        final url = Uri.parse(
            "https://freeapi.luminartechnohub.com/product-delete/${event.productId}/");
        try {
          final res = await http.delete(url, headers: {
            "Authorization": "Bearer ${await AppUtils.getAccesToken()}"
          });
          if (res.statusCode == 200) {
            log(res.body);
            add(FetchProductsEvent());
          }
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
}
