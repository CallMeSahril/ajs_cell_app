import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                CustomTextFormField(
                  title: 'Nama Lengkap',
                ),
                CustomTextFormField(
                  title: 'Nama Telepon',
                ),
                CustomTextFormField(
                  title: 'Email',
                ),
                CustomTextFormField(
                  title: 'Password',
                ),
                CustomTextFormField(
                  title: 'Alamat',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffFFFFFF),
        child: CustomButton(type: ButtonType.blue, text: "Log out"),
      ),
    );
  }
}
