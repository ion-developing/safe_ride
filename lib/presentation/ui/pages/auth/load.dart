import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../templates.dart';
import 'sign_in.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});
  @override
  State<LoadPage> createState() => _LoadPageState();
}
class _LoadPageState extends State<LoadPage> {
  // bool loading = false;

  void _checkLoginStatus() {
    // setState(() {
    //   loading = true;
    // });
    // await Future.delayed(const Duration(seconds: 2));
    // setState(() {
    //   loading = false;
    // });
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Templates.whiteColor,
      // body: loading ? LoadingEffect.loading: Center(
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Safe\nRide', style:Templates.head),
              Templates.spaceBoxNH(MediaQuery.of(context).size.height * 0.1),
              IconButton(onPressed: ()=> _checkLoginStatus(),
                  icon: const Icon(CupertinoIcons.arrow_right_circle_fill),
                  iconSize: 60, color: Templates.primaryTurquoiseColor)
            ],
          )
      ),
    );
  }
}