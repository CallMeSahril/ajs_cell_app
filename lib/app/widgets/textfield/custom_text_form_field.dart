import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        TextFormField(
                controller: controller,
                readOnly: readOnly,
                decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
                ),
        ),
      ],
    );
  }
}
