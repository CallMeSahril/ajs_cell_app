import 'package:ajs_cell_app/app/modules/home/screen/pembayaran_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
                  Text("Produk"),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        color: Colors.amber,
                      ),
                      Column(
                        children: [
                          Text("Case Hp Infinix smart 8"),
                          Text("Deskripsi : Bahan karet Harga Rp20.000 ")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text("Pilih Metode Pembayaran"),
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
              Get.to(() => PembayaranPage());
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

class UserChekout extends StatelessWidget {
  const UserChekout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("ALamat Pengiriman"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Jane Doe"), Text("Change")],
              ),
              Text("3 Newbridge Court Chino \n Hills, CA 91709, United States")
            ],
          ),
        ],
      ),
    );
  }
}
