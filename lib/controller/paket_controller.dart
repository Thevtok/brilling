// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/model/paket.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;

class PaketController extends GetxController {
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
  var pakets = <Paket>[].obs;

  Future<void> getPaket(String idPenjualan) async {
    try {
      isLoading(true);
      pakets.clear();

      Dio.FormData formData = Dio.FormData.fromMap({'idpenjualan': idPenjualan});

      final response = await _dio.post(
        dotenv.env['GETPAKET'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Paket> billings =
            data.map((e) => Paket.fromJson(e)).toList();
        pakets.assignAll(billings);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addPaket(String nama, String bandwith, String harga,String idPenjualan,String idippool) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpenjualan': idPenjualan,
        'idippool': idippool,
        'namapaket': nama,
        'bandwidth': bandwith,
        'hargapaket': harga,
      });

      final response = await _dio.post(
        dotenv.env['ADDPAKET'] ?? "",
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

  Future<bool> editPaket(String nama, String bandwith, String harga,String id,String idPenjualan,String idippool) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpenjualan': idPenjualan,
        'idippool': idippool,
        'namapaket': nama,
        'bandwidth': bandwith,
        'hargapaket': harga,
        'idpaket':id
      });

      final response = await _dio.post(
        dotenv.env['EDITPAKET'] ?? "",
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
}
