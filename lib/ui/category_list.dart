import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/category.dart';
import 'package:mof/ui/new_category.dart';

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
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Expense',
                                  style:
                                      Theme.of(context).textTheme.headline2)),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: controller.categories
                                  .where((category) => category.isIncome == 0)
                                  .map(
                                    (category) => ListTile(
                                      title: Text(
                                        category.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      leading: category.iconId != null
                                          ? Icon(
                                              IconData(category.iconId as int))
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Income',
                                  style:
                                      Theme.of(context).textTheme.headline2)),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: controller.categories
                                  .where((category) => category.isIncome == 1)
                                  .map(
                                    (category) => ListTile(
                                      title: Text(
                                        category.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      leading: category.iconId != null
                                          ? Icon(
                                              IconData(category.iconId as int))
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
                  ),
                  SizedBox(
                    height: 100.0,
                    child: CircleAvatar(
                      radius: 24.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          final success =
                              await Get.toNamed(NewCategoryScreen.routeName);
                          if (success != null && success as bool) {
                            controller.fetchAndSet();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
