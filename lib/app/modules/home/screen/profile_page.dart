import 'package:ajs_cell_app/app/core/config/token.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/profile_controller.dart';
import 'package:ajs_cell_app/app/modules/home/screen/update_profile_page.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();

  bool isLoading = false;

  TextEditingController fullName = TextEditingController();
  TextEditingController handphone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();

  @override
  void initState() {
    super.initState();
    initProfile();
  }

  Future<void> initProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      await controller.getProfile();
      final user = controller.userData.value;

      fullName.text = user.name ?? '';
      handphone.text = user.phone ?? '';
      email.text = user.email ?? '';
      alamat.text =   '';
      jenisKelamin.text =  'Pria/Wanita';
    } catch (e) {
      // error handling optional
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff006BC5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Get.to(UpdateProfilePage());
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('assets/images/profile.png'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      CustomTextFormField(
                        title: 'Nama Lengkap',
                        controller: fullName,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        title: 'Jenis Kelamin',
                        controller: jenisKelamin,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        title: 'Email',
                        controller: email,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        title: 'Nomor hp',
                        controller: handphone,
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        title: 'Alamat',
                        controller: alamat,
                        readOnly: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: isLoading
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  await AuthHelper.deleteToken();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: const Text("Log out"),
              ),
            ),
    );
  }
}
