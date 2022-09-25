import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:quizu/presentaion/home_pages/enter_name.dart';

import '../../providers/login_provider.dart';
import '../resources/resources.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 80,
                style: TextStyle(fontSize: FontSize.s24),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (va) {},
                onCompleted: (pin) async {
                  if (pin == '0000') {}
                },
              )),
          SizedBox(
            height: AppHeight.h72,
          ),
          ElevatedButton(
              onPressed: () async {
                await context.read<LoginProvider>().login('0000');
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const EnterYourNameScreen()));
              },
              child: const Text(
                'Check',
                style: TextStyle(color: Color(0xFF50524F)),
              ))
        ],
      ),
    );
  }
}
