// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/component/textfield.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_application_1/view/auth/email_page.dart';
import 'package:flutter_application_1/view/auth/resgister_page.dart';
import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              children: [
                const SizedBox(height: 40),
                      
                Image.asset(
                  'assets/images/bglogin.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: 20),
                EntryField(
                  keyboardType: TextInputType.text,
                  title: 'Email',
                  hint: '',
                  controller: emailController,
                  icon: CupertinoIcons.mail_solid,
                ),
                const SizedBox(height: 10),
                PasswordField(title: 'Password', controller: passController),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      InkWell(
                        onTap: (){
                          Get.to(()=> EmailPage());
                        },
                        child: Text(
                          'Lupa Password ?',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                      
                const SizedBox(height: 30),
                CustomButton(
                  splashColor: AppTheme.primary,
                  title: 'Login',
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
                      
                    bool status = await auth.login(
                      emailController.text,
                      passController.text,
                    );
                    if (status == true) {
                      showSuksesDialog(context, () {
                        emailController.clear();
                        passController.clear();
                        saveAuthentication(true);
                        Get.offAll(
                          () => const SplashScreen(isLoggedIn: true),
                        );
                      }, 'Anda berhasil masuk');
                    } else {
                      showFailedDialog(context, 'Email atau password salah!');
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Belum memiliki akun ?',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ResgisterPage());
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
