import 'dart:async';
import 'package:ajs_cell_app/app/data/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.find<ChatController>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? pollingTimer;

  @override
  void initState() {
    super.initState();
    controller.fetchChat();
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      controller.fetchChat();
    });
  }

  @override
  void dispose() {
    pollingTimer?.cancel();
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Admin"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              controller.chatList.sort(
                  (a, b) => b.createdAt!.compareTo(a.createdAt!));

              if (controller.chatList.isEmpty) {
                return const Center(child: Text("Belum ada chat"));
              }

              scrollToBottom();

              final limitedChats = controller.chatList.length > 100
                  ? controller.chatList.take(100).toList()
                  : controller.chatList;

              return ListView.builder(
                reverse: true,
                controller: scrollController,
                itemCount: limitedChats.length,
                itemBuilder: (context, index) {
                  final chat = limitedChats[index];
                  final isMe = chat.type == "chat";
                  final dateTime =
                      DateFormat('HH:mm').format(chat.createdAt!);

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.pesan ?? "",
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateTime,
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Input Chat
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Ketik pesan...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final text = messageController.text.trim();
                    if (text.isNotEmpty) {
                      await controller.sendNewChat(text);
                      messageController.clear();
                      // controller.fetchChat(); // Tidak perlu karena timer polling aktif
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
