import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/model/tagihan.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTagihan extends StatelessWidget {
  final Tagihan tagihan;
  final VoidCallback? onTapEdit; 

  const ListTagihan({
    super.key,
    required this.tagihan,
    this.onTapEdit, 
  });


  Color getStatusColor(String status) {
    switch (status) {
      case '1':
        return Colors.green;
      case '0':
        return Colors.orange;
         case '2':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String getStatusName(String status) {
    switch (status) {
      case '0':
        return 'Belum Bayar';
      case '1':
        return 'Lunas';
        case '2':
        return 'Suspend';

      default:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Informasi Pembayaran**
            _buildDetailRow("# INV-", tagihan.noinvoice),
            _buildDetailRow("ID Pelanggan", tagihan.idpelangganppoe),

            _buildDetailRow("PPN", "Rp ${tagihan.ppn}"),
            _buildDetailRow("Total", "Rp ${tagihan.hargainvoice}"),
            _buildDetailRow("Tanggal", tagihan.tglinvoice),

            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Status Pembayaran",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(tagihan.status ?? ""),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    getStatusName(tagihan.status ?? "").toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

           const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onTapEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                label: Text(
                  "Edit",
                 style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showProcessingDialog(BuildContext context) async {
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

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
          ),
          const Spacer(),
          Text(value ?? "-", style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }
}
