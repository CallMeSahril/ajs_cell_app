import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/history_model.dart';
import 'package:ajs_cell_app/app/data/orders/model/orders_status_model.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/riwayat_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/pembayaran_pay.dart';
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
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {}); // trigger rebuild dan future baru
      }
    });
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
      body: IndexedStack(
        index: tabController.index,
        children: List.generate(
          tabs.length,
          (i) => buildTabContent(i),)
      ),
    );
  }

  Widget buildTabContent(int i) {
    final status = statusList[i];

    // Log hanya untuk tab yang sedang aktif
    if (i == tabController.index) {
      print("Status aktif: $status");
    }

    if (status == OrderStatus.done) {
      return FutureBuilder<List<HistoryEntities>>(
        future: controller.getHistory().timeout(const Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat data. Coba lagi."));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada pesanan selesai"));
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final order = data[index];
              return BuildCardPesan(
                totalAmount: order.totalAmount ?? "0",
                image: "",
                name: order.name ?? "Pelanggan",
                orderId: "Riwayat",
                message: "Status: ${order.status ?? 'Tidak diketahui'}",
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
      );
    }

    // Tab selain status == done
    return FutureBuilder<List<OrderStatusEntities>>(
      future: controller
          .getPending(status: status)
          .timeout(const Duration(seconds: 10)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text("Gagal memuat data ${tabs[i].toLowerCase()}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text("Tidak ada pesanan ${tabs[i].toLowerCase()}"));
        }

        final data = snapshot.data!;
        data.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final order = data[index];
            return BuildCardPesan(
              totalAmount: order.totalAmount ?? "0",
              image: "",
              name:  "AJS Cell",
              orderId: order.merchantOrderId ?? "No ID",
              message: "Status: ${order.status ?? 'Tidak diketahui'}",
              time: order.createdAt != null
                  ? "${order.createdAt!.hour}:${order.createdAt!.minute.toString().padLeft(2, '0')}"
                  : "-",
              tanggal: order.createdAt != null
                  ? "${order.createdAt!.day.toString().padLeft(2, '0')}-${order.createdAt!.month.toString().padLeft(2, '0')}-${order.createdAt!.year}"
                  : "-",
              unreadCount: 0,
              onTap: () {
                if (order.status == "pending") {
                  Get.to(() => WebviewPembayaranPage(
                        url: order.paymentUrl!,
                        back: true,
                      ));
                }
              },
            );
          },
        );
      },
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
  final VoidCallback? onTap;

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
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
