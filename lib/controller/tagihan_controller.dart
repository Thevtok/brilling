// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/model/tagihan.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;

class TagihanController extends GetxController {
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
  var tagihans = <Tagihan>[].obs;

  Future<void> getTagihan(String idPenjualan,String tglInvoice) async {
    try {
      isLoading(true);
      tagihans.clear();

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpenjualan': idPenjualan,
        'tglinvoice': tglInvoice,
      });

      final response = await _dio.post(
        dotenv.env['GETTAGIHAN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Tagihan> billings =
            data.map((e) => Tagihan.fromJson(e)).toList();
        tagihans.assignAll(billings);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addTagihan(
    String idPelanggan,
    String hargaInvoice,
    String tglinvoice,
    String status,
    String ppn,
  ) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpelangganppoe': idPelanggan,
        'hargainvoice': hargaInvoice,
        'tglinvoice': tglinvoice,
        'status': status,
        'ppn': ppn,
      });

      final response = await _dio.post(
        dotenv.env['ADDTAGIHAN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
      } else {}
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<bool> editTagihan(
    String idInvoice,
    String hargaInvoice,
    String tglinvoice,
    String status,
    String ppn,
  ) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idinvoice': idInvoice,
        'hargainvoice': hargaInvoice,
        'tglinvoice': tglinvoice,
        'status': status,
        'ppn': ppn,
      });

      final response = await _dio.post(
        dotenv.env['EDITTAGIHAN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
      } else {}
    } finally {
      isLoading(false);
    }
    return false;
  }
}
