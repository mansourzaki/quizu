import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quizu/helpers/api_helper.dart';
import 'package:quizu/helpers/secure_storage.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/presentaion/home_pages/enter_name.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/presentaion/quiz/question_widget.dart';
import 'package:quizu/router.dart';

import '../models/user.dart';
import '../presentaion/login/otp_screen.dart';

class LoginProvider with ChangeNotifier {
  String? phoneNumber;
  bool isLoggedIn = false;
  bool tokenVerfied = false;
  User? user;
  bool phoneNumberIsValid = false;
  String countrycode = '';
  // String otp = '';
  bool isLoading = false;
  Future<void> login(String otp) async {
    changeLoadingStatus(true);
    if (phoneNumberIsValid) {
      final response = await ApiHelper.apiHelper.login(otp, phoneNumber!);
      if (response['success'] == true) {
        log(response['token'].toString());
        await SecureStorageHelper.secureStoreageHelper
            .saveToken(response['token']);
        isLoggedIn = true;
        tokenVerfied = true;
        if (response['message'] == "user created!") {
          AppRouter.navigatWithReplcamentToWidget(EnterYourNameScreen());
        } else {
          if (response.containsKey('name')) {
            log('in ifff');
            if (response['name'] == null) {
              AppRouter.navigatWithReplcamentToWidget(EnterYourNameScreen());
            } else {
              //  await getUser();
              AppRouter.navigatWithReplcamentToWidget(HomeScreen());

              // user!.name = response['name'];
            }
          }
        }
        await getUser();
      } else {
        log('an error happened');
      }
    }
    changeLoadingStatus(false);
    notifyListeners();
  }

  LoginProvider() {
    verifyToken();
  }

  // void setPin(String pin) {
  //   otp = pin;
  //   notifyListeners();
  // }

  void changeLoadingStatus(bool v) {
    isLoading = v;
    notifyListeners();
  }

  Future<void> validateNumber(String? value) async {
    changeLoadingStatus(true);

    phoneNumberIsValid = await PhoneNumberUtil().validate('$countrycode$value');

    if (phoneNumberIsValid) {
      phoneNumber = '$countrycode$value';
      AppRouter.navigateToWidget(OTPScreen());
    } else {
      phoneNumber = '0';
    }
    changeLoadingStatus(false);
    notifyListeners();
  }

  void saveName(String name) async {
    changeLoadingStatus(true);
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token') ?? '';
    // user!.name = name;
    print(token.toString());
    final response = await ApiHelper.apiHelper.saveName(name, token);
    tokenVerfied = true;
    AppRouter.navigatWithReplcamentToWidget(HomeScreen());
    await getUser();
    changeLoadingStatus(false);
    notifyListeners();
    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcxLCJpYXQiOjE2NjM2ODI5Mzh9.rwn7gffVDSKRJKY_8mSmd9a7vLQpGHnxZqSl1x9fyk4
  }

  void logOut() async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.deleteToken('token');
    isLoggedIn = false;
    tokenVerfied = false;
    user = null;
    notifyListeners();
    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcxLCJpYXQiOjE2NjM2ODI5Mzh9.rwn7gffVDSKRJKY_8mSmd9a7vLQpGHnxZqSl1x9fyk4
  }

  Future<void> getUser() async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token');
    if (token == null) {
      // notifyListeners();
    } else {
      user = await ApiHelper.apiHelper.getUserInfo(token);
    }
    notifyListeners();
  }

  Future<void> verifyToken() async {
    changeLoadingStatus(true);
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
          await getUser();
          tokenVerfied = true;
        } else {
          tokenVerfied = false;
        }
      }
    }
    changeLoadingStatus(false);

    notifyListeners();
  }
}
