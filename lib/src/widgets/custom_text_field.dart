import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/core/themes/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isOptional;
  final bool isColorChange;
  final bool isNumber;
  final bool isObscureText;
  final int maxLength;
  final int? maxLines;
  final Widget? suffixWidget;
  final Function(String)? onChanged;
  final bool readOnly;
  final void Function()? onClick;
  final String? Function(String?)? validator;


  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isOptional = false,
    this.isNumber = false,
    this.isColorChange = false,
    this.isObscureText = false,
    this.maxLength = 200,
    this.suffixWidget,
    this.onChanged,
    this.readOnly=false,
    this.validator,
    this.onClick,
    this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength), // ✅ Limits input length
      ],
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onClick,
      obscureText: isObscureText,
      decoration: InputDecoration(
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:  BorderSide(color: Colors.red, width: 0.0),
        ),
        suffixIcon: suffixWidget,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.greyColor,fontSize: 14,fontStyle: GoogleFonts.inter().fontStyle,fontWeight: FontWeight.w400),
        suffixText: isOptional ? "Optional" : null,
        suffixStyle: TextStyle(color: Colors.green, fontStyle: GoogleFonts.inter().fontStyle,fontWeight: FontWeight.w400),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:isColorChange==true ? AppColor.greenBorderColor : AppColor.greyColor, width: 1,), // ✅ Highlight when focused
        ),
        constraints: const BoxConstraints(maxHeight: 70, minHeight: 35),
        isDense: true,
        contentPadding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius:  BorderRadius.circular(8),
          borderSide: BorderSide(color: isColorChange==true ? AppColor.greenBorderColor :AppColor.borderColor, width: 1), // ✅ Normal border
        ),
        errorStyle: TextStyle(fontSize: 10),
      ),
    );
  }
}
