import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../models/meeting.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../shared/theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingBoardPage extends StatefulWidget {
  List<Meeting?> meetingSchedule = [];
  Meeting? addMeeting;

  MeetingBoardPage({Key? key, this.addMeeting}) : super(key: key);
  @override
  _MeetingBoardPageState createState() => _MeetingBoardPageState();
}

class _MeetingBoardPageState extends State<MeetingBoardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel userModel;
  late bool doneSave = false;
  Map<String?, dynamic> detailMeeting = {};
  List<String> usersPartner = [];

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Widget buildButton(BuildContext context, UserModel user) => ButtonWidget(
        fontSize: 14,
        text: 'Save Meeting',
        onClicked: () {
          context.read<AuthCubit>().updateUserData(userUpdate: user);
          Navigator.pushNamed(context, "/home");
        },
      );

  Future<List<UserModel>> fetchUser(List<dynamic> userIdPartner) async {
    List<UserModel> allPartners = [];
    for(String uId in userIdPartner){
      UserModel user = await UserService().getUserById(uId);
      allPartners.add(user);
    }
    return allPartners;
  }
  Widget buildListSchedule(var schedule) {
    String date = schedule["date"];
    String time = schedule["time"];
    String meetLinks = schedule["meetLinks"];
    List<dynamic> userIdPartner = schedule["userPartners"];

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                kWhiteColor,
                const Color(0xffebf1f8),
                const Color(0xffebf1f8),
                const Color(0xffebf1f8),
                kWhiteColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: kDarkColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        date,
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.access_alarm,
                      color: kDarkColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        time,
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: Text(
                    meetLinks,
                    style: darkTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: black,
                    ),
                  ),
                  onTap: (){
                    _launchURL(meetLinks);
                  },
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: kDarkColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Interview Partners",
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: FutureBuilder<List<UserModel>>(
                    future: fetchUser(userIdPartner),
                    builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 65,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var partner = snapshot.data?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProfileWidget(
                                  imagePath: partner!.profileImage,
                                  height: 50,
                                  width: 50,
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const SizedBox();
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addMeeting != null) {
      widget.meetingSchedule.add(widget.addMeeting);
      detailMeeting["date"] = widget.addMeeting?.date;
      detailMeeting["time"] = widget.addMeeting?.time;
      detailMeeting["meetLinks"] = widget.addMeeting?.meetLinks;
      for (UserModel user in widget.addMeeting!.usersPartner) {
        usersPartner.add(user.id);
      }
      detailMeeting["userPartners"] = usersPartner;
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context),
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              UserModel user = state.user;
              if (widget.addMeeting != null) {
                state.user.schedule.add(detailMeeting);
              }
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
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      customAppBar(
                        context,
                        _scaffoldKey,
                        false,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Your Upcoming Meeting",
                          style: darkTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (var sched in user.schedule)
                        if (sched != null && sched.isNotEmpty)
                          (buildListSchedule(sched)),
                      widget.addMeeting != null
                          ? Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: buildButton(context, user),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}


