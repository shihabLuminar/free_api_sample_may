import 'package:equatable/equatable.dart';

class AddingState extends Equatable {
  const AddingState();

  @override
  List<Object> get props => [];
}

final class AddingInitial extends AddingState {}

final class ProductAddedState extends AddingState {}

final class ProductAddingState extends AddingState {}
