import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/entities/courire_entities.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/entities/ongkir_service.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/edit_address_pade.dart';
import 'package:ajs_cell_app/app/modules/home/screen/pembayaran_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartEntities> selectedCarts;
  const CheckoutPage({super.key, required this.selectedCarts});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final KeranjangController controller = Get.find<KeranjangController>();
  List<CourierEntities> couriers = [];
  CourierEntities? selectedCourier;

  List<PaymentFeeEntities> allPayment = [];
  AddressEntities? selectedAddress;
  String? selectedPaymentMethod;
  List<OngkirService> ongkirList = [];
  OngkirService? selectedOngkir;
  int totalProduk = 0;
  int grandTotal = 0;

  @override
  void initState() {
    initChekout();
    totalProduk = widget.selectedCarts.fold(0, (sum, item) {
      final price = double.tryParse(item.productCart?.price ?? '0') ?? 0;
      return sum + (price * item.quantity!).toInt();
    });

    grandTotal = totalProduk;

    super.initState();
  }

  initChekout() async {
    try {
      final respone = await controller.getPaymentMethod();
      final kurir = await getKurir(); // <-- Panggil method baru

      setState(() {
        couriers = kurir;

        allPayment = respone;
      });
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   'Failed to load profile: $e',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {}
  }

  Future<List<CourierEntities>> getKurir() async {
    ApiHelper apiHelper = ApiHelper();
    final response = await apiHelper
        .get('/available-couriers'); // ganti dengan endpoint kamu
    final data = response.data['data'] as Map<String, dynamic>;

    return data.entries.map((entry) {
      return CourierEntities(
        code: entry.key,
        name: entry.value,
      );
    }).toList();
  }

  Future<void> cekOngkir(String courierCode) async {
    ApiHelper apiHelper = ApiHelper();
    final response = await apiHelper.post('/check-shipping-cost', data: {
      "origin": 1,
      "destination": 1,
      "weight": 1,
      "courier": courierCode
    });

    final data = response.data['data'][0]['costs'] as List;

    ongkirList = data.map((e) => OngkirService.fromJson(e)).toList();
    selectedOngkir = null;

    setState(() {});
  }

  Future<void> submitOrder() async {
    if (selectedPaymentMethod == null) {
      Get.snackbar("Metode Pembayaran",
          "Silakan pilih metode pembayaran terlebih dahulu");
      return;
    }

    if (selectedCourier == null || selectedOngkir == null) {
      Get.snackbar("Kurir", "Silakan pilih kurir dan layanan pengirimannya");
      return;
    }

    if (selectedAddress == null) {
      Get.snackbar("Alamat", "Silakan pilih alamat pengiriman terlebih dahulu");
      return;
    }

    // Ambil semua ID keranjang
    final List<int> cartIds =
        widget.selectedCarts.map((cart) => cart.cartId!).toList();

    // Buat payload request
    final Map<String, dynamic> payload = {
      "cart_ids": cartIds,
      "method_pembayaran": selectedPaymentMethod,
      "ongkir": selectedOngkir!.value,
      "address_id": selectedAddress!.id,
    };

    try {
      ApiHelper apiHelper = ApiHelper();
      final response = await apiHelper.post('/orders', data: payload);

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Pesanan berhasil dibuat");
        Get.to(() => PembayaranPage()); // atau redirect ke halaman sukses
      } else {
        Get.snackbar(
            "Gagal", "Pesanan gagal dikirim. (${response.statusMessage})");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  int selectedAddressId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: ListView(
          children: [
            UserChekout(
              onAddressSelected: (addressEntity) {
                setState(() {
                  selectedAddress = addressEntity;
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Produk",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.selectedCarts.length,
                    itemBuilder: (context, index) {
                      final result = widget.selectedCarts[index];
                      final price =
                          double.tryParse(result.productCart?.price ?? '0') ??
                              0;
                      int total = (price * result.quantity!).toInt();

                      return Row(
                        spacing: 20,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        result.product?.image ?? ''))),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${result.product?.name?.capitalize} ${result.productCart?.type?.capitalize}"),
                                Text(
                                    "Deskripsi : ${result.product?.description} ${formatCurrency(total.toString())} ")
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pilih Metode Pembayaran"),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allPayment.length,
                        itemBuilder: (context, index) {
                          final payment = allPayment[index];
                          final isSelected =
                              selectedPaymentMethod == payment.paymentMethod;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = payment.paymentMethod;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                image: DecorationImage(
                                  image:
                                      NetworkImage(payment.paymentImage ?? ''),
                                  fit: BoxFit.contain,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                            color: Colors.blue.shade100,
                                            blurRadius: 6)
                                      ]
                                    : [],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pilih Kurir"),
                    Container(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: couriers.length,
                        itemBuilder: (context, index) {
                          final courier = couriers[index];
                          final isSelected =
                              selectedCourier?.code == courier.code;

                          return GestureDetector(
                            onTap: () async {
                              selectedCourier = courier;
                              selectedOngkir = null;
                              await cekOngkir(courier.code);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  courier.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (ongkirList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pilih Layanan Pengiriman"),
                          Wrap(
                            spacing: 8,
                            children: ongkirList.map((ongkir) {
                              final isSelected =
                                  selectedOngkir?.service == ongkir.service;
                              return ChoiceChip(
                                label: Text(
                                    "${ongkir.service} (${formatCurrency(ongkir.value.toString())})"),
                                selected: isSelected,
                                onSelected: (_) {
                                  setState(() {
                                    selectedOngkir = ongkir;
                                    grandTotal = totalProduk + ongkir.value;
                                  });
                                },
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    SizedBox(height: 16),
                    Text(
                        "Total Produk: ${formatCurrency(totalProduk.toString())}"),
                    Text(
                        "Ongkir: ${selectedOngkir != null ? formatCurrency(selectedOngkir!.value.toString()) : '-'}"),
                    Divider(),
                    Text(
                      "Grand Total: ${formatCurrency((selectedOngkir != null ? totalProduk + selectedOngkir!.value : totalProduk).toString())}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              submitOrder();
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "SUBMIT ORDER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}

class UserChekout extends StatefulWidget {
  final Function(AddressEntities)? onAddressSelected;

  const UserChekout({super.key, this.onAddressSelected});

  @override
  State<UserChekout> createState() => _UserChekoutState();
}

class _UserChekoutState extends State<UserChekout> {
  final KeranjangController controller = Get.find<KeranjangController>();

  String name = "";
  String address = "";
  int addresId = 0;
  CheckOngkir checkOngkir = CheckOngkir();

  void _editAddress() async {
    final result = await Navigator.push<AddressEntities?>(
      context,
      MaterialPageRoute(builder: (context) => EditAddressPage()),
    );

    if (result != null) {
      setState(() {
        name = result.name ?? '';
        address = "${result.address}, ${result.city}, ${result.province}";
      });

      Future.delayed(Duration.zero, () {
        widget.onAddressSelected?.call(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alamat Pengiriman",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: _editAddress,
                    child: Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDB3022),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 4),
              Text(address),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckOngkir {
  final int? origin;
  final int? destination;
  final int? weight;
  final String? courier;

  CheckOngkir({
    this.origin,
    this.destination,
    this.weight,
    this.courier,
  });
}
