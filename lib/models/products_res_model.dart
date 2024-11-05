import 'dart:convert';

ProductsResModel productsResModelFromJson(String str) =>
    ProductsResModel.fromJson(json.decode(str));

String productsResModelToJson(ProductsResModel data) =>
    json.encode(data.toJson());

class ProductsResModel {
  String? msg;
  List<Product>? productsList;

  ProductsResModel({
    this.msg,
    this.productsList,
  });

  factory ProductsResModel.fromJson(Map<String, dynamic> json) =>
      ProductsResModel(
        msg: json["Msg"],
        productsList: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Msg": msg,
        "data": productsList == null
            ? []
            : List<dynamic>.from(productsList!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  int? stock;
  String? category;
  String? image;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
      };
}
