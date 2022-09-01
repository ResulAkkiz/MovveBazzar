import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildLogo(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Welcome back!',
                  style: TextStyles.robotoRegular32Style
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Login to your account',
                  style: TextStyles.robotoRegular16Style
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              buildTextformField(iconData: Icons.person, hintText: 'Username'),
              buildTextformField(
                  iconData: Icons.lock_person, hintText: 'Password'),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign in',
                  style: TextStyles.robotoBold18Style,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.10, 0, 0),
                child: Column(
                  children: [
                    Text(
                      '---------------Or sign in with---------------',
                      style: TextStyles.robotoRegular16Style.copyWith(
                          color: Colors.white.withOpacity(0.6),
                          letterSpacing: 0.8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSigninContainer(
                            svgPicture: IconEnums.google.toImage),
                        buildSigninContainer(
                            svgPicture: IconEnums.twitter.toImage),
                      ],
                    ).separated(const SizedBox(
                      width: 15,
                    ))
                  ],
                ).separated(
                  const SizedBox(
                    height: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                      onPressed: () {}, child: const Text('Sign up here'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSigninContainer({required SvgPicture svgPicture}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: IconButton(onPressed: () {}, icon: svgPicture));
  }

  Padding buildTextformField({
    required IconData iconData,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16.0,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.fromLTRB(74, 12, 10, 12)),
          ),
          CircleAvatar(
            radius: 32,
            child: Icon(
              iconData,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  RichText buildLogo() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Mov',
            style: TextStyles.splashLogoStyle,
          ),
          TextSpan(
            text: 've',
            style: TextStyles.splashLogoStyle.copyWith(
              color: const Color(0xFFE11A38),
            ),
          ),
        ],
      ),
    );
  }
}
