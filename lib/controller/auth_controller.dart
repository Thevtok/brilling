// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;

class AuthController extends GetxController {
  final Dio.Dio _dio = Dio.Dio();

  final String username = 'admin';
  final String password = 'jancuk';

  Dio.Options get basicOptions {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return Dio.Options(
      headers: {
        'Authorization': basicAuth,
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  var isLoading = false.obs;

  Future<bool> register(String nama, String email, String hp) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'nama': nama,
        'email': email,
        'hp': hp,
      });

      final response = await _dio.post(
        dotenv.env['REGISTER'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        var id = response.data['userid'].toString();
        var email = response.data['email'];
        await saveUsernameToSharedPreferences(email);

        await saveUserIdToSharedPreferences(id);
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<bool> sendOtp(String userid,String email) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({'userid': userid,'email':email});

      final response = await _dio.post(
        dotenv.env['SENDOTP'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<bool> inputOtp(String userid, String otp) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'userid': userid,
        'otp': otp,
      });

      final response = await _dio.post(
        dotenv.env['OTP'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<bool> inputPassword(
    String username,
    String password,
    String retypepassword,
  ) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'username': username,
        'password': password,
        'retypepassword': retypepassword,
      });

      final response = await _dio.post(
        dotenv.env['PASSWORD'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<bool> login(String username, String password) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await _dio.post(
        dotenv.env['LOGIN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        var id = response.data['userid'];
        await saveUserIdToSharedPreferences(id);

        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }
}
