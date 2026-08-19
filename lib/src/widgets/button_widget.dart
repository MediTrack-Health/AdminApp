import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/core/themes/app_color.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
        required this.onPressed,
        required this.text,
        this.color,
        this.borderColor,
        this.textColor,
        this.fontSize,
        this.width,
        this.height,
        this.fontWeight,
        this.borderRadius,
        this.fontFamily,
        this.borderwidth});

  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? borderwidth;
  final double? width;
  final double? fontSize;
  final double? borderRadius;
  final double? height;
  final FontWeight? fontWeight;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 56,
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(width ?? MediaQuery.of(context).size.width, height ?? 65)),
            backgroundColor:
            MaterialStateProperty.all<Color>(color ?? AppColor.buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                side: borderColor == null
                    ? BorderSide.none
                    : BorderSide(
                  color: borderColor!,
                  width: borderwidth ?? 1.0,
                ),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize ?? 24,
                fontWeight: FontWeight.w700,
                fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
                color: Colors.white),
          )),
    );
  }
}
