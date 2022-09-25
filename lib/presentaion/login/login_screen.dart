import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

import 'package:provider/provider.dart';
import 'package:quizu/helpers/secure_storage.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:quizu/presentaion/login/otp_screen.dart';
import 'package:quizu/presentaion/resources/app_string.dart';
import 'package:quizu/presentaion/resources/font_manager.dart';
import 'package:quizu/presentaion/resources/values_manager.dart';

import 'package:quizu/providers/login_provider.dart';
import 'package:quizu/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formFieldKey = GlobalKey<FormFieldState>();
  String _countrycode = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool phoneValiation(String? value) {
    bool phoneNumberIsValid = false;
    PhoneNumberUtil().validate('$_countrycode$value').then((value) {
      log(value.toString());
      setState(() {});
      phoneNumberIsValid = value;
    });
    return phoneNumberIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
              AppStrings.appName,
              style: TextStyle(fontSize: FontSize.s64),
            )),
            SizedBox(
              height: AppHeight.h148,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile',
                  style: TextStyle(color: Colors.black, fontSize: FontSize.s18),
                ),
              ),
            ),
            SizedBox(
              height: AppHeight.h2,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.w11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CountryCodePicker(
                        onInit: (prefix) => _countrycode = '+966',
                        onChanged: (prefix) {
                          _countrycode = prefix.dialCode.toString();
                        },
                        initialSelection: 'SA',
                        showFlag: true,
                        hideMainText: true,
                        showDropDownButton: true,
                        dialogSize: Size(300, 300),
                        showOnlyCountryWhenClosed: true,
                        alignLeft: false,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: _formFieldKey,
                          controller: _controller,
                          keyboardType: TextInputType.phone,
                          validator: (value) => phoneValiation(value)
                              ? "Enter valid number"
                              : null,
                          // validator: (value) {
                          //   bool x = false;
                          //   PhoneNumberUtil()
                          //       .validate('$_countrycode$value')
                          //       .then((value) {
                          //     log(value.toString());
                          //     x = value;
                          //   });
                          //   if (x) {
                          //     return null;
                          //   } else {
                          //     return 'Enter valid number';
                          //   }
                          // },
                          decoration: InputDecoration(
                              hintText: AppStrings.numberHint,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              )),
                        ),
                      ),
                    ),
                  ],
                )

                // child: TextField(
                //     controller: _controller,

                //     decoration: const InputDecoration(
                //       hintText: AppStrings.numberHint,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(),
                //       ),
                //     )),
                ),
            SizedBox(
              height: AppHeight.h72,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formFieldKey.currentState!.validate()) {
                    log(_controller.text);
                    print(await SecureStorageHelper.secureStoreageHelper
                        .readToken('token'));
                    context.read<LoginProvider>().phoneNumber =
                        '$_countrycode${_controller.text}}';
                    AppRouter.navigateToWidget(OTPScreen());
                  } else {
                    log('message');
                  }
                },
                child: const Text(
                  'Start',
                  style: TextStyle(color: Color(0xFF50524F)),
                ))
          ],
        ),
      ),
    );
  }
}
