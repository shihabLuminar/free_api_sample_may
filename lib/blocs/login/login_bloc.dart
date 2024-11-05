import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/login/login_event.dart';
import 'package:free_api_sample_may/blocs/login/login_state.dart';
import 'package:free_api_sample_may/models/login_res_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnUserLoginEvent>((event, emit) async {
      // shared prefs  initialisaiton
      final prefs = await SharedPreferences.getInstance();
      // emitted loading state to show loading indicator
      emit(LoginLoadingState());
      final url = Uri.parse("https://freeapi.luminartechnohub.com/login");
      try {
        // post api call
        final response = await http.post(url,
            body: {"email": event.email, "password": event.password});
        //  checking status code
        if (response.statusCode == 200) {
          // respose body is converted to model class
          LoginResModel responseObject = loginResModelFromJson(response.body);
          // storing access token to shared preference
          prefs.setString("access", responseObject.access.toString());
          // storing access token to shared preference
          prefs.setString("refresh", responseObject.refresh.toString());
          // emitted success state
          emit(LoginSuccessState());
        } else {
          // emitting initial state when login failed
          emit(LoginInitial());
        }
      } catch (e) {
        // emitting error state on exception
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    });
  }
}
