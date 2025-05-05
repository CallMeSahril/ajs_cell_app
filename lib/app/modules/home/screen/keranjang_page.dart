import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final KeranjangController controller = Get.find<KeranjangController>();
  List<CartEntities> allCart = [];
  bool isLoading = false;
  @override
  void initState() {
    initBeranda();
    super.initState();
  }

  initBeranda() async {
    setState(() {
      isLoading = true;
    });
    try {
      await controller.getCategoryProductAll();

      setState(() {
        allCart = controller.cart;
      });
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   'Failed to load profile: $e',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff0F6CBD),
          title: Text(
            "Keranjang",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Pemesanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allCart.length,
                itemBuilder: (context, index) {
                  final result = allCart[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Color(0xffDBDADA),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.check_box_outline_blank),
                          Container(
                            height: 50,
                            width: 50,
                            color: Colors.blue,
                          ),
                          Column(
                            spacing: 8,
                            children: [
                              Text(
                                  "${result.product?.name?.toUpperCase()} - ${result.productCart?.type?.toUpperCase()}"),
                              Text("${result.productCart?.price}"),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff0F6CBD),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${result.quantity}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            spacing: 10,
                            children: [
                              Text("Ubah"),
                              Icon(Icons.delete),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              Get.to(() => CheckoutPage());
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "Checkout (0)",
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
