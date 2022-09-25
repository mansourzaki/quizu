import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/router.dart';

import '../resources/resources.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                   AppRouter.pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ))),
          const SizedBox(
            height: 150,
          ),
          Text(
            '😥',
            style: TextStyle(fontSize: 100),
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Try again'))
        ],
      ),
    );
  }
}
