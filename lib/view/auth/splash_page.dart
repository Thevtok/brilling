import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/view/auth/login_page.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    const splashDuration = Duration(seconds: 3);
    Future.delayed(splashDuration, () {
      if (widget.isLoggedIn) {
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary,
      child: Center(child: Image.asset('assets/images/logobrilink.png')),
    );
  }
}
