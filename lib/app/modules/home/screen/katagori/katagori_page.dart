import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/kategori_controller.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KatagoryPage extends StatefulWidget {
  KatagoryPage({super.key});

  @override
  State<KatagoryPage> createState() => _KatagoryPageState();
}

class _KatagoryPageState extends State<KatagoryPage> {
  final KategoriController controller = Get.find<KategoriController>();
  List<CategoryProductsEntities> productsCategory = [];

  @override
  void initState() {
    initKategory();
    super.initState();
  }

  bool isLoading = false;
  initKategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      await controller.getCategoryProductAll();

      setState(() {
        productsCategory = controller.productsCategory;
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
            "Katagori",
            style: TextStyle(
                color: Color(0xff0245A3), fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: productsCategory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      type: ButtonType.blue,
                      text: "${productsCategory[index].name?.capitalize}",
                      onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
                        'title': '${productsCategory[index].name?.capitalize}',
                        'id': productsCategory[index].id,
                      }),
                    ),
                  );
                },
              )
        // : ListView(
        //     children: [
        //       Padding(
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //         child: Column(
        //           spacing: 20,
        //           children: [
        //             CustomButton(
        //               type: ButtonType.blue,
        //               text: "Voucher",
        //               onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
        //                 'title': 'Voucher',
        //               }),
        //             ),
        //             CustomButton(
        //               type: ButtonType.blue,
        //               text: "Kartu",
        //               onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
        //                 'title': 'Kartu',
        //               }),
        //             ),
        //             CustomButton(
        //               type: ButtonType.blue,
        //               text: "Aksesoris",
        //               onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
        //                 'title': 'Aksesoris',
        //               }),
        //             ),
        //             CustomButton(
        //               type: ButtonType.blue,
        //               text: "Perlengkapan Hp",
        //               onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
        //                 'title': 'Perlengkapan Hp',
        //               }),
        //             ),
        //             CustomButton(
        //               type: ButtonType.blue,
        //               text: "Bibit Parfum",
        //               onTap: () => Get.toNamed(Routes.VOCHER, arguments: {
        //                 'title': 'Bibit Parfum',
        //               }),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        );
  }
}
