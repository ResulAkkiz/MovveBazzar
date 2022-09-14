import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_constants/image_enums.dart';
import 'package:flutter_application_1/app_constants/text_styles.dart';
import 'package:flutter_application_1/app_constants/widget_extension.dart';

import 'package:flutter_application_1/pages/signup_screen.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/viewmodel/movier_view_model.dart';
import 'package:provider/provider.dart';

import '../app_constants/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

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
                    _buildWelcomeBack(),
                    _buildLoginAcount(),
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
                            }

                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await movierViewModel.signinMovier(
                                  emailController.text,
                                  passwordController.text);
                              if (errorMessage.isNotEmpty) {
                                if (!mounted) return;
                                buildShowModelBottomSheet(context);
                              }
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyles.robotoBold18Style,
                          ),
                        ),
                      ],
                    ).separated(const SizedBox(
                      height: 15,
                    )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.07, 0, 0),
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
                        const Text("Don't have an account? "),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ));
                            },
                            child: Text(
                              'Sign up here.',
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

  Padding _buildWelcomeBack() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        'Welcome Back!',
        style: TextStyles.robotoRegular32Style
            .copyWith(color: Colors.white.withOpacity(0.6)),
      ),
    );
  }

  Padding _buildLoginAcount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Login to your account',
        style: TextStyles.robotoRegular16Style
            .copyWith(color: Colors.white.withOpacity(0.6)),
      ),
    );
  }
}
