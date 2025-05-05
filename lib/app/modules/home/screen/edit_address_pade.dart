import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/model/city_model.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/model/province_model.dart';
import 'package:ajs_cell_app/app/domain/address/entities/create_addres_entities.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final KeranjangController controller = Get.find<KeranjangController>();
  List<AddressEntities> addressList = [];

  getAddress() async {
    final response = await controller.getAddress();
    setState(() {
      addressList = response;
    });
  }

  void _goToForm({AddressEntities? address, int? index}) async {
    final result = await Navigator.push<AddressEntities>(
      context,
      MaterialPageRoute(
        builder: (context) => AddressFormPage(address: address),
      ),
    );

    if (result != null) {
      setState(() {
        if (index != null) {
          addressList[index] = result; // Edit
        } else {
          addressList.add(result); // Tambah
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Alamat")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          final address = addressList[index];
          return Card(
            child: ListTile(
              onTap: () {
               Navigator.pop(context, address);

              },
              title: Text("Nama: ${address.name ?? ""}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("No HP: ${address.phone ?? ''}"),
                  Text("Provinsi: ${address.province ?? ''}"),
                  Text("Kota: ${address.city ?? ''}"),
                  Text("Alamat: ${address.address ?? ''}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _goToForm(address: address, index: index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToForm(),
        child: Icon(Icons.add),
        tooltip: "Tambah Alamat",
      ),
    );
  }
}

class AddressFormPage extends StatefulWidget {
  final AddressEntities? address;

  const AddressFormPage({super.key, this.address});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final KeranjangController controller = Get.find<KeranjangController>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final kodePosController = TextEditingController();

  String selectedProvinceId = '';
  String selectedCityId = '';
  String kodePos = '';
  String? selectedProvinceName;
  String? selectedCityName;

  List<ProvinceEntities> provinces = [];
  List<CityEntities> cities = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    provinces = await controller.getProvince();

    if (widget.address != null) {
      nameController.text = widget.address!.name ?? '';
      kodePosController.text = widget.address!.posKode ?? '';
      phoneController.text = widget.address!.phone ?? '';
      addressController.text = widget.address!.address ?? '';

      selectedProvinceId = widget.address!.provinceId ?? '';
      selectedProvinceName = widget.address!.province;
      selectedCityId = widget.address!.cityId ?? '';
      selectedCityName = widget.address!.city;

      if (selectedProvinceId.isNotEmpty) {
        cities = await controller.getCity(id: int.parse(selectedProvinceId));

        final selectedCity =
            cities.firstWhereOrNull((c) => c.cityId == selectedCityId);
        if (selectedCity != null) {
          kodePosController.text = selectedCity.postalCode ?? '';
        }
      }
    }

    setState(() {});
  }

  void _saveAddress() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedProvinceId.isEmpty ||
        selectedCityId.isEmpty) return;

    final newAddress = AddressEntities(
      id: widget.address?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      provinceId: selectedProvinceId,
      province: selectedProvinceName,
      cityId: selectedCityId,
      city: selectedCityName,
      createdAt: widget.address?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    widget.address == null
        ? controller.addAddress(
            post: CreateAddressEntities(
            address: addressController.text,
            city: selectedCityName,
            cityId: int.parse(selectedCityId),
            name: nameController.text,
            phone: phoneController.text,
            postalCode: kodePosController.text,
            province: selectedProvinceName,
            provinceId: int.parse(selectedCityId),
          ))
        : "Edit Alamat";
    ;
    Navigator.pop(context, newAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? "Tambah Alamat" : "Edit Alamat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "No HP"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Alamat Lengkap"),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Provinsi"),
              value: provinces.any((p) => p.provinceId == selectedProvinceId)
                  ? selectedProvinceId
                  : null,
              items: provinces
                  .map((prov) => DropdownMenuItem<String>(
                        value: prov.provinceId,
                        child: Text(prov.province ?? ''),
                      ))
                  .toList(),
              onChanged: (val) async {
                selectedProvinceId = val!;
                selectedProvinceName =
                    provinces.firstWhere((p) => p.provinceId == val).province;

                selectedCityId = '';
                selectedCityName = '';
                cities =
                    await controller.getCity(id: int.parse(selectedProvinceId));
                setState(() {});
              },
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Kota/Kabupaten"),
              value: cities.any((c) => c.cityId == selectedCityId)
                  ? selectedCityId
                  : null,
              items: cities
                  .map((city) => DropdownMenuItem<String>(
                        value: city.cityId,
                        child: Text(city.cityName ?? ''),
                      ))
                  .toList(),
              onChanged: (val) {
                final selectedCity = cities.firstWhere((c) => c.cityId == val);
                selectedCityId = selectedCity.cityId ?? '';
                selectedCityName = selectedCity.cityName;
                kodePosController.text = selectedCity.postalCode ?? '';
                setState(() {});
              },
            ),
            SizedBox(height: 12),
            TextField(
              readOnly: true,
              controller: kodePosController,
              decoration: InputDecoration(labelText: "Kode Pos"),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveAddress,
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
