import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_ride/presentation/ui/pages/auth/sing_up.dart';
import '../../templates.dart';
import '../home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: Templates.hintTextStyle,
        decoration: Templates.inputDecoration('Email', CupertinoIcons.mail));

    Widget passwordTextField = TextField(
        controller: passwordController,
        style: Templates.hintTextStyle,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: Templates.inputDecoration('Password', CupertinoIcons.lock));

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
                        const Text('Sign In', style: Templates.title),
                        Templates.spaceBoxH,
                        emailTextField,
                        Templates.spaceBoxH,
                        passwordTextField,
                        Templates.spaceBoxH,
                        Templates.elevatedButton("Login", () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Home()));
                        }),
                      ],

                    ),
                    Templates.captionRowForPage("Don't have an account?", 'Sign Up', context, const SignUp())
                  ],
                ),
              ),
            ),
          )),
    );
  }
}