import 'package:flutter/material.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (route) => false);


Widget defaultTextFormField({
  required TextEditingController controller,
  required String? Function(String? value) validator,
  required TextInputType inputType,
  required String hint,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String s)? onSubmit,
  bool isPassword = false,
  int? max,
  bool enable = true,
}) =>
    TextFormField(
      maxLines: max,
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:  const TextStyle(
          color: Colors.white,
        ),
        suffixIcon: IconButton(icon: Icon(suffix),color: Colors.white, onPressed: onSuffixPressed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:  const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:  const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide:  const BorderSide(color: Colors.white),
        ),
      ),
      validator: validator,
    );