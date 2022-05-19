import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/set_pin.dart';
import 'package:mof/theme/colors.dart';

class SetPinScreen extends GetView<SetPinController> {
  static const routeName = '/set-pin';
  final keyCount = 6;
  const SetPinScreen({Key? key}) : super(key: key);

  Widget buildTapButton({Function()? onTap, IconData? icon, String? text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.transparent,
      ),
      height: 50,
      width: double.infinity,
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(CustomColor.whiteLight),
        onTap: onTap,
        child: Center(
          child: (icon == null)
              ? Text(
                  text as String,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: (text).isNum ? Colors.black : CustomColor.primary,
                  ),
                )
              : Icon(icon, color: CustomColor.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Obx(
        () => controller.successConfirmPin.value
            ? const Text("Set New Pin")
            : const Text("Confirm Your Pin"),
      ),
      centerTitle: true,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150 - appBar.preferredSize.height),
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
              Obx(
                () => SizedBox(
                  width: keyCount * 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List<Widget>.generate(
                      keyCount,
                      (int index) => CircleAvatar(
                        backgroundColor:
                            controller.currentPin.value.length > index
                                ? CustomColor.primary
                                : CustomColor.whiteLight,
                        radius: 8.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                  ),
                  children: [
                    buildTapButton(
                      onTap: () => controller.append(1),
                      text: '1',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(2),
                      text: '2',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(3),
                      text: '3',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(4),
                      text: '4',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(5),
                      text: '5',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(6),
                      text: '6',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(7),
                      text: '7',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(8),
                      text: '8',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(9),
                      text: '9',
                    ),
                    buildTapButton(
                      onTap: () => controller.clear(),
                      text: 'Clear',
                    ),
                    buildTapButton(
                      onTap: () => controller.append(0),
                      text: '0',
                    ),
                    buildTapButton(
                      onTap: () => controller.delete(),
                      // text: 'Delete',
                      icon: Icons.backspace,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
