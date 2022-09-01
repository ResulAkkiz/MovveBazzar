import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  'Welcome!',
                  style: TextStyles.robotoRegular32Style
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Create your account',
                  style: TextStyles.robotoRegular16Style
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              buildLoginTextformField(
                  iconData: Icons.person, hintText: 'Username'),
              buildLoginTextformField(
                  iconData: Icons.email, hintText: 'E-mail'),
              buildLoginTextformField(
                  iconData: Icons.lock_person, hintText: 'Password'),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign up',
                  style: TextStyles.robotoBold18Style,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.10, 0, 0),
                child: Column(
                  children: [
                    Text(
                      '---------------Or sign up with---------------',
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
            ],
          ),
        ),
      ),
    );
  }
}
