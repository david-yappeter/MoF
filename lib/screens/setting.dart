import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/theme/colors.dart';
import 'package:mof/ui/set_pin.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: CustomColor.blue,
      ),
    );
  }

  Widget buildSectionKeyValue({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: CustomColor.textGray,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.background,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            buildSectionTitle('Security'),
            TextButton(
              onPressed: () {
                Get.toNamed(SetPinScreen.routeName);
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PIN',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            // const SizedBox(height: 20.0),
            // buildSectionTitle('Profile'),
            // const SizedBox(height: 20.0),
            // buildSectionTitle('Notification'),
            const SizedBox(height: 20.0),
            buildSectionTitle('About'),
            const SizedBox(height: 12.0),
            buildSectionKeyValue(key: 'Developer', value: 'TanpaNama'),
            const SizedBox(height: 12.0),
            buildSectionKeyValue(key: 'Version', value: '1.0.0'),
          ],
        ),
      ),
    );
  }
}
