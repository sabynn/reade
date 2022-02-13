import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/shared/theme.dart';

import '../../cubit/auth_cubit.dart';
import '../../models/meeting.dart';
import '../../models/user_model.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import 'interview_partner_page.dart';
import 'meeting_board_page.dart';

class InterviewPartnerPage2 extends StatefulWidget {
  final List<UserModel> usersPartner;
  const InterviewPartnerPage2({Key? key, required this.usersPartner})
      : super(key: key);

  @override
  _InterviewPartnerPage2State createState() => _InterviewPartnerPage2State();
}

class _InterviewPartnerPage2State extends State<InterviewPartnerPage2> {
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController timeController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    dateController.text = selectedDate.toString().substring(0, 10);
    timeController.text = selectedTime.toString().substring(11, 15);
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Interview Partner',
        InterviewPartnerPage(),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Input Your Meeting Date and Time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                dateInput("Date", dateController, "Input date"),
                dateInput("Time", timeController, "Input time"),
                Center(
                  child: Wrap(
                    children: [
                      buildConfirmButton(context),
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

  late String articlePublishedDate;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990, 1),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.blue, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kDarkColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        articlePublishedDate = picked.toString().substring(0, 10);
        dateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = '$picked'.substring(11, 15);
      });
    }
  }

  Widget dateInput(
    String text,
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
          ),
          const SizedBox(
            height: 3,
          ),
          TextFormField(
            cursorColor: Color(0xffa9bbea),
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                borderSide: const BorderSide(
                  color: Color(0xff456ed9),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  text == "Date"
                      ? Icons.calendar_today_rounded
                      : Icons.access_alarm,
                ),
                onPressed: () {
                  text == "Date" ? _selectDate(context) : _selectTime(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmButton(BuildContext context) => ButtonWidget(
        fontSize: 14,
        text: 'Confirm',
        onClicked: () {
          Meeting createMeet = Meeting(
            date: dateController.text,
            time: timeController.text,
            usersPartner: widget.usersPartner,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => MeetingBoardPage(
                addMeeting: createMeet,
              ),
            ),
          );
        },
      );
}
