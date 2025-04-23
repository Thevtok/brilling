import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final double font;
  final Color color;
  final Color splashColor; 
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.font,
    required this.color,
    required this.splashColor, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: font,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final double font;
  final Color color;
  final Color splashColor;
  final Color fontColor;
  final Color borderColor; 
  final VoidCallback? onPressed;

  const DialogButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.font,
    required this.color,
    required this.splashColor,
    required this.fontColor, 
    required this.borderColor, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: font,
                fontWeight: FontWeight.w600,
                color: fontColor, 
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
