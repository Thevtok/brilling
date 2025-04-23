// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/component/empty.dart';
import 'package:flutter_application_1/controller/dashboard_controller.dart';
import 'package:flutter_application_1/controller/paket_controller.dart';
import 'package:flutter_application_1/controller/pelanggan_controller.dart';
import 'package:flutter_application_1/model/paket.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class PelangganBar extends StatefulWidget {
  const PelangganBar({super.key});

  @override
  State<PelangganBar> createState() => _PelangganBarState();
}

class _PelangganBarState extends State<PelangganBar> {
  final controller = Get.put(PaketController());
  final pelangganController = Get.put(PelangganController());
  final dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    if (dashboardController.selectedRouter.value != null) {
      controller.getPaket(
        dashboardController.selectedRouter.value?.idpenjualan ?? "",
      );
      pelangganController.getPelanggan(
        dashboardController.selectedRouter.value?.idpenjualan ?? "",
      );
    } else {
      // Tangani kondisi ketika selectedRouter null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pelanggan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              controller.getPaket(
                dashboardController.selectedRouter.value?.idpenjualan ?? "",
              );
              pelangganController.getPelanggan(
                dashboardController.selectedRouter.value?.idpenjualan ?? "",
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (pelangganController.pelanggans.isEmpty) {
          return const EmptyPage(type: 'pelanggan');
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: pelangganController.pelanggans.length,
                itemBuilder: (context, index) {
                  final pelanggan = pelangganController.pelanggans[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Color.fromRGBO(245, 245, 250, 1),
                          Color.fromRGBO(240, 248, 255, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Informasi pelanggan dengan ikon
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    color: AppTheme.primary,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      pelanggan.namaPelanggan ?? 'Tanpa Nama',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone_android,
                                    color: AppTheme.primary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    pelanggan.noHp ?? '-',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_outlined,
                                    color: AppTheme.primary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Rp ${pelanggan.hargaJual ?? "0"}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color:
                                        pelanggan.status == "1"
                                            ? Colors.green
                                            : Colors.red,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    pelanggan.status == "1"
                                        ? "Aktif"
                                        : "Nonaktif",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          pelanggan.status == "1"
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Tombol aksi
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: AppTheme.primary,
                              ),
                              onPressed: () {
                                _showAddPelangganDialog(
                                  idPelanggan: pelanggan.no,
                                );
                              },
                              tooltip: "Edit Pelanggan",
                            ),
                            if ((pelanggan.lat?.isNotEmpty ?? false) &&
                                (pelanggan.longitude?.isNotEmpty ?? false))
                              IconButton(
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  launchUrl(
                                    Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${pelanggan.lat},${pelanggan.longitude}',
                                    ),
                                  );
                                },
                                tooltip: "Lihat Lokasi",
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 150),
            ],
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            _showAddPelangganDialog();
          },
          backgroundColor: AppTheme.primary,
          elevation: 6,
          child: const Icon(Icons.add, size: 28, color: AppTheme.cream),
        ),
      ),
    );
  }

  Widget buildShimmerItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 120,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 80, height: 14, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 100, height: 14, color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPelangganDialog({String? idPelanggan}) {
    Paket? selectedPaket;
    String? idPaketAwal;
    TextEditingController nameController = TextEditingController();
    TextEditingController nohpController = TextEditingController();
    TextEditingController noKtpController = TextEditingController();
    TextEditingController userPpoeController = TextEditingController();
    TextEditingController pasPpoeController = TextEditingController();
    TextEditingController latController = TextEditingController();
    TextEditingController longController = TextEditingController();
    TextEditingController alamatController = TextEditingController();

    if (idPelanggan != null) {
      final existingPelanggan = pelangganController.pelanggans.firstWhere(
        (pelanggan) => pelanggan.no == idPelanggan,
        orElse: () => pelangganController.pelanggans.first,
      );

      selectedPaket = controller.pakets.firstWhere(
        (paket) => paket.idpaket == existingPelanggan.idPaketPppoe,
        orElse: () => controller.pakets.first,
      );
      idPaketAwal = existingPelanggan.idPaketPppoe;

      nameController.text = existingPelanggan.namaPelanggan ?? "";
      nohpController.text = existingPelanggan.noHp ?? "";
      noKtpController.text = existingPelanggan.noKtp ?? "";
      userPpoeController.text = existingPelanggan.userPppoe ?? "";
      pasPpoeController.text = existingPelanggan.passPppoe ?? "";
      latController.text = existingPelanggan.lat ?? "";
      longController.text = existingPelanggan.longitude ?? "";
      alamatController.text = existingPelanggan.alamat ?? "";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,
            right: 10,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            idPelanggan == null
                                ? "Tambah Pelanggan Baru"
                                : "Edit Pelanggan",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.nearlyBlack,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        _buildInputField("Nama Pelanggan", nameController),
                        _buildInputField(
                          "No HP",
                          nohpController,
                          keyboardType: TextInputType.phone,
                        ),
                        _buildInputField(
                          "No KTP",
                          noKtpController,
                          keyboardType: TextInputType.phone,
                        ),
                        _buildInputField("Username PPPoE", userPpoeController),
                        _buildInputField("Password PPPoE", pasPpoeController),
                        Text("Koordinat Lokasi", style: _labelStyle),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: latController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: _dropdownStyle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: longController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: _dropdownStyle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: () async {
                                final posisi =
                                    await pelangganController
                                        .ambilLokasiSekarang();
                                if (posisi != null) {
                                  latController.text =
                                      posisi.latitude.toString();
                                  longController.text =
                                      posisi.longitude.toString();
                                }
                              },
                            ),
                          ],
                        ),

                        _buildInputField("Alamat", alamatController),

                        const SizedBox(height: 10),
                        Text("Pilih Paket", style: _labelStyle),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<Paket>(
                            isExpanded: true,
                            value: selectedPaket,
                            items:
                                controller.pakets.map((paket) {
                                  return DropdownMenuItem<Paket>(
                                    value: paket,
                                    child: Text(
                                      paket.namapaket ?? "-",
                                      style: _dropdownStyle,
                                    ),
                                  );
                                }).toList(),
                            onChanged: (Paket? newValue) {
                              setState(() {
                                selectedPaket = newValue;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.5),
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              scrollbarTheme: const ScrollbarThemeData(
                                thickness: WidgetStatePropertyAll(4),
                                thumbColor: WidgetStatePropertyAll(
                                  AppTheme.primaryFont,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DialogButton(
                              fontColor: AppTheme.primary,
                              splashColor: AppTheme.cream,
                              borderColor: AppTheme.primary,
                              title: 'Batal',
                              height: 30,
                              width: 100,
                              font: 14,
                              color: Colors.white,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            DialogButton(
                              splashColor: AppTheme.primary,
                              title: 'Submit',
                              height: 30,
                              width: 100,
                              font: 14,
                              fontColor: Colors.white,
                              borderColor: AppTheme.primary,
                              color: AppTheme.primary,
                              onPressed: () async {
                                showProcessingDialog();
                                bool status;

                                if (idPelanggan == null) {
                                  status = await pelangganController
                                      .addPelanggan(
                                        selectedPaket?.idpaket ?? "",
                                        nameController.text,

                                        noKtpController.text,
                                        nohpController.text,
                                        userPpoeController.text,
                                        pasPpoeController.text,
                                        latController.text,
                                        longController.text,
                                        alamatController.text,
                                        dashboardController
                                                .selectedRouter
                                                .value
                                                ?.idpenjualan ??
                                            "",
                                      );
                                } else {
                                  status = await pelangganController
                                      .editPelanggan(
                                        nameController.text,
                                        noKtpController.text,
                                        nohpController.text,
                                        userPpoeController.text,
                                        pasPpoeController.text,
                                        latController.text,
                                        longController.text,
                                        alamatController.text,
                                        idPelanggan,
                                      );
                                }
                                if (selectedPaket?.idpaket != idPaketAwal) {
                                  await pelangganController.editPelangganPaket(
                                    selectedPaket?.idpaket ?? "",
                                    idPelanggan ?? "",
                                  );
                                }

                                if (status) {
                                  showSuksesDialog(
                                    context,
                                    () async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      await pelangganController.getPelanggan(
                                        dashboardController
                                                .selectedRouter
                                                .value
                                                ?.idpenjualan ??
                                            "",
                                      );
                                    },
                                    idPelanggan == null
                                        ? "Pelanggan ditambahkan"
                                        : "Pelanggan diperbarui",
                                  );
                                } else {
                                  showFailedDialog(
                                    context,
                                    "Gagal menyimpan pelanggan.",
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Helper untuk membuat TextField
  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: _dropdownStyle,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  final TextStyle _labelStyle = TextStyle(
    fontSize: 13,
    color: AppTheme.nearlyBlack,
  );
  final TextStyle _dropdownStyle = TextStyle(
    fontSize: 13,
    color: AppTheme.nearlyBlack,
  );

  void showProcessingDialog() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const ProcessingDialog();
      },
    );
  }

  void showSuksesDialog(
    BuildContext context,
    VoidCallback ontap,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SuksesDialogWidget(text: message, ontap: ontap, title: 'Tutup');
      },
    );
  }

  void showFailedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          message: message,
          ontap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
