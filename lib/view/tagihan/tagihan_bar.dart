// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/component/empty.dart';
import 'package:flutter_application_1/component/list_tagihan.dart';
import 'package:flutter_application_1/controller/dashboard_controller.dart';
import 'package:flutter_application_1/controller/pelanggan_controller.dart';
import 'package:flutter_application_1/controller/tagihan_controller.dart';
import 'package:flutter_application_1/model/pelanggan.dart';
import 'package:flutter_application_1/model/tagihan.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme.dart';

class TagihanBar extends StatefulWidget {
  const TagihanBar({super.key});

  @override
  State<TagihanBar> createState() => _TagihanBarState();
}

class _TagihanBarState extends State<TagihanBar> {
  final controller = Get.put(TagihanController());
  final dashboardController = Get.put(DashboardController());
  final pelangganController = Get.put(PelangganController());
  String formattedDate = DateTime.now().toIso8601String().split('T').first;

  @override
  void initState() {
    super.initState();
    controller.getTagihan(
      dashboardController.selectedRouter.value?.idpenjualan ?? "",
      formattedDate,
    );
    pelangganController.getPelanggan(
      dashboardController.selectedRouter.value?.idpenjualan ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tagihan',
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
              controller.getTagihan(
                dashboardController.selectedRouter.value?.idpenjualan ?? "",
                formattedDate,
              );
              pelangganController.getPelanggan(
                dashboardController.selectedRouter.value?.idpenjualan ?? "",
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.tagihans.isEmpty) {
          return Column(
            children: [
               SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TagihanFilter(
                    onDateSelected: (String tgl) {
                      controller.getTagihan(
                        dashboardController.selectedRouter.value?.idpenjualan ?? "",
                        tgl,
                      );
                    },
                  ),),),
              const EmptyPage(type: 'tagihan'),
            ],
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TagihanFilter(
                    onDateSelected: (String tgl) {
                      controller.getTagihan(
                        dashboardController.selectedRouter.value?.idpenjualan ?? "",
                        tgl,
                      );
                    },
                  ),
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.tagihans.length,
                itemBuilder: (context, index) {
                  final paket = controller.tagihans[index];

                  return ListTagihan(
                    tagihan: paket,
                    onTapEdit: () {
                      _showAddPackageDialog(idInvoice: paket.no);
                    },
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

  Tagihan? _selectedTagihan;

  void _showAddPackageDialog({String? idInvoice}) {
    TextEditingController tglController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController statusController = TextEditingController();
    TextEditingController ppnController = TextEditingController();
    DateTime? selectedDate;

    Pelanggan? selectedPelanggan;
    String? selectedStatus;
    final List<String> statusList = ["Belum Bayar", "Lunas", "Suspend"];
    final List<String> statusValues = ["0", "1", "2"];

    if (idInvoice != null) {
      final existingPackage = controller.tagihans.firstWhere(
        (paket) => paket.no == idInvoice,
        orElse: () => controller.tagihans.first,
      );
      selectedPelanggan = pelangganController.pelanggans.firstWhere(
        (paket) => paket.no == existingPackage.idpelangganppoe,
        orElse: () => pelangganController.pelanggans.first,
      );
      selectedStatus = existingPackage.status ?? "";

      _selectedTagihan = existingPackage;
      tglController.text = _selectedTagihan?.tglinvoice ?? "";
      priceController.text = _selectedTagihan?.hargainvoice ?? "";
      statusController.text = _selectedTagihan?.status ?? "";
      ppnController.text = _selectedTagihan?.ppn ?? "";
    } else {
      _selectedTagihan = null;
      tglController.text = "";
      priceController.text = "";
      statusController.text = '';
      ppnController.text = '';
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
                          idInvoice == null
                              ? "Tambah Tagihan Baru"
                              : "Edit Tagihan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Harga Invoice',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: priceController,
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
                        'Daftar Pelanggan',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<Pelanggan>(
                          isExpanded: true,
                          value: selectedPelanggan,
                          items:
                              pelangganController.pelanggans.map((paket) {
                                return DropdownMenuItem<Pelanggan>(
                                  value: paket,
                                  child: Text(
                                    paket.namaPelanggan ?? "-",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.nearlyBlack,
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (Pelanggan? newValue) {
                            setState(() {
                              selectedPelanggan = newValue;
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
                        'PPN',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      TextField(
                        controller: ppnController,
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
                      Text(
                        'Tanggal Invoice',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                              tglController.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(picked);
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: tglController,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.nearlyBlack,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Pilih tanggal',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: List.generate(statusList.length, (index) {
                          final isSelected =
                              selectedStatus == statusValues[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStatus = statusValues[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.blue.shade100
                                        : Colors.grey.shade200,
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                statusList[index],
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      isSelected
                                          ? Colors.blue.shade900
                                          : AppTheme.nearlyBlack,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }),
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
                              if (idInvoice == null) {
                                status = await controller.addTagihan(
                                  selectedPelanggan?.no ?? "",
                                  priceController.text,
                                  tglController.text,
                                  selectedStatus ?? "",
                                  ppnController.text,
                                );
                              } else {
                                status = await controller.editTagihan(
                                  idInvoice,
                                  priceController.text,
                                  tglController.text,
                                  selectedStatus ?? "",
                                  ppnController.text,
                                );
                              }
                              if (status == true) {
                                showSuksesDialog(
                                  context,
                                  () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                    await controller.getTagihan(
                                      dashboardController
                                              .selectedRouter
                                              .value
                                              ?.idpenjualan ??
                                          "",
                                      formattedDate,
                                    );
                                  },
                                  idInvoice == null
                                      ? "Tagihan berhasil di buat"
                                      : "Tagihan berhasil di update",
                                );
                              } else {
                                showFailedDialog(
                                  context,
                                  'Tagihan gagal di buat',
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

class TagihanFilter extends StatefulWidget {
  final Function(String) onDateSelected;
  const TagihanFilter({super.key, required this.onDateSelected});

  @override
  State<TagihanFilter> createState() => _TagihanFilterState();
}

class _TagihanFilterState extends State<TagihanFilter> {
  DateTime? selectedDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      final formatted = formatter.format(picked);
      widget.onDateSelected(formatted); // kirim ke parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              selectedDate != null
                  ? formatter.format(selectedDate!)
                  : 'Pilih Tanggal',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
