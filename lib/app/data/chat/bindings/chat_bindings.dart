import 'package:get/get.dart';
import 'package:ajs_cell_app/app/data/chat/controllers/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}