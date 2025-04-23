import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class ProcessingDialog extends StatelessWidget {
  const ProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      content: Lottie.asset('assets/lottie/loading.json',width: 100,height: 100),
    );
  }
}

class SuksesDialogWidget extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final String title;

  const SuksesDialogWidget(
      {super.key,
      required this.text,
      required this.ontap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selamat",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black.withValues(alpha: 0.7),
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            ontap();
          },
          child: CustomButton(
            splashColor: AppTheme.primary,
            title: title,
            width: 80,
            height: 40,
            font: 14,
            color: Colors.blue[900]!,
          ),
        ),
      ],
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final String message;
  final VoidCallback ontap;

  const AlertDialogWidget({super.key, required this.message, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Gagal",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.black.withValues(alpha: 0.7),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            ontap();
           
          },
          child:  CustomButton(
              splashColor: AppTheme.primary,
            title: 'Tutup',
            width: 80,
            height: 40,
            font: 14,
              color: Colors.blue[900]!,
          ),
        ),
      ],
    );
  }
}