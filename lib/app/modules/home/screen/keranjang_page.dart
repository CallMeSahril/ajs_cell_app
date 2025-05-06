import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
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
  Set<int> selectedItemIds = {};
  bool isLoading = false;
  @override
  void initState() {
    initBeranda();
    super.initState();
  }

  initBeranda() async {
    try {
      await controller.getCart();
      setState(() {
        allCart = controller.cart;
      });
    } catch (e) {
    } finally {}
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Informasi Pemesanan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (selectedItemIds.length == allCart.length) {
                        selectedItemIds.clear();
                      } else {
                        selectedItemIds = allCart.map((e) => e.cartId!).toSet();
                      }
                    });
                  },
                  child: Text(
                    selectedItemIds.length == allCart.length
                        ? "Uncheck All"
                        : "Check All",
                  ),
                ),
              ],
            ),
            allCart.length == 0
                ? Center(child: Text("Tidak Ada Data keranjang"))
                : Expanded(
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
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedItemIds
                                          .contains(result.cartId)) {
                                        selectedItemIds.remove(result.cartId);
                                      } else {
                                        selectedItemIds.add(result.cartId!);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    selectedItemIds.contains(result.cartId)
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color:
                                        selectedItemIds.contains(result.cartId)
                                            ? Colors.blue
                                            : Colors.grey,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          result.product?.image ?? ''),
                                    ),
                                  ),
                                ),
                                Column(
                                  spacing: 8,
                                  children: [
                                    Text(
                                        "${result.product?.name?.toUpperCase()} - ${result.productCart?.type?.toUpperCase()}"),
                                    Text(formatCurrency(
                                        result.productCart?.price ?? '')),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff0F6CBD),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await controller.updateQuantity(
                                                  id: result.cartId!,
                                                  quantity:
                                                      result.quantity! - 1);
                                              await initBeranda();
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${result.quantity}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await controller.updateQuantity(
                                                  id: result.cartId!,
                                                  quantity:
                                                      result.quantity! + 1);
                                              await initBeranda();
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  spacing: 10,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Konfirmasi"),
                                                content: Text(
                                                    "Apakah Anda yakin ingin menghapus item ini?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text("Batal"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .deleteCart(
                                                              id: result
                                                                  .cartId!);
                                                      await initBeranda();
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text("Hapus"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.delete)),
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
              final selectedCarts = allCart
                  .where((cart) => selectedItemIds.contains(cart.cartId))
                  .toList();

              if (selectedCarts.isEmpty) {
                Get.snackbar('Info', 'Pilih minimal satu item untuk checkout');
                return;
              } else {
                Get.to(() => CheckoutPage(selectedCarts: selectedCarts));
              }
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "Checkout (${selectedItemIds.length})",
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
