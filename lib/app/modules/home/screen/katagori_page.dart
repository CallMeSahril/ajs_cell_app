import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';

class KatagoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Katagori",style: TextStyle(color: Color(0xff0245A3),fontWeight: FontWeight.bold),),
        ),
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
                  ),
                  CustomButton(
                    type: ButtonType.blue,
                    text: "Kartu",
                  ),
                  CustomButton(
                    type: ButtonType.blue,
                    text: "Aksesoris",
                  ),
                  CustomButton(
                    type: ButtonType.blue,
                    text: "Perlengkapan Hp",
                  ),
                  CustomButton(
                    type: ButtonType.blue,
                    text: "Bibit Parfum",
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
