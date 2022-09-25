import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/helpers/secure_storage.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/presentaion/login/login_screen.dart';

import 'package:quizu/presentaion/resources/resources.dart';
import 'package:quizu/providers/login_provider.dart';
import 'package:quizu/router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  void initfun(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    AppRouter.navigatWithReplcamentToWidget(HomeScreen());

    log(context.read<LoginProvider>().tokenVerfied.toString());
  }

  @override
  Widget build(BuildContext context) {
    initfun(context);
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appName,
          style: TextStyle(fontSize: FontSize.s64),
        ),
      ),
    );
  }
}
