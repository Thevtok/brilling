import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'utils/data_local.dart';

Future<void> dapatkanLokasiPengguna() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await dapatkanLokasiPengguna();
  final isLoggedIn = await getAuthentication();
  runApp(MyApp(isLoggedIn: isLoggedIn));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}


class MyApp extends StatelessWidget {
   final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
  
      return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      SplashScreen(isLoggedIn: isLoggedIn)
 
    );
  }
}