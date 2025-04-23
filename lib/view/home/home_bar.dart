import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/perangkat_modal.dart';
import 'package:flutter_application_1/controller/dashboard_controller.dart';
import 'package:flutter_application_1/controller/pelanggan_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:flutter_application_1/view/home/article_carousel.dart';
import 'package:flutter_application_1/view/home/list_perangkat.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/penjualan.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  bool _obscureText = true;
  String formatRupiah(int number) {
    return 'Rp${NumberFormat('#,###').format(number)}';
  }

  final dashboardController = Get.put(DashboardController());
  final pelangganController = Get.put(PelangganController());
  @override
  void initState() {
    super.initState();
    initDashboard();
  }
  void initDashboard() async {
  await dashboardController.getPenjualan(); 
  final selected = dashboardController.selectedRouter.value;
  if (selected != null) {
    await pelangganController.getPelanggan(selected.idpenjualan??"");
  }
}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTheme.bgscafold,
      body: RefreshIndicator(
        onRefresh: () async {
          dashboardController.getPenjualan();
        },
        child: Scrollbar(
          thumbVisibility: false,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(color: AppTheme.primary),
                ),
                Positioned(
                  top: 25,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Logout"),
                              content: const Text("Yakin ingin keluar?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    saveAuthentication(false);
                                    Get.offAll(
                                      () =>
                                          const SplashScreen(isLoggedIn: false),
                                    );
                                  },
                                  child: const Text("Logout"),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: height * 0.1,
                  ),
                  child: Column(
                    children: [
                      Obx(() {
                        final selected =
                            dashboardController.selectedRouter.value;
                        final pelanggan =
                            pelangganController.totalPelanggan.value;

                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Perangkat Aktif',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.router,
                                            size: 18,
                                            color: AppTheme.primary,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            selected?.namarouter ??
                                                'Belum dipilih',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppTheme.primaryFont,
                                    ),
                                    onPressed: () async {
                                      final result =
                                          await showModalBottomSheet<Penjualan>(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                            ),
                                            builder:
                                                (_) => PilihPerangkatModal(
                                                  penjualans:
                                                      dashboardController
                                                          .penjualans,
                                                ),
                                          );

                                      if (result != null) {
                                        dashboardController
                                            .selectedRouter
                                            .value = result;
                                        await pelangganController.getPelanggan(
                                          result.idpenjualan ?? "",
                                        );
                                      }
                                    },

                                    icon: const Icon(Icons.sync_alt, size: 18),
                                    label: const Text('Ganti'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(25),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7.5,
                                  horizontal: 10,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 1,
                                        height: 70,
                                        color: AppTheme.primaryFont,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Total Pendapatan',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _obscureText
                                                        ? '*******'
                                                        : formatRupiah(50000),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      _obscureText
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color:
                                                          AppTheme.primaryFont,
                                                      size: 22,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _obscureText =
                                                            !_obscureText;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                'Total Pelanggan',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    pelanggan.toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.people,
                                                    color: AppTheme.primaryFont,
                                                    size: 22,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      SizedBox(height: 30),
                      Obx(() {
                        if (dashboardController.isLoading.value) {
                          return const PoolListShimmer();
                        }

                        return PenjualanListWidget(
                          penjualans: dashboardController.penjualans,
                        );
                      }),

                      SizedBox(height: 20),
                      ArticleCarousel(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
