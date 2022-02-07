import 'package:reade/cubit/auth_cubit.dart';
import 'package:reade/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            print(state.user);
            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,\n${state.user.name}',
                          style: darkTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Prepare Your Interview',
                          style: greyTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          state.user.profileImage,
                        ),
                      ),
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

    return Scaffold(
      body: ListView(
        children: [
          header(),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kRedColor,
                    content: Text(state.error),
                  ),
                );
              } else if (state is AuthInitial) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/sign-in', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Center(
                child: CustomButton(
                  title: 'Sign Out',
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                  width: 220,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
