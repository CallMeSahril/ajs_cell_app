import 'package:ajs_cell_app/app/data/chat/entities/chat_entities.dart';
import 'package:ajs_cell_app/app/data/chat/usecases/get_chat.dart';
import 'package:ajs_cell_app/app/data/chat/usecases/send_chat.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final GetChat _getChat = GetChat();
  final SendChat _sendChat = SendChat();

  var chatList = <ChatEntities>[].obs;
  var isLoading = false.obs;

  Future<void> fetchChat() async {
    isLoading.value = true;
    final result = await _getChat();
    result.fold(
      (failure) =>
          Get.snackbar('Error', failure.message ?? 'Gagal mengambil chat'),
      (data) => chatList.value = data,
    );
    isLoading.value = false;
  }

  Future<void> sendNewChat(String message) async {
    final result = await _sendChat(message);
    result.fold(
      (failure) =>
          Get.snackbar('Error', failure.message ?? 'Gagal mengirim pesan'),
      (msg) => fetchChat(),
    );
  }
}
