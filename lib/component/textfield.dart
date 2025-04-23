
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class EntryField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final FormFieldValidator<String>?
      validator; 
  final TextInputType keyboardType;

  const EntryField({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    required this.icon,
    this.validator,
    required this.keyboardType,
  });

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.nearlyBlack,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 60, 
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
              ],
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              style: GoogleFonts.poppins(
          fontSize: 16,
          color: AppTheme.nearlyBlack,
              ),
              keyboardType: widget.keyboardType,
              validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return '${widget.title} harus diisi';
              }
              return null;
            },
              decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              Icon(widget.icon, size: 24, color: AppTheme.primary), 
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 30,
                width: 1.5,
                color: AppTheme.primary,
              ),
              const SizedBox(width: 10),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: 15), 
              ),
            ),
          ),
        ],
      ),

    );
  }
}
class PasswordField extends StatefulWidget {
  final String title;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.nearlyBlack,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 60, 
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              style: GoogleFonts.roboto(
                fontSize: 16, 
                color: AppTheme.nearlyBlack,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password harus diisi';
                }
                
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(vertical: 20), 
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.lock, size: 24, color: AppTheme.primary), 
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppTheme.primary,
                    size: 24, 
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
