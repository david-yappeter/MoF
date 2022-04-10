import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/pin_controller.dart';
import 'package:mof/theme/colors.dart';

class PinScreen extends StatelessWidget {
  final String pin;
  final keyCount = 6;
  const PinScreen({Key? key, required this.pin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PinController pin = Get.put<PinController>(PinController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Text(
                'MoF',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              Text(
                'Minister of Finance',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: keyCount * 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List<int>.filled(keyCount, 0)
                      .map(
                        (e) => const CircleAvatar(
                          backgroundColor: CustomColor.whiteLight,
                          radius: 8.0,
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Container(
                      child: Center(child: Text((index + 1).toString())),
                    );
                  },
                ),
              ),
              // SliverGrid(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3),
              //   delegate: SliverChildBuilderDelegate(
              //     (context, index) => Container(
              //       child: Text((index + 1).toString()),
              //     ),
              //   ),
              // ),
              // Row(
              //   children: List.generate(9, (index) => index + 1)
              //       .map(
              //         (e) => Expanded(
              //           child: Text(e.toString()),
              //         ),
              //       )
              //       .toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
