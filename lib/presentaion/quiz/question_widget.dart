import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/presentaion/resources/font_manager.dart';
import 'package:quizu/presentaion/resources/values_manager.dart';
import 'package:quizu/providers/quiz_provider.dart';

class QustionWidget extends StatelessWidget {
  const QustionWidget({Key? key, required this.question}) : super(key: key);
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question.question,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: FontSize.s28),
        ),

        // Wrap(
        //   runSpacing: 10.0,
        //   spacing: 10.0,
        //   alignment: WrapAlignment.spaceBetween,
        //   crossAxisAlignment: WrapCrossAlignment.center,
        //   runAlignment: WrapAlignment.spaceBetween,
        //   children: [
        //     AnswerWidget(answer: question.a),
        //     AnswerWidget(answer: question.b),
        //     AnswerWidget(answer: question.c),
        //     AnswerWidget(answer: question.d),
        //   ],
        // )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4 / 2,
            shrinkWrap: true,
            children: [
              AnswerWidget(
                answer: question.a,
                correct: question.correct,
              ),
              AnswerWidget(
                answer: question.b,
                correct: question.correct,
              ),
              AnswerWidget(
                answer: question.c,
                correct: question.correct,
              ),
              AnswerWidget(
                answer: question.d,
                correct: question.correct,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key, required this.answer, required this.correct})
      : super(key: key);
  final String answer;
  final String correct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (correct == answer) {
          context.read<QuizProvider>().nextQuestion();
        } else {
          context.read<QuizProvider>().exitForWrongAnswer();
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(border: Border.all(width: 2)),
        height: AppHeight.h44,
        width: AppWidth.w146,
        child: Center(
          child: Text(
            answer,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.s24),
          ),
        ),
      ),
    );
  }
}
