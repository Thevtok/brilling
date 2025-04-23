// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/custom_button.dart';
import 'package:flutter_application_1/component/dialog.dart';
import 'package:flutter_application_1/component/textfield.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/utils/data_local.dart';
import 'package:flutter_application_1/view/auth/otp_page.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class ResgisterPage extends StatefulWidget {
  const ResgisterPage({super.key});

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final nameUsahaController = TextEditingController();
  final phoneController = TextEditingController();

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Register',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/images/bgregister.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
          
                EntryField(
                  keyboardType: TextInputType.text,
                  title: 'Nama',
                  hint: '',
                  controller: nameController,
                  icon: CupertinoIcons.person_crop_circle,
                ),
                const SizedBox(height: 10),
                // EntryField(
                //   keyboardType: TextInputType.text,
                //   title: 'Nama Usaha',
                //   hint: '',
                //   controller: nameUsahaController,
                //   icon: CupertinoIcons.shopping_cart,
                // ),
                const SizedBox(height: 10),
                EntryField(
                  keyboardType: TextInputType.text,
                  title: 'Email',
                  hint: '',
                  controller: emailController,
                  icon: CupertinoIcons.mail_solid,
                ),
                const SizedBox(height: 10),
                EntryField(
                  keyboardType: TextInputType.number,
                  title: 'No Hp',
                  hint: '',
                  controller: phoneController,
                  icon: CupertinoIcons.phone,
                ),
                const SizedBox(height: 10),
          
                const SizedBox(height: 30),
                CustomButton(
                  splashColor: AppTheme.primary,
                  title: 'Register',
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
          
                    bool status = await auth.register(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                    );
                    if (status == true) {
                      showSuksesDialog(context, () async {
                        var userId = await getUserIdFromSharedPreferences();
                        emailController.clear();
                        phoneController.clear();
                        nameController.clear();
                        saveAuthentication(true);
                        await auth.sendOtp(userId??'', emailController.text);
                        Get.to(() => OtpPage(userId: userId ?? '',email: emailController.text,));
                      }, 'Register berhasil');
                    } else {
                      showFailedDialog(context, 'Register gagal');
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
