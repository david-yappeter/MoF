import 'package:get/get.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/category.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  void reload() {
    categories.refresh();
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData(DBHelper.categoryDBName);
    categories.clear();
    categories.addAll(
      dataList.map(
        (e) => CategoryModel(
          id: e['id'],
          name: e['name'],
          iconId: e['icon_id'],
          isIncome: e['is_income'],
          createdAt: DateTime.parse(e['created_at']),
          updatedAt: DateTime.parse(e['updated_at']),
        ),
      ),
    );
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
}
