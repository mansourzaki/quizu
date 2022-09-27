import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizu/presentaion/resources/resources.dart';
import 'package:quizu/providers/login_provider.dart';

import '../../providers/quiz_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<QuizProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      context.read<LoginProvider>().logOut();
                       
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                    ))),
            Text(
              'Profile',
              style: TextStyle(
                  fontSize: FontSize.s48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 70,
            ),
            context.watch<LoginProvider>().isLoading
                ? CircularProgressIndicator()
                : Text(
                    context.watch<LoginProvider>().user!.name!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
            const SizedBox(
              height: 10,
            ),
            context.watch<LoginProvider>().isLoading
                ? CircularProgressIndicator()
                : Text(
                    'Mobile: ${context.watch<LoginProvider>().user!.mobile.toString()}',
                    style: const TextStyle(fontSize: 20),
                  ),
            const SizedBox(
              height: 70,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'My Scores',
              style: TextStyle(
                  fontSize: FontSize.s36, fontWeight: FontWeight.bold),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  provider.myScores.length,
                  (index) => SizedBox(
                        width: 300.w,
                        height: 40.h,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('h:mm a d/M/yyyy ').format(
                                    DateTime.parse(provider
                                        .myScores[index].date
                                        .toString())),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: FontSize.s24,
                                ),
                              ),
                              Container(
                                width: 50.w,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.myScores[index].score.toString(),
                                    style: TextStyle(fontSize: FontSize.s24),
                                  ),
                                ),
                              )
                            ]),
                      )),
            )

            // Table(
            //   // columnWidths: {1: FixedColumnWidth(3), 2: FixedColumnWidth(1)},
            //   //defaultColumnWidth: FixedColumnWidth(150),
            //   children: List.generate(
            //       provider.myScores.length,
            //       (index) => TableRow(children: [
            //             Center(
            //                 child: Text(
            //               DateFormat('h:mm a d/M/yyyy ').format(DateTime.parse(
            //                   provider.myScores[index].date.toString())),
            //               style: TextStyle(
            //                 fontSize: FontSize.s24,
            //               ),
            //             )),
            //             Text(
            //               provider.myScores[index].score.toString(),
            //               style: TextStyle(fontSize: FontSize.s24),
            //             )
            //           ])),
            // ),
          ],
        ),
      ),
    );
  }
}
