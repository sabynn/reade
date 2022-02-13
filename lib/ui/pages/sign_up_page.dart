import 'package:reade/cubit/auth_cubit.dart';
import 'package:reade/ui/widgets/custom_button.dart';
import 'package:reade/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController(text: '');

  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  final TextEditingController dateOfBirthController =
      TextEditingController(text: '');

  final TextEditingController genderController =
      TextEditingController(text: '');

  final TextEditingController educationController =
      TextEditingController(text: '');

  final TextEditingController interestsController =
      TextEditingController(text: '');

  late String profileImageLink = "";
  File? _image = null;

  @override
  Widget build(BuildContext context) {
    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref("profile-images/").child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      dynamic url = await (await uploadTask).ref.getDownloadURL();
      url = url.toString();
      profileImageLink = url;
    }

    Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
        uploadPic(context);
        print('Image Path $_image');
      });
    }


    Widget widgetGetImage() {
      return Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: const Color(0xff476cfb),
          child: ClipOval(
            child: SizedBox(
              width: 180.0,
              height: 180.0,
              child: (_image != null)
                  ? Image.file(
                      _image!,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
      );
    }

    Widget widgetUploadPic() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              color: kBackgroundColor,
            ),
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
          ),
          onPressed: () => {
            getImage(),
          },
          icon: Icon(
            Icons.camera,
            color: kBackgroundColor,
            size: 25.0,
          ),
          label: Text(
            "Upload Image",
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Join us and upgrade\nyour interview skill',
          style: darkTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          title: 'Full Name',
          hintText: 'Your full name',
          controller: nameController,
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hintText: 'Your email address',
          controller: emailController,
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hintText: 'Your password',
          obscureText: true,
          controller: passwordController,
        );
      }

      Widget dateOfBirthInput() {
        return CustomTextFormField(
          title: 'Date of Birth',
          hintText: 'Your date of birth',
          controller: dateOfBirthController,
        );
      }

      Widget genderInput() {
        return CustomTextFormField(
          title: 'Gender',
          hintText: 'Your gender',
          controller: genderController,
        );
      }

      Widget educationInput() {
        return CustomTextFormField(
          title: 'Education',
          hintText: 'Your education',
          controller: educationController,
        );
      }

      Widget interestsInput() {
        return CustomTextFormField(
          title: 'Interests',
          hintText: 'Your interest',
          controller: interestsController,
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign-in', (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRedColor,
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'Sign Up',
              onPressed: () {
                uploadPic(context);
                context.read<AuthCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      dateOfBirth: dateOfBirthController.text,
                      gender: genderController.text,
                      education: educationController.text,
                      interests: [interestsController.text],
                      profileImage: profileImageLink,
                    );
              },
            );
          },
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          children: [
            widgetGetImage(),
            widgetUploadPic(),
            nameInput(),
            emailInput(),
            passwordInput(),
            dateOfBirthInput(),
            genderInput(),
            educationInput(),
            interestsInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 50,
            bottom: 73,
          ),
          child: Text(
            'Have an account? Sign In',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}
