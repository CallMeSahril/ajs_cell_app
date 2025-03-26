import 'package:flutter/material.dart';

enum ButtonType { blue, grey }

class CustomButton extends StatelessWidget {
  final ButtonType type;
  final String text;
  final Function()? onTap;
  const CustomButton(
      {super.key, required this.type, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color buttonColor = type == ButtonType.blue
        ? const Color(0xff0245A3)
        : const Color(0xffD9D9D9);
    Color textColor = type == ButtonType.blue ? Colors.white : Colors.black;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
