// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/model/pelanggan.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;

class PelangganController extends GetxController {
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
  var pelanggans = <Pelanggan>[].obs;
  var totalPelanggan = 0.obs;

  Future<void> getPelanggan(String idPenjualan) async {
    try {
      isLoading(true);
      pelanggans.clear();
      totalPelanggan.value = 0;

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpenjualan': idPenjualan,
      });

      final response = await _dio.post(
        dotenv.env['GETPELANGGAN'] ?? "",
        data: formData,
        options: basicOptions,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Pelanggan> billings =
            data.map((e) => Pelanggan.fromJson(e)).toList();
        pelanggans.assignAll(billings);
        totalPelanggan.value = billings.length;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addPelanggan(
    String idPaket,
    String nama,
    String noKtp,
    String noHp,
    String userPppoe,
    String passPppoe,
    String lat,
    String long,
    String alamat,
    String idPenjualan,
  ) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpenjualan': idPenjualan,
        'idpaket': idPaket,
        'namapelanggan': nama,
        'noktp': noKtp,
        'nohp': noHp,
        'userppoe': userPppoe,
        'passppoe': passPppoe,
        'lat': lat,
        'long': long,
        'alamat': alamat,
      });

      final response = await _dio.post(
        dotenv.env['ADDPELANGGAN'] ?? "",
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

  Future<bool> editPelanggan(
    String nama,
    String noKtp,
    String noHp,
    String userPppoe,
    String passPppoe,
    String lat,
    String long,
    String alamat,
    String idPelanggan,
  ) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpelanggan': idPelanggan,
        'namapelanggan': nama,
        'noktp': noKtp,
        'nohp': noHp,
        'userppoe': userPppoe,
        'passppoe': passPppoe,
        'lat': lat,
        'long': long,
        'alamat': alamat,
      });

      final response = await _dio.post(
        dotenv.env['EDITPELANGGAN'] ?? "",
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

  Future<bool> editPelangganPaket(String idPaket, String idPelanggan) async {
    try {
      isLoading(true);

      Dio.FormData formData = Dio.FormData.fromMap({
        'idpelanggan': idPelanggan,
        'idpaket': idPaket,
      });

      final response = await _dio.post(
        dotenv.env['EDITPELANGGANPAKET'] ?? "",
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

  Future<Position?> ambilLokasiSekarang() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Gagal", "Layanan lokasi tidak aktif");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Gagal", "Izin lokasi ditolak");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Gagal", "Izin lokasi ditolak permanen");
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}
