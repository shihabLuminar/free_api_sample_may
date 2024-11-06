import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:free_api_sample_may/blocs/product_adding/adding_event.dart';
import 'package:free_api_sample_may/blocs/product_adding/adding_state.dart';
import 'package:free_api_sample_may/utils/app_utils.dart';
import 'package:http/http.dart' as http;

class AddingBloc extends Bloc<ProductAddingEvent, AddingState> {
  AddingBloc() : super(AddingInitial()) {
    on<AddPrductEvent>((event, emit) async {
      emit(ProductAddingState());
      final url =
          Uri.parse("https://freeapi.luminartechnohub.com/product-create/");
      try {
        final res = await http.post(url, body: {
          "name": event.name,
          "description": event.des,
          "price": event.price,
          "stock": event.stock,
          "category": event.category
        }, headers: {
          "Authorization": "Bearer ${await AppUtils.getAccesToken()}"
        });
        if (res.statusCode == 200) {
          log(event.name);
          log(res.body);
        }
      } catch (e) {
        // emit(p(errorMessage: e.toString()));
      }
    });
  }
}
