import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    MovierViewModel movierViewModel = Provider.of<MovierViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  buildLogo(),
                  _buildWelcome(),
                  _buildCreateAcount(),
                  buildLoginTextformField(
                      iconData: Icons.email,
                      hintText: 'E-mail',
                      controller: emailController),
                  const SizedBox(
                    height: 15,
                  ),
                  buildLoginTextformField(
                      controller: passwordController,
                      iconData: Icons.lock_person,
                      hintText: 'Password'),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      movierViewModel.signupMovier(
                          emailController.text, passwordController.text);
                    },
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
        ),
      ),
    );
  }

  // ElevatedButton _buildSignupButton(MovierViewModel movierViewModel) {
  //   return ElevatedButton(
  //     onPressed: () {movierViewModel.signupMovier(email, password)

  //     },
  //     child: Text(
  //       'Sign up',
  //       style: TextStyles.robotoBold18Style,
  //     ),
  //   );
  // }

  Padding _buildCreateAcount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Create your account',
        style: TextStyles.robotoRegular16Style
            .copyWith(color: Colors.white.withOpacity(0.6)),
      ),
    );
  }

  Padding _buildWelcome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        'Welcome!',
        style: TextStyles.robotoRegular32Style
            .copyWith(color: Colors.white.withOpacity(0.6)),
      ),
    );
  }
}
