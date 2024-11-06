import 'package:equatable/equatable.dart';

class ProductAddingEvent extends Equatable {
  const ProductAddingEvent();

  @override
  List<Object> get props => [];
}

class AddPrductEvent extends ProductAddingEvent {
  final String name;
  final String des;
  final String price;
  final int stock;
  final String category;

  AddPrductEvent(
      {required this.name,
      required this.des,
      required this.price,
      required this.stock,
      required this.category});

  @override
  List<Object> get props => [name, des, price, stock, category];
}
