import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/common_widgets.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/pages/login_screen.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MovierViewModel movierViewModel = Provider.of<MovierViewModel>(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    buildLogo(),
                    _buildWelcome(),
                    _buildCreateAcount(),
                    Column(
                      children: [
                        buildSignupTextformField(
                          context: context,
                          iconData: Icons.email,
                          hintText: 'E-mail',
                          controller: emailController,
                          isPassword: false,
                          validator: (text) {
                            if (text == '' || text == null) {
                              return 'Please insert valid e-mail adress';
                            } else {
                              if (!text.contains('@')) {
                                return 'Please insert valid e-mail adress';
                              }
                              return null;
                            }
                          },
                        ),
                        buildSignupTextformField(
                          context: context,
                          controller: passwordController,
                          iconData: Icons.lock_person,
                          hintText: 'Password',
                          isPassword: true,
                          validator: (text) {
                            if (text == '' || text == null) {
                              return 'Please insert valid password';
                            } else if (text.length < 5) {
                              return 'Please insert password has more than 4 characters';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await movierViewModel.signupMovier(
                                  emailController.text,
                                  passwordController.text);
                              if (errorMessage.isNotEmpty) {
                                if (!mounted) return;
                                buildShowModelBottomSheet(context);
                              }
                              if (movierViewModel.movier != null) {
                                if (!mounted) return;
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyles.robotoBold18Style,
                          ),
                        ),
                      ],
                    ).separated(const SizedBox(
                      height: 15,
                    )),
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
                                  onPressed: () {
                                    movierViewModel.googlesignupMovier();
                                  },
                                  svgPicture: IconEnums.google.toImage),
                              buildSigninContainer(
                                  onPressed: () {},
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
                        const Text("You have an account? "),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Sign in here.',
                              style: TextStyles.robotoMediumStyle,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
