import 'package:ajs_cell_app/app/modules/home/screen/beranda_page.dart';
import 'package:ajs_cell_app/app/modules/home/screen/chat_page.dart';
import 'package:ajs_cell_app/app/modules/home/screen/katagori/katagori_page.dart';
import 'package:ajs_cell_app/app/modules/home/screen/keranjang_page.dart';
import 'package:ajs_cell_app/app/modules/home/screen/riwayat_pesanan_page.dart';
import 'package:ajs_cell_app/app/modules/home/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    BerandaPage(),
    KatagoryPage(),
    KeranjangPage(),
    RiwayatPesananPage(),
    ChatPage(),
    ProfilePage(),
  ];
}
