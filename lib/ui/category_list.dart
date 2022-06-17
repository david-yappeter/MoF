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
            margin: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Expense',
                          style: Theme.of(context).textTheme.headline2)),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: controller.expenseCategories
                          .map(
                            (category) => ListTile(
                              title: Text(
                                category.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              leading: category.iconId != null
                                  ? Icon(IconData(category.iconId as int))
                                  : null,
                              onTap: () {
                                Get.back(result: category);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Income',
                          style: Theme.of(context).textTheme.headline2)),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: controller.incomeCategories
                          .map(
                            (category) => ListTile(
                              title: Text(
                                category.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              leading: category.iconId != null
                                  ? Icon(IconData(category.iconId as int))
                                  : null,
                              onTap: () {
                                Get.back(result: category);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            // child: ListView.builder(
            //   itemBuilder: (BuildContext ctx, int idx) {
            //     final category = controller.categories[idx];
            // return ListTile(
            //   title: Text(
            //     category.name,
            //     style: Theme.of(context).textTheme.headline3,
            //   ),
            //   leading: category.iconId != null
            //       ? Icon(IconData(category.iconId as int))
            //       : null,
            //   onTap: () {
            //     Get.back(result: category);
            //   },
            // );
            //   },
            //   itemCount: controller.categories.length,
            // ),
          );
        },
      ),
    );
  }
}
