import 'package:flutter/material.dart';

class CustomTextField {
  static textFeild({
    String? labelText,
    int? maxLines,
    TextEditingController? controller,

  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusColor: Color.fromRGBO(109, 112, 114, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromRGBO(109, 112, 114, 1), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromRGBO(109, 112, 114, 1),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(left: 14.0, top: 12, bottom: 11),
      ),
      maxLines: maxLines,
    );
  }
}
