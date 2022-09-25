import 'package:flutter/material.dart';
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
                     // context.read<LoginProvider>().logOut();
                    //  context.read<QuizProvider>().deleteAllMyScore();
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
            const Text(
              'Name: Mansour Alhaddad',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Mobile: +972567850025',
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
            Table(
              children: List.generate(
                  provider.myScores.length,
                  (index) => TableRow(children: [
                        Center(
                            child: Text(
                          DateFormat('h:mm a d/m/yyyy').format(DateTime.parse(
                              provider.myScores[index].date.toString())),
                          style: TextStyle(fontSize: FontSize.s24),
                        )),
                        Center(
                            child: Text(
                          provider.myScores[index].score.toString(),
                          style: TextStyle(fontSize: FontSize.s24),
                        ))
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
