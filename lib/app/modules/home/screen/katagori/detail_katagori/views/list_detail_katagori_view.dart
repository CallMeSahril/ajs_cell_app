import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/modules/home/screen/katagori/detail_katagori/views/detail_katagori_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_katagori_controller.dart';

class ListDetailKatagoriView extends StatefulWidget {
  const ListDetailKatagoriView({super.key});

  @override
  State<ListDetailKatagoriView> createState() => _ListDetailKatagoriViewState();
}

class _ListDetailKatagoriViewState extends State<ListDetailKatagoriView> {
  final DetailKatagoriController controller =
      Get.find<DetailKatagoriController>();
  List<ProductEntities> produk = [];
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
      await controller.getCategoryProductById(id: controller.id);

      setState(() {
        produk = controller.productEntities;
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
          title: Text(
            "${controller.title}",
            style: TextStyle(
                color: Color(0xff0245A3), fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  // Handle search logic here
                  print('Search query: $value');
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: produk.length,
                  itemBuilder: (context, index) {
                    final result = produk[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => DetailKatagoriView(
                            id: result.id!,
                          )),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // bayangan ke bawah
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: 100,
                                  maxWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(result.image ?? ''))),
                              ),
                            ),
                            Text(
                              "${result.name}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatRange(result.range ?? ""),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        );
  }
}
