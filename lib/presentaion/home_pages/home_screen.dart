import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/presentaion/home_pages/leaderboard_screen.dart';
import 'package:quizu/presentaion/home_pages/profile_screen.dart';
import 'package:quizu/presentaion/home_pages/questions_screen.dart';
import 'package:quizu/presentaion/login/login_screen.dart';
import 'package:quizu/presentaion/quiz/question_widget.dart';
import 'package:quizu/presentaion/resources/app_string.dart';
import 'package:quizu/providers/login_provider.dart';
import 'package:quizu/providers/quiz_provider.dart';
import 'package:quizu/router.dart';

import '../resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loaded = false;
  List<Widget> pages = [HomePage(), LeaderBoardScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return !context.watch<LoginProvider>().tokenVerfied
        ? const LoginScreen()
        : Scaffold(
            body: pages[context.watch<QuizProvider>().currentPage],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: context.watch<QuizProvider>().currentPage,
                onTap: context.read<QuizProvider>().nextPage,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.leaderboard), label: 'leaderboard'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Person'),
                ]),
          );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.homeQuestion,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.s28),
          ),
          SizedBox(
            height: AppHeight.h47,
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: context.watch<QuizProvider>().isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await context.read<QuizProvider>().getQuestions();
                    },
                    child: Text(
                      AppStrings.quizMeButtonText,
                      style: TextStyle(color: Color(0xFF50524F)),
                    ),
                  ),
          ),

          // SizedBox(
          //   height: 350,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: context.read<LoginProvider>().quistions.length,
          //     itemBuilder: (context, index) {
          //       return QustionWidget(
          //           question:
          //               context.read<LoginProvider>().quistions[index]);
          //     },
          //   ),
          // ),
          SizedBox(
            height: AppHeight.h52,
          ),
          Text(
            AppStrings.instructionsText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.s24),
          ),
        ],
      ),
    );
  }
}
