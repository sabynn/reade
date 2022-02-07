import 'package:reade/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/image_get_started.png',
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Welcome',
                  style: whiteTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Reade: Your Future Companion.',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.left,
                ),
                CustomButton(
                  title: 'Sign In',
                  width: 320,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
                CustomButton(
                  title: 'Create Account',
                  width: 320,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 80,
                  ),
                  transparent: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
