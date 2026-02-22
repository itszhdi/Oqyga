import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.categoryId, required super.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'categoryId': categoryId, 'categoryName': categoryName};
  }
}
