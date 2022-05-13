import 'package:flutter/material.dart';
import 'package:mof/theme/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: CustomColor.blue,
      ),
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
            buildSectionTitle('Security'),
            TextButton(
              onPressed: () {},
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
            const SizedBox(height: 20.0),
            buildSectionTitle('Profile'),
            const SizedBox(height: 20.0),
            buildSectionTitle('Notification'),
            const SizedBox(height: 20.0),
            buildSectionTitle('About'),
          ],
        ),
      ),
    );
  }
}
