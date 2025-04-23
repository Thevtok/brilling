// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/model/penjualan.dart';
import 'package:flutter_application_1/model/pool.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;

class DashboardController extends GetxController {
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

  bool hasMoreData = true;
  var penjualans = <Penjualan>[].obs;

  var pools = <Pool>[].obs;
  final selectedRouter = Rxn<Penjualan>();


  Future<void> getPool() async {
    try {
      isLoading(true);
      pools.clear();

      Dio.FormData formData = Dio.FormData.fromMap({'idpenjualan': selectedRouter.value?.idpenjualan??""});

      final response = await _dio.post(
        dotenv.env['GETPOOL'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Pool> billings = data.map((e) => Pool.fromJson(e)).toList();
        pools.assignAll(billings);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getPenjualan() async {
    try {
      isLoading(true);
      penjualans.clear();
      String? userId = await getUserIdFromSharedPreferences();

      Dio.FormData formData = Dio.FormData.fromMap({'userid': userId});

      final response = await _dio.post(
        dotenv.env['GETPENJUALAN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Penjualan> billings =
            data.map((e) => Penjualan.fromJson(e)).toList();
        penjualans.assignAll(billings);
        if (billings.isNotEmpty && selectedRouter.value == null) {
        selectedRouter.value = billings.first;
      }
      }
    } finally {
      isLoading(false);
    }
  }
}
