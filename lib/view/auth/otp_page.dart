import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/view/auth/password_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../component/custom_button.dart';

class OtpPage extends StatefulWidget {
  final String userId;
  final String email;
  const OtpPage({super.key, required this.userId, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Verification',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/bgotp.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
            
                  SizedBox(height: 20),
                  Text(
                    'Masukan kode otp yang telah anda terima',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 20),
            
                  PinCodeTextField(
                    appContext: context,
                    length: 5,
                    controller: otpController,
                    animationType: AnimationType.fade,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor: AppTheme.primary,
                      inactiveColor: Colors.grey,
                      selectedColor: AppTheme.secondary,
                    ),
                    onChanged: (value) {},
                  ),
            
                  SizedBox(height: 20),
                  CustomButton(
                    splashColor: AppTheme.primary,
                    title: 'Submit',
                    height: 50,
                    width: 200,
                    font: 20,
                    color: AppTheme.secondary,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        // Navigator.of(context).pop();
                        return;
                      }
                      _formKey.currentState!.save();
                      showProcessingDialog();
            
                      bool status = await auth.inputOtp(
                      widget.userId,
                        otpController.text,
                      );
                      if (status == true) {
                        showSuksesDialog(context, () {
                          otpController.clear();
                         
                          Get.to(() => PasswordPage());
                        }, 'Validate OTP berhasil');
                      } else {
                        showFailedDialog(context, 'OTP salah!');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
        return SuksesDialogWidget(text: message, ontap: ontap, title: 'Masuk');
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
