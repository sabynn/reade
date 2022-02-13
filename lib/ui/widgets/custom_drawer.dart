import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../shared/theme.dart';
import 'custom_button.dart';

Widget customDrawer(context) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, -0.5),
          end: Alignment(1.0, 1.5),
          colors: [Colors.white, Color(0xFF557FED)],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: SizedBox(
                width: 100,
                child: Image.asset(
                  'assets/images/logo_reade.png',
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: darkTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            leading: Icon(
              Icons.home,
              color: kDarkColor,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            title: Text(
              'Interview Partner',
              style: darkTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            leading: Icon(
              Icons.group_add_rounded,
              color: kDarkColor,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/interview-partner",
              );
            },
          ),
          ListTile(
            title: Text(
              'Resources',
              style: darkTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            leading: Icon(
              Icons.file_copy_rounded,
              color: kDarkColor,
              size: 30.0,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Result Analytics',
              style: darkTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            leading: Icon(
              Icons.bar_chart_rounded,
              color: kDarkColor,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/analytics",
              );
            },
          ),
          ListTile(
            title: Text(
              'Meeting Boards',
              style: darkTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            leading: Icon(
              Icons.people_outline_rounded,
              color: kDarkColor,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/meeting-boards",
              );
            },
          ),
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
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CustomButton(
                    title: 'Log Out',
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    heightSize: 45,
                    width: 150,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
