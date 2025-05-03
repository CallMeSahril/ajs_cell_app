import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            spacing: 20,
            children: [
              CustomButton(
                type: ButtonType.blue,
                text: "Voucher",
                onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                  'title': 'Voucher',
                }),
              ),
              CustomButton(
                type: ButtonType.blue,
                text: "Kartu",
                onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                  'title': 'Kartu',
                }),
              ),
              CustomButton(
                type: ButtonType.blue,
                text: "Aksesoris",
                onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                  'title': 'Aksesoris',
                }),
              ),
              CustomButton(
                type: ButtonType.blue,
                text: "Perlengkapan Hp",
                onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                  'title': 'Perlengkapan Hp',
                }),
              ),
              CustomButton(
                type: ButtonType.blue,
                text: "Bibit Parfum",
                onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                  'title': 'Bibit Parfum',
                }),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
