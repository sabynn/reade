import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/shared/theme.dart';
import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background_image.png',
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  UserModel user = state.user;
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: ProfileWidget(
                          imagePath: user.profileImage,
                        ),
                      ),
                      const SizedBox(height: 38),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          buildEditButton(),
                          buildEditIcon(
                            kDarkColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 2.0,
                          right: 2.0,
                        ),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xff2545b4),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(height: 18),
                                buildText(
                                    'Full Name', user.name, '             '),
                                buildText('Date of Birth', user.dateOfBirth,
                                    '        '),
                                buildText(
                                    'Gender', user.gender, '                  '),
                                buildText(
                                    'Education', user.education, '             '),
                                buildText(
                                    'Email', user.email, '                     '),
                                const SizedBox(height: 15),
                                buildInterests(user),
                                const SizedBox(height: 25),
                                buildResume(),
                                const SizedBox(height: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                    child: Container(
                      color: kBackgroundColor,
                      child: BackButton(
                        color: kDarkColor,
                        onPressed: () {
                          Navigator.pushNamed(context, "/home");
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  "Profile",
                  style: darkTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditButton() => ButtonWidget(
        fontSize: 16,
        text: 'Edit',
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const EditProfilePage(),
            ),
          );
        },
      );

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.white,
          all: 8,
          child: Icon(
            Icons.edit,
            color: color,
            size: 25,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

Widget buildText(String title, String isi, String space) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Text(
          title + space,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(isi, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 45),
      ],
    ));

Widget buildInterests(UserModel user) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            'Interests           ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Wrap(children: <Widget>[
              for (int i = 0;
                  i <= user.interests.lastIndexWhere((element) => true);
                  i++)
                (buildChip(user.interests[i], const Color(0xffacbbe0)))
            ]),
          ),
        ],
      ),
    );

Widget buildChip(String label, Color color) => Chip(
      labelPadding: const EdgeInsets.all(2.0),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xff3b56b3),
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ),
      backgroundColor: color,
      elevation: 4,
      shadowColor: Colors.grey[50],
      padding: const EdgeInsets.all(4),
    );

Widget buildResume() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        const Text(
          'Resume                 ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        buildDownloadButton(),
        const SizedBox(height: 38),
      ],
    ));

Widget buildDownloadButton() => ButtonWidget(
      fontSize: 14,
      text: 'Download',
      onClicked: () {},
    );
