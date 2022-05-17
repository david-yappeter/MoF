import 'package:get/get.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/category.dart';

class CategoryController extends GetxController {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => [..._categories];

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData(DBHelper.categoryDBName);
    _categories = dataList
        .map(
          (e) => CategoryModel(
            id: e['id'],
            name: e['name'],
            iconId: e['icon_id'],
            isIncome: e['is_income'],
            createdAt: DateTime.parse(e['created_at']),
            updatedAt: DateTime.parse(e['updated_at']),
          ),
        )
        .toList();
  }

  Future<int> insert({
    required String name,
    int? iconId,
    required int isIncome,
    required DateTime createdAt,
  }) {
    return DBHelper.insert(DBHelper.categoryDBName, {
      'name': name,
      'icon_id': iconId,
      'is_income': isIncome,
      'created_at': createdAt.toIso8601String(),
      'updated_at': createdAt.toIso8601String(),
    });
  }

  List<CategoryModel> get getExpense =>
      _categories.where((e) => e.isIncome == 0).toList();
  List<CategoryModel> get getIncome =>
      _categories.where((e) => e.isIncome == 1).toList();
}
