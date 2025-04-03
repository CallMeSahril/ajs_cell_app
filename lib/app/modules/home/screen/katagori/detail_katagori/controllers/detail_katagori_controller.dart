import 'package:get/get.dart';

class DetailKatagoriController extends GetxController {
  //TODO: Implement VocherController
  String title;
  DetailKatagoriController({required this.title});
  
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
