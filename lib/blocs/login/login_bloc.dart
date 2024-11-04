import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/login/login_event.dart';
import 'package:free_api_sample_may/blocs/login/login_state.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnUserLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final url = Uri.parse("https://freeapi.luminartechnohub.com/login");
      try {
        final response = await http.post(url,
            body: {"email": event.email, "password": event.password});
        log(response.statusCode.toString());

        if (response.statusCode == 200) {
          log("succesfully logged");
          emit(LoginSuccessState());
        } else {
          emit(LoginInitial());
        }
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    });
  }
}
