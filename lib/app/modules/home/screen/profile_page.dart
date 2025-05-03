import 'package:ajs_cell_app/app/core/config/token.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/profile_controller.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.find<ProfileController>();

  bool isLoading = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController handphone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController alamat = TextEditingController();

  @override
  void initState() {
    initProfile();
    super.initState();
  }

  Future<void> initProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      await controller.getProfile(); // Tambahkan await di sini
      final user = controller.userData.value;

      setState(() {
        setState(() {
          fullName.text = user.name ?? '';
          handphone.text = user.phone ?? '';
          email.text = user.email ?? '';
          // password.text = user.password ?? '';
          // alamat.text = user.address ?? '';
        });
      });
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   'Failed to load profile: $e',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      CustomTextFormField(
                        title: 'Nama Lengkap',
                        controller: fullName,
                        readOnly: true,
                      ),
                      CustomTextFormField(
                        title: 'Nama Telepon',
                        controller: handphone,
                        readOnly: true,
                      ),
                      CustomTextFormField(
                        title: 'Email',
                        controller: email,
                        readOnly: true,
                      ),
                      CustomTextFormField(
                        title: 'Password',
                        controller: password,
                        readOnly: true,
                      ),
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
      bottomNavigationBar: isLoading == true
          ? SizedBox.shrink()
          : BottomAppBar(
              color: Color(0xffFFFFFF),
              child: CustomButton(
                type: ButtonType.blue,
                text: "Log out",
                onTap: () async {
                  await AuthHelper.deleteToken();
                  Get.offAllNamed(Routes.LOGIN);
                },
              ),
            ),
    );
  }
}
