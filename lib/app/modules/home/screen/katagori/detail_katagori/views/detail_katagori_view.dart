import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/beranda_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailKatagoriView extends StatefulWidget {
  final int id;
  const DetailKatagoriView({super.key, required this.id});

  @override
  State<DetailKatagoriView> createState() => _DetailKatagoriViewState();
}

class _DetailKatagoriViewState extends State<DetailKatagoriView> {
  final BerandaController controller = Get.find<BerandaController>();
  ProductEntities produk = ProductEntities();
  bool isLoading = false;

  int jumlah = 0;
  @override
  void initState() {
    initDetailKatagori();
    super.initState();
  }

  initDetailKatagori() async {
    setState(() {
      isLoading = true;
    });
    try {
      await controller.getProductId(id: widget.id);

      setState(() {
        produk = controller.products.value;
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(produk.image ?? ''))),
                  ),
                  Text(
                    "${produk.name?.capitalize ?? ''}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Rp. 100.000 - Rp. 200.000",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Deskripsi Katagori"),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: produk.productTypes?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final data = produk.productTypes?[index];
                          return Container(
                            width: 70,
                            color: Colors.grey,
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                data?.type ?? '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    children: [
                      Text("${produk.description}"),

                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) => Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 8, vertical: 2),
                      //           child: Row(
                      //             children: [
                      //               Text("- Layanan ${index + 1}"),
                      //             ],
                      //           ),
                      //         )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jumlah"),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (jumlah > 0) {
                          setState(() {
                            jumlah -= 1;
                          });
                        }
                      },
                    ),
                    Text(
                      "$jumlah", // Replace with a variable to display the current quantity
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (jumlah < produk.stock!) {
                          setState(() {
                            jumlah += 1;
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              // Add your logic here for button press
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "Masuk Keranjang",
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
