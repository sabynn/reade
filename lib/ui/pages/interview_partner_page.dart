import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/cubit/all_user_cubit.dart';
import 'package:reade/models/user_model.dart';
import '../../cubit/auth_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import 'interview_partner_page2.dart';

class InterviewPartnerPage extends StatefulWidget {
  @override
  _InterviewPartnerPageState createState() => _InterviewPartnerPageState();
}

class _InterviewPartnerPageState extends State<InterviewPartnerPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<AllUserCubit>().fetchAllUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            UserModel user = state.user;
            return Stack(
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
                Center(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      customAppBar(context, _scaffoldKey, false),
                      Center(
                        child: Text(
                          "Choose Your Interview Partner",
                          style: darkTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      BlocConsumer<AllUserCubit, AllUserState>(
                        listener: (context, state) {
                          if (state is AllUserFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: kRedColor,
                                content: Text(state.error),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AllUserSuccess) {
                            print("YASS BERHASIL");
                            print(state.allUsers);
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  for (int i = 0;
                                      i <=
                                          state.allUsers.lastIndexWhere(
                                              (element) => true);
                                      i++)
                                    if (state.allUsers[i].name != user.name)
                                      (buildListFriend(state.allUsers[i]))
                                ],
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: Wrap(
                          children: [
                            buildNextButton(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

Widget buildListFriend(UserModel user) => Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xff183cbb),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                buildImage(user.profileImage),
                const SizedBox(width: 10),
                Text(
                  user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff183cbb),
                  ),
                ),
                const Spacer(),
                buildAddIcon(),
              ],
            ),
          ],
        ),
      ),
    ));

Widget buildImage(String imagePath) {
  final image = NetworkImage(imagePath);

  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
    ),
  );
}

Widget buildAddIcon() {
  return ClipOval(
    child: Material(
      color: Color(0xff183cbb),
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white, size: 20),
        onPressed: () {},
        iconSize: 10,
      ),
    ),
  );
}

Widget buildNextButton(BuildContext context) => ButtonWidget(
      fontSize: 14,
      text: 'Next',
      onClicked: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => InterviewPartnerPage2()));
      },
    );
