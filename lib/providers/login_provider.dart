import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizu/helpers/api_helper.dart';
import 'package:quizu/helpers/secure_storage.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/presentaion/home_pages/enter_name.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/presentaion/quiz/question_widget.dart';
import 'package:quizu/router.dart';

import '../models/user.dart';

class LoginProvider with ChangeNotifier {
  String? phoneNumber;
  bool isLoggedIn = false;
  bool tokenVerfied = false;
  User? user;
  Future<void> login(String otp) async {
    if (phoneNumber != null) {
      final response = await ApiHelper.apiHelper.login(otp, phoneNumber!);
      if (response['success'] == true) {
        log(response['token'].toString());
        await SecureStorageHelper.secureStoreageHelper
            .saveToken(response['token']);
        isLoggedIn = true;
        tokenVerfied = true;
        user = User(mobile: response['mobile']);
        if (response['message'] == "user created!") {
          AppRouter.navigatWithReplcamentToWidget(EnterYourNameScreen());
        } else {
          if (response.containsKey('name')) {
            log('in ifff');
            if (response['name'] == null) {
              AppRouter.navigatWithReplcamentToWidget(EnterYourNameScreen());
            } else {
              AppRouter.navigatWithReplcamentToWidget(HomeScreen());
              user!.name = response['name'];
            }
          }
        }
      } else {
        log('an error happened');
      }
    }

    notifyListeners();
  }

  LoginProvider() {
    verifyToken();
  }

  void saveName(String name) async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token') ?? '';
    user!.name = name;
    print(token.toString());
    final response = await ApiHelper.apiHelper.saveName(name, token);
    tokenVerfied = true;
    AppRouter.navigatWithReplcamentToWidget(HomeScreen());

    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcxLCJpYXQiOjE2NjM2ODI5Mzh9.rwn7gffVDSKRJKY_8mSmd9a7vLQpGHnxZqSl1x9fyk4
  }

  void logOut() async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.deleteToken('token');
    isLoggedIn = false;
    tokenVerfied = false;

    notifyListeners();
    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcxLCJpYXQiOjE2NjM2ODI5Mzh9.rwn7gffVDSKRJKY_8mSmd9a7vLQpGHnxZqSl1x9fyk4
  }

  Future<void> verifyToken() async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token');
    if (token == null) {
      tokenVerfied = false;
      isLoggedIn = false;

      // notifyListeners();
    } else {
      final response = await ApiHelper.apiHelper.verifyToken(token);
      if (response.containsKey('success')) {
        if (response['message'] == "Your token is valid!") {
          tokenVerfied = true;
        } else {
          tokenVerfied = false;
        }
      }
    }
    notifyListeners();
  }
}
