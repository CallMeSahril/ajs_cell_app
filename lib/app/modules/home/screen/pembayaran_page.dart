import 'package:ajs_cell_app/app/modules/home/screen/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: ListView(
          children: [
            UserChekout(),
            Container(
              child: Column(
                children: [
                  Text("Paymnet"),
                  Container(),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text("Pilih Metode Pengiriman"),
                  Row(
                    children: [Text("Order:"), Text("Rp 20.000s")],
                  ),
                  Row(
                    children: [Text("Order:"), Text("Rp 20.000s")],
                  ),
                  Row(
                    children: [Text("Order:"), Text("Rp 20.000s")],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              // Get.to(() => CheckoutPage());
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "SUBMIT ORDER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}
