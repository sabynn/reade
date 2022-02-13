import 'package:reade/cubit/auth_cubit.dart';
import 'package:reade/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.only(
                left: 35,
                right: defaultMargin,
                top: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${state.user.name}',
                    style: darkTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Prepare Your Interview',
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }

    Widget cardInterview(
      String title,
      String subTitle,
      String route,
    ) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    title,
                    style: darkTextStyle.copyWith(
                      fontSize: 19,
                      fontWeight: black,
                    ),
                  ),
                  subtitle: Text(
                    subTitle,
                    style: darkTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/pre-interview',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _resourcesCard(
      String title,
      String subTitle,
      String route,
      BuildContext context,
    ) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 14.0,
          bottom: 20.0,
        ),
        child: SizedBox(
          width: 180,
          height: 150,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            color: kBackgroundColor,
            shadowColor: kPrimaryColor,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: darkTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: Center(
                      child: Text(
                        subTitle,
                        style: darkTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: light,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {},
                    title: 'Open',
                    heightSize: 30,
                    width: 100,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: customDrawer(context),
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
              Center(
                child: ListView(
                  children: [
                    customAppBar(context, _scaffoldKey, true,),
                    header(),
                    cardInterview(
                      'HR Interview',
                      'Practice how to explain your personality, your strengths, your weaknesses, your capability to handle the role, your background, and compatibility for job.',
                      'interview-page',
                    ),
                    cardInterview(
                      'User Interview',
                      'Practice how to explain about skill, experiences, and education background.',
                      'interview-page',
                    ),
                    cardInterview(
                      'Case Interview',
                      'Practice how to explain your personality, your strengths, your weaknesses, your capability to handle the role, your background, and compatibility for job.',
                      'interview-page',
                    ),
                    cardInterview(
                      'Focus Group Discussion',
                      'Practice how to discuss in small group of people, answer a series of questions and report on the responses led by a moderator ',
                      'interview-page',
                    ),
                    cardInterview(
                      'Leaderless Group Discussion',
                      'Practice how to discuss in small group of people, answer a series of questions and report on the responses with no identified moderator.',
                      'interview-page',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            bottom: 5.0,
                          ),
                          child: Text("Get trusted resources",
                              style: darkTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text("See more",
                              style: darkTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _resourcesCard(
                            "All About SWOT",
                            "Get to know all about SWOT",
                            "",
                            context,
                          ),
                          _resourcesCard(
                            "Answer Interview 101",
                            "Learn about interview questions",
                            "",
                            context,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
