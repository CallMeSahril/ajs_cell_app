import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/history_model.dart';
import 'package:ajs_cell_app/app/data/orders/model/orders_status_model.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/riwayat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage>
    with TickerProviderStateMixin {
  final RiwayatController controller = Get.find<RiwayatController>();
  late TabController tabController;

  final List<String> tabs = ['Pending', 'Packing', 'Delivering', 'Selesai'];
  final List<OrderStatus> statusList = [
    OrderStatus.pending,
    OrderStatus.packing,
    OrderStatus.delivering,
    OrderStatus.done
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(tabs.length, (i) {
          return i == 3
              ? FutureBuilder<List<HistoryEntities>>(
                  future: controller.getHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text("Tidak ada pesanan selesai"));
                    }

                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final order = data[index];
                        return BuildCardPesan(
                          totalAmount:  order.totalAmount ?? "0",

                          image: "",
                          name: order.name ?? "Pelanggan",
                          orderId: "Riwayat", // bisa diganti kalau ada ID-nya
                          message:
                              "Status: ${order.status ?? 'Tidak diketahui'}",
                          time: order.completedAt != null
                              ? "${order.completedAt!.hour}:${order.completedAt!.minute.toString().padLeft(2, '0')}"
                              : "-",
                          tanggal: order.completedAt != null
                              ? "${order.completedAt!.day.toString().padLeft(2, '0')}-${order.completedAt!.month.toString().padLeft(2, '0')}-${order.completedAt!.year}"
                              : "-",
                          unreadCount: 0,
                        );
                      },
                    );
                  },
                )
              : FutureBuilder<List<OrderStatusEntities>>(
                  future: controller.getPending(status: statusList[i]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                              "Tidak ada pesanan ${tabs[i].toLowerCase()}"));
                    }

                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final order = data[index];
                        return BuildCardPesan(
                          totalAmount: order.totalAmount ?? "0",
                          image: "",
                          name: "Customer",
                          orderId: order.merchantOrderId ?? "No ID",
                          message:
                              "Status: ${order.status ?? 'Tidak diketahui'}",
                          time: order.createdAt != null
                              ? "${order.createdAt!.hour}:${order.createdAt!.minute.toString().padLeft(2, '0')}"
                              : "-",
                          tanggal: order.createdAt != null
                              ? "${order.createdAt!.day.toString().padLeft(2, '0')}-${order.createdAt!.month.toString().padLeft(2, '0')}-${order.createdAt!.year}"
                              : "-",
                          unreadCount: 0,
                        );
                      },
                    );
                  },
                );
        }),
      ),
    );
  }
}

class BuildCardPesan extends StatelessWidget {
  final String name;
  final String orderId;
  final String message;
  final String time;
  final String image;
  final int unreadCount;
  final String tanggal; // <- tambahkan ini
  final String totalAmount;

  const BuildCardPesan({
    super.key,
    required this.name,
    required this.orderId,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.image,
    required this.tanggal, // <-- ini juga
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigasi ke halaman detail jika diperlukan
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Gambar Produk atau Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image.isNotEmpty
                      ? image
                      : "https://images.icon-icons.com/2534/PNG/512/product_delivery_icon_152013.png", // default
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Konten Pesanan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama & ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name.isNotEmpty ? name : "Pelanggan",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),

                    Text("Order ID: $orderId",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text("Total Bayar: ${formatCurrency(totalAmount)}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black87)),

                    Text("Tanggal: $tanggal",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),

                    // Status
                    Text(message,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87)),

                    const SizedBox(height: 6),
                    // Status Bubble (optional)
                    if (unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "$unreadCount Notif",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
