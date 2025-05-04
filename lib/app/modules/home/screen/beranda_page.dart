import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/beranda_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/katagori/detail_katagori/views/detail_katagori_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final BerandaController controller = Get.find<BerandaController>();
  List<ProductEntities> allProduk = [];
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
      await controller.getAllProducts();

      setState(() {
        allProduk = controller.allProducts.value;
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
            "title",
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
              isLoading
                  ? CircularProgressIndicator()
                  : allProduk.length == 0
                      ? Text("Data Tidak Ditemukan")
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 items per row
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: allProduk.length,
                            itemBuilder: (context, index) {
                              final result = allProduk[index];
                              return GestureDetector(
                                onTap: () => Get.to(() => DetailKatagoriView()),
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    result.image ?? ""))),
                                        child: Center(
                                          child: Text(
                                            'Item $index',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${result.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      formatRange(result.range ?? ""),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ));
  }
}
