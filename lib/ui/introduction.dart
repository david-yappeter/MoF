import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/introduction.dart';
import 'package:mof/theme/colors.dart';
import 'package:mof/ui/home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionUI extends GetView<IntroductionController> {
  static const routeName = '/introduction';
  final pageCount = 3;

  const IntroductionUI({Key? key}) : super(key: key);

  Widget buildSlideView({
    required String imageAssetLink,
    required String title,
    required String description,
  }) =>
      SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          color: CustomColor.background,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300.0,
                  child: Image.asset(imageAssetLink, fit: BoxFit.cover),
                ),
                const SizedBox(height: 20.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    color: CustomColor.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller.pageController,
            onPageChanged: controller.changeIndex,
            children: [
              buildSlideView(
                imageAssetLink: 'assets/images/money-investment.png',
                title: 'Welcome to Minister of Finance',
                description:
                    'Mof is a free to use financial management app that helps you manage your finances.',
                // 'Manage your money, manage your life',
              ),
              buildSlideView(
                imageAssetLink: 'assets/images/business-analysis.png',
                title: 'Tracking',
                description:
                    'Track your expenses and see how much you spend each month.',
              ),
              SafeArea(
                child: Container(
                  color: CustomColor.background,
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Let's get started",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        TextFormField(
                          controller: controller.firstWalletNameController,
                          decoration: const InputDecoration(
                            labelText: 'Wallet name',
                            hintText: 'Enter your wallet name',
                            border: OutlineInputBorder(),
                          ),
                          validator: controller.validateWallet,
                          onSaved: (String? value) {
                            if (value == null) return;
                            controller.firstWalletName.value = value;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.expenseCategoryNameController,
                          decoration: const InputDecoration(
                            labelText: 'Expense Category Name',
                            hintText: 'Enter your Category Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: controller.validateCategory,
                          onSaved: (String? value) {
                            if (value == null) return;
                            controller.expenseCategoryName.value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: FutureBuilder(
          future: Future.value(true),
          builder: (BuildContext ctx, AsyncSnapshot<void> snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              height: 80,
              child: Stack(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: pageCount,
                      onDotClicked: (index) {
                        controller.pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => controller.index.value + 1 != pageCount
                          ? TextButton(
                              child: const Text('NEXT'),
                              onPressed: () {
                                controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            )
                          : TextButton(
                              child: const Text('GET STARTED'),
                              onPressed: () async {
                                GetStorage().write(SHOW_HOME, true);
                                final success = await controller.onSubmit();
                                if (success) {
                                  Get.offAllNamed(Home.routeName);
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
