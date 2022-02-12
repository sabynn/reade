import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';

class AfterInterviewPage extends StatelessWidget {
  UserModel? user;

  AfterInterviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget scoringSection(String title, var score, String limit) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: darkTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    score.toString(),
                    style: darkTextStyle.copyWith(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Text(
              limit,
              style: greyTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

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
          Center(
            child: SafeArea(
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    print(state.user);
                    user = state.user;
                    return ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: defaultMargin,
                            right: defaultMargin,
                            top: 30,
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Congrats,\n${state.user.name}',
                                    style: darkTextStyle.copyWith(
                                      fontSize: 24,
                                      fontWeight: semiBold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Center(
                                  child: Text(
                                    'This is the result of your interview',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: light,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        scoringSection(
                            "Eye Visibility Score",
                            state
                                .user
                                .eyeVisibilityScores[
                                    state.user.eyeVisibilityScores.length - 1]
                                .toString(),
                            "/100.0"),
                        scoringSection(
                            "Smiling Score",
                            state
                                .user
                                .smilingScores[
                                    state.user.smilingScores.length - 1]
                                .toString(),
                            "/100.0"),
                        scoringSection(
                            "Sentiment Score",
                            state
                                .user
                                .sentimentScores[
                                    state.user.sentimentScores.length - 1]
                                .toString(),
                            "*score < 0 means negative sentiment\n "
                                "score == 0 means neutral sentiment\n "
                                "score > 0 means positive sentiment"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            title: 'See Analytics',
                            onPressed: () {},
                            width: 20,
                            heightSize: 45,
                            margin: const EdgeInsets.only(
                              left: 30,
                              right: 30,
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
            ),
          ),
        ],
      ),
    ));
  }
}
