import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/penjualan.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme.dart';

class PenjualanListWidget extends StatelessWidget {
  final List<Penjualan> penjualans;

  const PenjualanListWidget({super.key, required this.penjualans});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Daftar Perangkat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: penjualans.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final penjualan = penjualans[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(  Icons.router, color: AppTheme.primary),
                  ),
                  title: Text(
                    penjualan.namarouter ?? "-",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('(${penjualan.iprouter ?? ""})')],
                  ),
                  trailing: Chip(
                    label: Text(
                      penjualan.status ?? 'Status?',
                      style: TextStyle(
                        color:
                            (penjualan.status?.toLowerCase() == "aktif")
                                ? Colors.green
                                : const Color.fromARGB(255, 185, 11, 11),
                      ),
                    ),
                    backgroundColor: Colors.grey.shade200,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PoolListShimmer extends StatelessWidget {
  const PoolListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Daftar Perangkat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Divider(),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              padding: EdgeInsets.all(0),

              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    title: Container(
                      height: 10,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    subtitle: Container(height: 10, color: Colors.white),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
