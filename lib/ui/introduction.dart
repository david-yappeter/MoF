import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/controllers/introduction.dart';
import 'package:mof/theme/colors.dart';
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
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        color: CustomColor.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageAssetLink),
            const SizedBox(height: 20.0),
            Text(title, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 20.0),
            Text(description, style: const TextStyle(fontSize: 16)),
          ],
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
                title: 'TITLE',
                description: 'DESCRIPTION',
              ),
              buildSlideView(
                imageAssetLink: 'assets/images/money-investment.png',
                title: 'TITLE',
                description: 'DESCRIPTION',
              ),
              buildSlideView(
                imageAssetLink: 'assets/images/money-investment.png',
                title: 'TITLE',
                description: 'DESCRIPTION',
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
                              onPressed: () {
                                GetStorage().write('showHome', true);
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
