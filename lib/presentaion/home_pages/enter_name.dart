import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/providers/login_provider.dart';

import '../resources/resources.dart';

class EnterYourNameScreen extends StatefulWidget {
  const EnterYourNameScreen({Key? key}) : super(key: key);

  @override
  State<EnterYourNameScreen> createState() => _EnterYourNameScreenState();
}

class _EnterYourNameScreenState extends State<EnterYourNameScreen> {
  final TextEditingController _controller = TextEditingController();
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
            Container(
                child: Text(
              AppStrings.appName,
              style: TextStyle(fontSize: FontSize.s64),
            )),
            SizedBox(
              height: AppHeight.h148,
            ),
            Container(
                child: Text(
              AppStrings.enterName,
              style: TextStyle(fontSize: FontSize.s24),
            )),
            SizedBox(
              height: AppHeight.h35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w11),
              child: TextFormField(
                  controller: _controller,
                  initialValue: null,
                  // validator: (value)  {
                  //   if (value == null) {
                  //     return 'Please enter phone number';
                  //   } else if (await PhoneNumberUtil()
                  //       .validate(value.toString())) {
                  //     return 'Please enter valid phone number';
                  //   }
                  // },
                  decoration: const InputDecoration(
                    hintText: 'ex Ahmed',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  )),
            ),
            SizedBox(
              height: AppHeight.h72,
            ),
            context.watch<LoginProvider>().isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      // if (_formFieldKey.currentState!.validate()) {
                      context.read<LoginProvider>().saveName(_controller.text);
                      //  }
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Color(0xFF50524F)),
                    ))
          ],
        ),
      ),
    );
  }
}
