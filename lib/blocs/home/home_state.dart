import 'package:equatable/equatable.dart';
import 'package:free_api_sample_may/models/products_res_model.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<Product> productsList;
  HomeLoadedState({this.productsList = const []});

  @override
  List<Object> get props => [productsList];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
