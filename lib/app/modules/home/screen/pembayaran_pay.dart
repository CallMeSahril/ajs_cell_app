import 'package:ajs_cell_app/app/modules/home/screen/pembayaran_page.dart';
import 'package:flutter/material.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:flutter/material.dart';
import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:get/get.dart';

class PembayaranPay extends StatelessWidget {
  final AddressEntities address;
  final int totalPembayaran;
  final String virtualAccount;
  final String status;
  final String orderId;
  final String tanggalOrder;
  final String virtualName;
  final String kurirName;
  final String layananKurir;
  final int ongkir;
  final List<int> cartIds;

  const PembayaranPay({
    super.key,
    required this.address,
    required this.totalPembayaran,
    required this.virtualAccount,
    required this.virtualName,
    required this.status,
    required this.orderId,
    required this.tanggalOrder,
    required this.kurirName,
    required this.layananKurir,
    required this.ongkir,
    required this.cartIds,
  });

  Future<void> submitOrderToServer(BuildContext context) async {
    try {
      final payload = {
        "cart_ids": cartIds,
        "method_pembayaran": virtualName,
        "ongkir": ongkir,
        "address_id": address.id,
      };

      ApiHelper apiHelper = ApiHelper();
      final response = await apiHelper.post('/orders', data: payload);

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Pesanan berhasil dikirim");
        Get.to(PembayaranPage());
      } else {
        Get.snackbar(
            "Gagal", "Gagal membuat pesanan: ${response.statusMessage}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat submit: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Checkout", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alamat
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(address.name ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    "${address.address}, ${address.city}, ${address.province}"),
              ),
            ),
            const SizedBox(height: 10),

            // Kurir
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.local_shipping, color: Colors.orange),
                title: Text("Kurir: $kurirName"),
                subtitle: Text("Layanan: $layananKurir - Rp$ongkir"),
              ),
            ),
            const SizedBox(height: 10),

            // Pembayaran
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet_rounded,
                    color: Colors.blue),
                title: const Text("Virtual Account"),
                subtitle: Text(virtualAccount),
              ),
            ),
            const SizedBox(height: 10),

            // Ringkasan
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Total Pembayaran", "Rp$totalPembayaran"),
                    _buildInfoRow("Status", status),
                    const SizedBox(height: 10),
                    _buildInfoRow("Order ID", orderId),
                    _buildInfoRow("Tanggal Order", tanggalOrder),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Tombol
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
      ),
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
