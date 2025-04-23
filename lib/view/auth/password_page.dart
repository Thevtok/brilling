import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_application_1/view/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfield.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                  'Confirm Password',
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
            
                PasswordField(title: 'Password', controller: passwordController),
                const SizedBox(height: 10),
                PasswordField(
                  title: 'Confirm Password',
                  controller: confirmPasswordController,
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
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      showFailedDialogs(
                        context,
                        'Password tidak sama',
                      );
                      return;
                    }
                    _formKey.currentState!.save();
                    showProcessingDialog();
                    var username = await getUsernameFromSharedPreferences();
            
                    bool status = await auth.inputPassword(
                      username??'',
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                    if (status == true) {
                      showSuksesDialog(context, () {
                        passwordController.clear();
                        confirmPasswordController.clear();
                        Get.offAll(() => const LoginScreen());
                      }, 'Password berhasil disimpan');
                    } else {
                      showFailedDialog(context, 'Password gagal disimpan');
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
  void showFailedDialogs(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          message: message,
          ontap: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
