import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_application_1/view/auth/otp_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfield.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  final auth = Get.put(AuthController());

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Confirm Email',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/images/bgpassword.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),

                SizedBox(height: 20),

                EntryField(
                  keyboardType: TextInputType.text,
                  title: 'Email',
                  hint: '',
                  controller: emailController,
                  icon: CupertinoIcons.mail_solid,
                ),

                SizedBox(height: 40),
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
                    await saveUsernameToSharedPreferences(emailController.text);

                    _formKey.currentState!.save();
                    showProcessingDialog();

                    // var username = await getUsernameFromSharedPreferences();

                    bool status = await auth.sendOtp('', emailController.text);
                    if (status == true) {
                      showSuksesDialog(context, () {
                      }, 'Kirim OTP berhasil ');
                         Get.to(() => OtpPage(userId:'',email: emailController.text,));
                    } else {
                      showFailedDialog(context, 'Kirim OTP gagal ');
                    }
                  },
                ),
              ],
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
