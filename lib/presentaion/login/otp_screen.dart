import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:quizu/presentaion/home_pages/enter_name.dart';
import '../../providers/login_provider.dart';
import '../resources/resources.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _controller = TextEditingController();
  final _formFieldKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formFieldKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(fontSize: FontSize.s64),
            ),
            SizedBox(
              height: AppHeight.h108,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w11),
              child: Text(
                AppStrings.otpScreen,
                style: TextStyle(fontSize: FontSize.s24),
              ),
            ),
            SizedBox(
              height: AppHeight.h72,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.w11),
                child: Pinput(
                  controller: _controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid pin';
                    } else if (value.length != 4) {
                      return 'Pin should be 4 digits!';
                    } else if (value != '0000') {
                      return 'Pin is incorrect';
                    } else {
                      return null;
                    }
                  }),
                  showCursor: true,
                )),
            SizedBox(
              height: AppHeight.h72,
            ),
            context.watch<LoginProvider>().isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_formFieldKey.currentState!.validate()) {
                        log('in if');
                         await context.read<LoginProvider>().login(_controller.text);
                      }

                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const EnterYourNameScreen()));
                    },
                    child: Text(
                      'Check',
                      style: TextStyle(color: Color(0xFF50524F)),
                    ))
          ],
        ),
      ),
    );
  }
}
