import 'package:ajs_cell_app/app/modules/home/controllers/profile_controller.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();

  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    final user = controller.userData.value;

    nameController = TextEditingController(text: user.name ?? '');
    genderController = TextEditingController(text: '');
    emailController = TextEditingController(text: user.email ?? '');
    phoneController = TextEditingController(text: user.phone ?? '');
    addressController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profil'),
        // backgroundColor: const Color(0xff006BC5),
        // foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // TODO: Implement photo change functionality
              Get.snackbar("Info", "Fitur ubah foto belum tersedia");
            },
            child: Center(
              child: Text(
                "Ubah Foto",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            title: "Nama Lengkap",
            controller: nameController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: "Jenis Kelamin",
            controller: genderController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: "Email",
            controller: emailController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: "Nomor HP",
            controller: phoneController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: "Alamat",
            controller: addressController,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Simpan Perubahan",
            type: ButtonType.blue,
            onTap: () async {
              // Simpan perubahan ke controller/userData
              // controller.userData.value = controller.userData.value.copyWith(
              //   name: nameController.text,
              //   gender: genderController.text,
              //   email: emailController.text,
              //   phone: phoneController.text,
              //   address: addressController.text,
              // );

              // TODO: Kirim ke API jika perlu

              Get.back(); // kembali ke halaman sebelumnya
              Get.snackbar("Sukses", "Profil berhasil diperbarui");
            },
          )
        ],
      ),
    );
  }
}
