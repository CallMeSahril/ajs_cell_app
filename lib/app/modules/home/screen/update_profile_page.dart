import 'dart:io';

import 'package:ajs_cell_app/app/modules/auth/controller/auth_controller.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/profile_controller.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final ProfileController profileController = Get.find<ProfileController>();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    init();
  }

  init()  {

    final user = profileController.userData.value;

    nameController = TextEditingController(text: user.name ?? '');
    emailController = TextEditingController(text: user.email ?? '');
    phoneController = TextEditingController(text: user.phone ?? '');
    print("${user.image}");
    if (user.image != null && user.image!.isNotEmpty) {
       loadImageFromUrl(user.image!);
    }
    print("${user.image}");
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    selectedImage = null;
    super.dispose();
  }

  Future<void> loadImageFromUrl(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file =
            File('${tempDir.path}/profile_$timestamp.jpg'); // ← nama unik
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          selectedImage = file;
        });
      }
    } catch (e) {
      print("Gagal mengambil gambar: $e");
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : const AssetImage('assets/images/profile.png')
                      as ImageProvider,
            ),
          ),
          GestureDetector(
            onTap: pickImage,
            child: const Center(
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
            title: "Email",
            controller: emailController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            title: "Nomor HP",
            controller: phoneController,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Simpan Perubahan",
            type: ButtonType.blue,
            onTap: () async {
              final success =
                  await profileController.authController.updateProfile(
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                image: selectedImage, // nullable File
              );

              if (success) {
                if (selectedImage != null && await selectedImage!.exists()) {
                  await selectedImage!.delete();
                  setState(() {
                    selectedImage =
                        null; // reset ke null agar gambar default tampil
                  });
                }

                Get.offAllNamed(Routes.HOME);

                Get.snackbar("Sukses", "Profil berhasil diperbarui");
                profileController.getProfile(); // refresh profile
              } else {
                Get.snackbar("Gagal", "Gagal memperbarui profil");
              }
            },
          ),
        ],
      ),
    );
  }
}
