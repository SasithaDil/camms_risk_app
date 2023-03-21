import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/features/auth/presentation/widgets/login_text_field.dart';
import 'package:risk_sample/routes/routes.dart';
import 'package:risk_sample/utils/assets.dart';
import 'package:risk_sample/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final _organizationNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FocusTraversalGroup(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.mQHeight * 0.2,
                        ),
                        Image.asset(riskLoginLogo),
                        SizedBox(
                          height: context.mQHeight * 0.05,
                        ),
                        SizedBox(
                          width: context.mQWidth * 0.8,
                          child: LoginTextField(
                            textEditingController: _organizationNameController,
                            validationMsg: 'Please enter the Organization',
                            labelText: 'Organization',
                            iconString: orgIcon,
                          ),
                        ),
                        SizedBox(
                          width: context.mQWidth * 0.8,
                          child: LoginTextField(
                            textEditingController: _usernameController,
                            validationMsg: 'Please enter the Username',
                            labelText: 'Username',
                            iconString: usernameIcon,
                          ),
                        ),
                        SizedBox(
                          width: context.mQWidth * 0.8,
                          child: LoginTextField(
                            textEditingController: _passwordController,
                            validationMsg: 'Please enter the Password',
                            labelText: 'Password',
                            iconString: pwIcon,
                            isPassword: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: context.mQWidth * 0.1),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              const Text('Remember me')
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: context.mQWidth * 0.1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                //TODO: change navigation when done
                                onTap: () => Navigator.pushNamed(
                                    context, ScreenRoutes.toDetailsScreen),
                                child: Container(
                                  height: UI.padding4x * 1.5,
                                  width: UI.padding8x * 1.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: buttonColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Sign in',
                                        style: TextStyle(
                                            color: white, fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        width: UI.padding,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: UI.padding8x * 2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: context.appBarHeight < 900.0
                            ? context.mQHeight * 0.2
                            : context.mQHeight * 0.25,
                        left: UI.padding3x,
                        right: UI.padding3x),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          icon: settingsIcon,
                          text: 'Settings',
                          onPressed: () {},
                          color: grey,
                        ),
                        CustomIconButton(
                          icon: supportIcon,
                          text: 'Support',
                          onPressed: () {},
                          color: grey,
                        ),
                      ],
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
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.color,
  });

  final VoidCallback onPressed;
  final String text;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(
            width: UI.padding,
          ),
          Text(
            text,
            style: const TextStyle(
              color: grey,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
