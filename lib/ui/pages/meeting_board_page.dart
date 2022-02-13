import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/ui/pages/profile_page.dart';
import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import 'interview_partner_page.dart';

class MeetingBoardPage extends StatefulWidget {
  @override
  _MeetingBoardPageState createState() => _MeetingBoardPageState();
}

class _MeetingBoardPageState extends State<MeetingBoardPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context, 'Meeting Board', InterviewPartnerPage()),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            print(state.user);
            UserModel user = state.user;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                Text(
                  "Your Upcoming Meeting",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                for (int i = 0;
                    i <= user.schedule.lastIndexWhere((element) => true);
                    i++)
                  (buildListSchedule(user.schedule[i])),
                const SizedBox(height: 70),
                Center(
                  child: Wrap(
                    children: [
                      buildBackButton(context),
                    ],
                  ),
                )
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

Widget buildListSchedule(String schedule) => Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xff183cbb),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Text(
                  schedule,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff183cbb),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));

Widget buildBackButton(BuildContext context) => ButtonWidget(
      fontSize: 14,
      text: 'Back',
      onClicked: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage()));
      },
    );
