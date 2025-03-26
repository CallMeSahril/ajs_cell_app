import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
                currentIndex: controller.selectedIndex.value,
                onTap: controller.changeIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: "Katagori"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Keranjang"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "Presan"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    ));
  }
}
