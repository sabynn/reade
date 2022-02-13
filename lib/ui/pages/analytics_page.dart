import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reade/cubit/auth_cubit.dart';
import 'package:reade/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chart_analysis.dart';
import '../widgets/chart_analysis_sentiment.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget titleAnalytics(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 10.0),
      child: Row(
        children: [
          Text(
            title,
            style: darkTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              color: kDarkColor,
            ),
          )
        ],
      ),
    );
  }

  Future<void> saveVideo(List<dynamic> videos) async {
    String path = videos[videos.length-1];
    bool? saveVid =
        await GallerySaver.saveVideo(path, albumName: "Interview");
    if (kDebugMode) {
      print('Video recorded to $path $saveVid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
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
                  children: [
                    customAppBar(context, _scaffoldKey, false),
                    Center(
                      child: Text(
                        'Analytics',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(0xFF002884),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: kBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffFAFAFF).withOpacity(0.3),
                                  Color(0xffFAFAFF).withOpacity(0.3),
                                  Color(0xffffffff).withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              children: [
                                titleAnalytics(
                                  "Smiling Scores",
                                  Icons.sentiment_satisfied_alt,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: ChartAnalysis(
                                    arrayScores: state.user.smilingScores,
                                  ),
                                ),
                                titleAnalytics(
                                  "Eye Visibility Scores",
                                  Icons.remove_red_eye,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ChartAnalysis(
                                    arrayScores: state.user.eyeVisibilityScores,
                                  ),
                                ),
                                titleAnalytics(
                                  "Sentiment Scores",
                                  Icons.emoji_emotions_outlined,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ChartAnalysisSentiment(
                                    arrayScores: state.user.sentimentScores,
                                  ),
                                ),
                                CustomButton(
                                  title: "Review Latest Scoring",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/after-interview",
                                    );
                                  },
                                  width: 200,
                                  fontSize: 15,
                                  borderRadius: 30,
                                  heightSize: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: kBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Recent Interview",
                                style: darkTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            Text(
                              "User Interview",
                              style: blueTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: light,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 60.0,
                                right: 60.0,
                                bottom: 15.0,
                              ),
                              child: Card(
                                elevation: 2,
                                shadowColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                // color: kPrimaryColor.withOpacity(0.1),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kDarkColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: kBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Video File",
                                      style: darkTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        onPressed: () {
                                          saveVideo(state.user.videoFile);
                                        },
                                        icon: Icon(
                                          Icons.download,
                                          color: kDarkColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: kBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Expected Answer",
                                style: darkTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                            Text(
                              "Case Interview",
                              style: blueTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: light,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 60.0,
                                right: 60.0,
                                bottom: 15.0,
                              ),
                              child: Card(
                                elevation: 2,
                                shadowColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                // color: kPrimaryColor.withOpacity(0.1),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kDarkColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.file_present,
                                            color: kBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "PDF File",
                                      style: darkTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: kDarkColor,
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
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
