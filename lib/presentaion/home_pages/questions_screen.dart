import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/presentaion/resources/font_manager.dart';
import 'package:quizu/providers/quiz_provider.dart';
import 'package:quizu/router.dart';

import '../quiz/question_widget.dart';

String twoDigits(int n) => n.toString().padLeft(2, '0');

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key, required this.questions}) : super(key: key);
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    //log(context.watch<QuizProvider>().currentIndex.toString() + 'g');
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        AppRouter.pop();
        context.read<QuizProvider>().stopTimer();
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${twoDigits(context.watch<QuizProvider>().remainingTime.inMinutes.remainder(60))}:${twoDigits(context.watch<QuizProvider>().remainingTime.inSeconds.remainder(60))} ⏳',
            style: TextStyle(fontSize: FontSize.s64),
          ),
          SizedBox(
            height: 51,
          ),
          context.watch<QuizProvider>().questions.isEmpty
              ? Text('No Questions Yet...')
              : QustionWidget(
                  question:
                      questions[context.watch<QuizProvider>().currentIndex]),
          SizedBox(
            height: 51,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<QuizProvider>().skipQuestion();
              },
              child: Text('Skip 🔥')),
        ],
      ),
    ));
  }
}
