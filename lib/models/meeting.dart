import 'package:reade/models/user_model.dart';

class Meeting {
  List<UserModel> usersPartner;
  String date;
  String time;
  String meetLinks;

  Meeting({
    required this.usersPartner,
    required this.date,
    required this.time,
    this.meetLinks = "https://meet.google.com/_meet/zfv-jgzq-evq"
  });
}
