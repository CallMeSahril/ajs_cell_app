import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/utils/fungsi_format.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/entities/courire_entities.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/entities/ongkir_service.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/edit_address_pade.dart';
import 'package:ajs_cell_app/app/modules/home/screen/pembayaran_pay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      final hargaAsli = double.tryParse(item.productCart?.price ?? '0') ?? 0;
      final diskonPersen =
          (item.product?.discount != null && item.product!.discount!.isNotEmpty)
              ? int.tryParse(item.product!.discount!.first.potonganDiskon) ?? 0
              : 0;

      final hargaSetelahDiskon = diskonPersen > 0
          ? hitungHargaDiskon(item.productCart?.price ?? '0', diskonPersen)
          : hargaAsli;

      return sum + (hargaSetelahDiskon * item.quantity!).toInt();
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

  Future<void> cekOngkir(String courierCode, String tujuan) async {
    ApiHelper apiHelper = ApiHelper();
    final response = await apiHelper.post('/check-shipping-cost', data: {
      "origin": 235,
      "destination": int.parse(tujuan),
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

    try {
      final now = DateTime.now();
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final cartIds = widget.selectedCarts.map((cart) => cart.cartId!).toList();
      submitOrderToServer(context, cartIds);
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  Future<void> submitOrderToServer(
      BuildContext context, List<int> cartIds) async {
    try {
      final Map<String, dynamic> payload = {
        "cart_ids": cartIds,
        "method_pembayaran": selectedPaymentMethod,
        "ongkir": selectedOngkir!.value,
        "address_id": selectedAddress!.id,
      };

      ApiHelper apiHelper = ApiHelper();
      final response = await apiHelper.post('/orders', data: payload);
      print(response.data);

      if (response.statusCode == 200) {
        final merchantOrderId =
            response.data['meta']?['message']?['merchantOrderId'];
        if (merchantOrderId != null) {
          Get.snackbar("Berhasil", "Pesanan berhasil dikirim");
          Get.offAll(() => WebviewPembayaranPage(
              url: response.data['meta']?['message']['paymentUrl']));
          // Get.to(() => PembayaranPay(
          //   paymentUrl: response.data['meta']?['message']['paymentUrl'],
          //       address: selectedAddress!,
          //       cartIds: cartIds,
          //       merchantOrderId: merchantOrderId.toString(),
          //     ));
        } else {
          Get.snackbar("Gagal", "Merchant Order ID tidak ditemukan");
        }
      } else {
        Get.snackbar(
            "Gagal", "Gagal membuat pesanan: ${response.statusMessage}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat submit: $e");
    }
  }

  int selectedAddressId = 0;
  double hitungHargaDiskon(String harga, int potongan) {
    final doubleHarga = double.tryParse(harga) ?? 0;
    final diskon = doubleHarga * potongan / 100;
    return doubleHarga - diskon;
  }

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

                      final diskonPersen = (result.product?.discount != null &&
                              result.product!.discount!.isNotEmpty)
                          ? int.tryParse(result
                                  .product!.discount!.first.potonganDiskon) ??
                              0
                          : 0;

                      final hargaAsli =
                          double.tryParse(result.productCart?.price ?? '0') ??
                              0;
                      final hargaDiskon = diskonPersen > 0
                          ? hitungHargaDiskon(
                              result.productCart?.price ?? '0', diskonPersen)
                          : hargaAsli;
                      final hargaTotal = hargaDiskon * result.quantity!;
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
                                diskonPersen > 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Harga: ${formatCurrency(hargaAsli.toString())}",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.red,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Diskon $diskonPersen%: ${formatCurrency(hargaDiskon.toString())}",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Subtotal: ${formatCurrency(hargaTotal.toString())}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    : Text(
                                        "Subtotal: ${formatCurrency(hargaTotal.toString())}"),
                                // Text(
                                //     "Deskripsi : ${result.product?.description} ${formatCurrency(total.toString())} ")
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
                              await cekOngkir(
                                  courier.code, selectedAddress?.cityId ?? "1");
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
