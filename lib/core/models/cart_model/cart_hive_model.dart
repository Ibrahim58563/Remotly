// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'cart_hive_model.g.dart';

@HiveType(typeId: 0)
class CartHiveModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final num? rating;
  @HiveField(7)
  int quantity;
  CartHiveModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.quantity = 0,
  });
}
