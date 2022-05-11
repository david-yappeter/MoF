import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final int? iconId;
  final int isIncome;
  final DateTime createdAt, updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconId,
    required this.isIncome,
    required this.createdAt,
    required this.updatedAt,
  });
}
