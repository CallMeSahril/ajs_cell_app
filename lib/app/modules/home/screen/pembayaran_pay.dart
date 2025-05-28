import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/data/orders/controller/order_controller.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PembayaranPay extends StatefulWidget {
  final AddressEntities address;
  final List<int> cartIds;
  final String merchantOrderId;
  final String? paymentUrl; // boleh null

  const PembayaranPay({
    super.key,
    required this.address,
    required this.cartIds,
    required this.merchantOrderId,
    this.paymentUrl,
  });

  @override
  State<PembayaranPay> createState() => _PembayaranPayState();
}

class _PembayaranPayState extends State<PembayaranPay> {
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.checkPaymentStatus(widget.merchantOrderId);
  }

  Future<void> submitOrderToServer(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Pembayaran", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        final data = orderController.orderStatus.value;

        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.errorMessage.isNotEmpty) {
          return Center(child: Text(orderController.errorMessage.value));
        }

        if (data == null) {
          return const Center(child: Text("Data pembayaran tidak tersedia."));
        }
        // Urutkan data jika ada list transaksi (misal: data.transactions)
        // Contoh: jika data.transactions adalah List dan punya field createdAt
        // Ganti 'transactions' dan 'createdAt' sesuai struktur data Anda
        // 
      
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alamat
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(widget.address.name ?? '-',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "${widget.address.address}, ${widget.address.city}, ${widget.address.province}"),
                ),
              ),
              const SizedBox(height: 10),

              // Ringkasan Pembayaran
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Virtual Account", data.reference ?? "-"),
                      _buildInfoRow(
                          "Total Pembayaran", "Rp${data.amount ?? '0'}"),
                      _buildInfoRow("Status", data.statusMessage ?? '-'),
                      _buildInfoRow("Order ID", data.merchantOrderId ?? '-'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Gambar tombol pembayaran yang mengarah ke WebView
              if (widget.paymentUrl != null && widget.paymentUrl!.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Get.to(
                        () => WebviewPembayaranPage(url: widget.paymentUrl!));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Image.network(
                            "https://i.ibb.co/5jDwDtC/paynow.png",
                            width: 160,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Klik untuk membuka halaman pembayaran",
                            style:
                                TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Link pembayaran belum tersedia untuk pesanan ini.",
                    style: TextStyle(color: Colors.redAccent, fontSize: 14),
                  ),
                ),

              const Spacer(),

              // Tombol Submit (opsional)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => submitOrderToServer(context),
                  child: const Text(
                    "SUBMIT ORDER",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
class WebviewPembayaranPage extends StatelessWidget {
  final String url;
  final bool back;

  const WebviewPembayaranPage({
    super.key,
    required this.url,
    this.back = false,
  });

  void _handleBack(BuildContext context) {
    if (back) {
      Get.back();
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    final webController = WebViewController();

    webController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            try {
              final content = await webController.runJavaScriptReturningResult(
                "document.body.innerText",
              );

              final cleaned = content.toString().replaceAll(RegExp(r'["\\]'), '');

              if (cleaned.toLowerCase().contains("pembayaran berhasil")) {
                Get.snackbar("Sukses", "Pembayaran berhasil!");
                Future.delayed(const Duration(seconds: 1), () {
                  Get.offAllNamed(Routes.HOME);
                });
              }
            } catch (e) {
              debugPrint("Gagal membaca konten halaman: $e");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => _handleBack(context),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: WebViewWidget(controller: webController),
        ),
      ),
    );
  }
}
