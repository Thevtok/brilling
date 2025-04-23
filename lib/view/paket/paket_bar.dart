// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/component/empty.dart';
import 'package:flutter_application_1/controller/dashboard_controller.dart';
import 'package:flutter_application_1/controller/paket_controller.dart';
import 'package:flutter_application_1/model/paket.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/pool.dart';

class PaketBar extends StatefulWidget {
  const PaketBar({super.key});

  @override
  State<PaketBar> createState() => _PaketBarState();
}

class _PaketBarState extends State<PaketBar> {
  final controller = Get.put(PaketController());
  final dashboardController = Get.put(DashboardController());

  List<String> kecepatanList = [
    "1M/1M",
    "2M/1M",
    "3M/1M",
    "5M/2M",
    "5M/5M",
    "10M/3M",
    "10M/5M",
    "10M/10M",
    "20M/10M",
    "30M/10M",
    "50M/20M",
    "100M/50M",
  ];
  String _selectedType = "";
  Paket? _selectedPaket;

  @override
  void initState() {
    super.initState();
    controller.getPaket(
      dashboardController.selectedRouter.value?.idpenjualan ?? "",
    );
    dashboardController.getPool();
    _selectedType = kecepatanList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paket',
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
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.pakets.isEmpty) {
          return const EmptyPage(type: 'paket');
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.pakets.length,
                itemBuilder: (context, index) {
                  final paket = controller.pakets[index];

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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone_android,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  paket.namapaket ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Harga: Rp ${paket.hargapaket ?? 0}',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                'Rate: ${paket.kecepatan ?? ''}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.primary,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: AppTheme.primary,
                              ),
                              onPressed: () {
                                _showAddPackageDialog(paketId: paket.idpaket);
                              },
                              tooltip: "Edit Paket",
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
            _showAddPackageDialog();
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

  void _showAddPackageDialog({String? paketId}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    Pool? selectedPool;

    if (paketId != null) {
      final existingPackage = controller.pakets.firstWhere(
        (paket) => paket.idpaket == paketId,
        orElse: () => controller.pakets.first,
      );
         selectedPool = dashboardController.pools.firstWhere(
        (paket) => paket.idippool == existingPackage.idippool,
        orElse: () => dashboardController.pools.first,
      );

      _selectedPaket = existingPackage;
      nameController.text = _selectedPaket?.namapaket ?? "";
      priceController.text = _selectedPaket?.hargapaket ?? "";
    } else {
      _selectedPaket = null;
      nameController.text = "";
      priceController.text = "";
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
              return SingleChildScrollView(
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
                          paketId == null ? "Tambah Paket Baru" : "Edit Paket",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Nama Paket',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Profile Paket',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          value: _selectedType,

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
                          items:
                              kecepatanList.map((String speed) {
                                return DropdownMenuItem<String>(
                                  value: speed,
                                  child: Text(
                                    speed,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.nearlyBlack,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedType = newValue ?? "";
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Daftar Pool',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<Pool>(
                          isExpanded: true,
                          value: selectedPool,
                          items:
                              dashboardController.pools.map((paket) {
                                return DropdownMenuItem<Pool>(
                                  value: paket,
                                  child: Text(
                                    paket.namapool ?? "-",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.nearlyBlack,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (Pool? newValue) {
                            setState(() {
                              selectedPool = newValue;
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
                      const SizedBox(height: 10),

                      Text(
                        'Harga Paket',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),

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
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
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
                              if (paketId == null) {
                                status = await controller.addPaket(
                                  nameController.text,
                                  _selectedType,
                                  priceController.text,
                                  dashboardController
                                          .selectedRouter
                                          .value
                                          ?.idpenjualan ??
                                      "",
                                  selectedPool?.idippool ?? "",
                                );
                              } else {
                                status = await controller.editPaket(
                                  nameController.text,
                                  _selectedType,
                                  priceController.text,
                                  paketId,
                                  dashboardController
                                          .selectedRouter
                                          .value
                                          ?.idpenjualan ??
                                      "",
                                  selectedPool?.idippool ?? "",
                                );
                              }
                              if (status == true) {
                                showSuksesDialog(
                                  context,
                                  () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                    await controller.getPaket(
                                      dashboardController
                                              .selectedRouter
                                              .value
                                              ?.idpenjualan ??
                                          "",
                                    );
                                  },
                                  paketId == null
                                      ? "Paket berhasil di buat"
                                      : "Paket berhasil di update",
                                );
                              } else {
                                showFailedDialog(
                                  context,
                                  'Paket gagal di buat',
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
              );
            },
          ),
        );
      },
    );
  }

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
