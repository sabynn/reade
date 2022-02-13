import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/shared/theme.dart';
import 'package:reade/ui/pages/profile_page.dart';

import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/edit_profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Edit Profile',
        const ProfilePage(),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            UserModel user = state.user;
            return Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    EditProfileWidget(
                      imagePath: user.profileImage,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    buildTextField("Full Name", user.name),
                    buildTextField("Date of Birth", user.dateOfBirth),
                    buildTextField("Gender", user.gender),
                    buildTextField("Education", user.education),
                    buildTextField("Email", user.email),
                    buildTextField("Interests", user.interests.join(",")),
                    buildResumeField(),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlineButton(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: (() => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ProfilePage(),
                                ),
                              )),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ProfilePage(),
                                ),
                              )),
                          color: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black12,
            )),
      ),
    );
  }

  Widget buildResumeField() => Row(
        children: [
          const Text(
            'Resume     ',
            style: TextStyle(fontSize: 15.5, color: Colors.black),
          ),
          buildChooseFile(),
          const SizedBox(width: 10),
          buildUploadButton(),
          const SizedBox(height: 38),
        ],
      );

  Widget buildChooseFile() => ButtonWidget(
        fontSize: 16,
        text: 'Choose File',
        onClicked: () {},
      );
  Widget buildUploadButton() => ButtonWidget(
        fontSize: 16,
        text: 'Upload',
        onClicked: () {},
      );
}
