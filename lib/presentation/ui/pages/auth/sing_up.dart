import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride/presentation/ui/pages/auth/sign_in.dart';
import '../../templates.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = Templates.textField(emailController, 'Email',
        CupertinoIcons.mail, TextInputType.emailAddress, () => {}, false);
    Widget passwordTextField = Templates.textField(
        passwordController,
        'Password',
        CupertinoIcons.lock,
        TextInputType.visiblePassword,
        () => {},
        true);
    Widget usernameTextField = Templates.textField(
        usernameController,
        'Username',
        CupertinoIcons.person,
        TextInputType.name,
        () => {},
        false);
    List<Widget> textFields = [
      usernameTextField,
      emailTextField,
      passwordTextField,
    ];
    return Scaffold(
      backgroundColor: Templates.whiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: Templates.paddingApp,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(),
                    Column(
                      children: [
                        const Text('Sign Up', style: Templates.title),
                        Templates.spaceBoxH,
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: Templates.paddingBottom,
                              child: textFields[index],
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: textFields.length,
                        ),
                        Templates.elevatedButton("Sign Up", () {})
                      ],
                    ),
                    Templates.captionRowForPage("Already have an account?", 'Sign In', context, const SignIn())
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
