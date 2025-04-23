import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/penjualan.dart';

class PilihPerangkatModal extends StatelessWidget {
  final List<Penjualan> penjualans;

  const PilihPerangkatModal({
    super.key,
    required this.penjualans,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: penjualans.length,
      itemBuilder: (context, index) {
        final router = penjualans[index];
        return ListTile(
          leading: const Icon(Icons.router),
          title: Text(router.namarouter ?? 'Tanpa Nama'),
          onTap: () {
            Navigator.pop(context, router);
          },
        );
      },
    );
  }
}