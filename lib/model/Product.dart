import 'package:json_annotation/json_annotation.dart';
part 'Product.g.dart';

@JsonSerializable()
class Product{
  final int id;
  final String productName;
  final double productPrice;

  Product(this.id, this.productName, this.productPrice);
  factory Product.fromJSON(Map<String,dynamic> json) => _$ProductFromJson(json);
  Map<String,dynamic> toJson()=> _$ProductToJson(this);
}