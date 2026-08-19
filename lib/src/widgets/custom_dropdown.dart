import 'package:flutter/material.dart';
import 'package:meditrack_admin/src/core/themes/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final bool isColorChange;
  final String hintValue;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.hintValue,
    required this.onChanged,
    this.isColorChange=false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        validator: validator,
        decoration: const InputDecoration(

            errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide:  BorderSide(color: Colors.red, width: 0.0),
            ),
            errorStyle: TextStyle(fontSize: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0,),
              ),
              borderSide:  BorderSide(color: Colors.grey,width: 0),
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(
        Radius.circular(8.0),
    ),
    )),
        iconEnabledColor: AppColor.buttonColor,
        dropdownColor: Colors.white,
        iconDisabledColor: AppColor.buttonColor,
        value: selectedValue.isEmpty ? null : selectedValue,
        hint: Text(hintValue, style: TextStyle(color: AppColor.greyColor,fontSize: 14),),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        focusColor: Colors.grey,

        onChanged: onChanged,
      ),
    );
  }
}
