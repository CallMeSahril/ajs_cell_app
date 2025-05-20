import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/data/banner/controller/banner_controller.dart';
import 'package:ajs_cell_app/app/data/banner/model/banner_model.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/beranda_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/katagori/detail_katagori/views/detail_katagori_view.dart';
import 'package:ajs_cell_app/app/modules/semua_banner/semua_banner_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final BerandaController controller = Get.find<BerandaController>();
  final BannerController bannerController = Get.put(BannerController());

  List<ProductEntities> allProduk = [];
  bool isLoading = false;
  List<BannerEntities> bannerList = [];
  BannerEntities? iklan;

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
     await fetchBannersAndIklan();
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

  Future<void> fetchBannersAndIklan() async {
    await bannerController.fetchBanners();
    await bannerController.fetchIklan();
    bannerList = bannerController.bannerList;
    iklan = bannerController.iklanList.value;

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    // bool sudahTampil = prefs.getBool('iklanSudahDitampilkan') ?? false;

    if (iklan?.image != null && !iklan!.image!.toLowerCase().endsWith('.mp4')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(10),
            child: Stack(
              children: [
                // Gambar dengan tinggi tetap 400
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: iklan!.image!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.broken_image),
                    ),
                  ),
                ),
                // Tombol close di pojok kanan atas gambar
                Positioned(
                  top: 10,
                  right: 40,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });

      await prefs.setBool('iklanSudahDitampilkan', true);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   // title: Text(
          //   //   "title",
          //   //   style: TextStyle(
          //   //       color: Color(0xff0245A3), fontWeight: FontWeight.bold),
          //   // ),
          // ),
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
                  child: ListView(
                    children: [
                      if (bannerList.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => SemuaBannerPage(banners: bannerList));
                              },
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 180.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                ),
                                items: bannerList.map((banner) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: banner.image ?? '',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.broken_image),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : allProduk.length == 0
                              ? Text("Data Tidak Ditemukan")
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      NeverScrollableScrollPhysics(), // Disable scrolling
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
                                      onTap: () =>
                                          Get.to(() => DetailKatagoriView(
                                                id: result.id!,
                                              )),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(
                                                    0, 3), // bayangan ke bawah
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        BorderRadius.circular(
                                                            8.0),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            result.image ??
                                                                ""))),
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
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                )
                // Banner Carousel
              ],
            ),
          )),
    );
  }
}
