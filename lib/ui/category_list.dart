import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/category.dart';

class CategoryList extends GetView<CategoryController> {
  static const routeName = '/category-list';
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: FutureBuilder(
        future: controller.fetchAndSet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            margin: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
            child: ListView.builder(
              itemBuilder: (BuildContext ctx, int idx) {
                final category = controller.categories[idx];
                return ListTile(
                  title: Text(category.name),
                  leading: category.iconId != null
                      ? Icon(IconData(category.iconId as int))
                      : null,
                  onTap: () {
                    Get.back(result: category);
                  },
                );
              },
              itemCount: controller.categories.length,
            ),
          );
        },
      ),
    );
  }
}