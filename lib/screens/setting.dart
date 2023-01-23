import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mof/provider/myProvider.dart';
import 'package:mof/theme/colors.dart';
import 'package:mof/ui/set_pin.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

bool myswitch = false;

class _SettingScreenState extends State<SettingScreen> {
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

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
    final prov = Provider.of<myProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: prov.status == true ? Colors.white : Colors.black,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: prov.status == true ? Colors.white : CustomColor.textGray,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<myProvider>(context, listen: true);
    return Container(
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PIN',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: prov.status == true ? Colors.white : Colors.black,
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
          buildSectionKeyValue(key: 'Version', value: '1.0.1'),
          const SizedBox(height: 12.0),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set Dark Theme",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: prov.status == true ? Colors.white : Colors.black,
                    ),
                  ),
                  Switch(
                      value: prov.getStatus,
                      onChanged: ((bool value) {
                        setState(() {
                          prov.setStatus(value);
                        });
                      }))
                ],
              ),
              // ListTile(
              //   contentPadding: const EdgeInsets.all(0),
              //   title: const Text("Login"),
              //   onTap: () {
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => const LoginPage()));
              //   },
              // )
              // const Spacer(),
            ],
          ),
          const Spacer(),
          Positioned(
            bottom: 30.0,
            left: 30.0,
            child: SizedBox(
              height: 250.0,
              width: 320.0,
              child: Center(
                child: AdWidget(
                  ad: myBanner,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
