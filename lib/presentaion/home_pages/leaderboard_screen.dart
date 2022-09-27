import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizu/presentaion/resources/resources.dart';
import 'package:quizu/providers/quiz_provider.dart';

import '../../models/score.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<QuizProvider>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text(AppStrings.appName),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            'Leaderboard',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.s48),
          ),
          SizedBox(
            height: 74,
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: context.watch<QuizProvider>().isLoading
                ? CircularProgressIndicator()
                : Table(
                    children: List.generate(
                        provider.scores.length,
                        (index) => TableRow(children: [
                              Center(
                                  child: Text(
                                provider.scores[index].name.toString(),
                                style: TextStyle(fontSize: FontSize.s24),
                              )),
                              Center(
                                  child: Text(
                                provider.scores[index].score.toString(),
                                style: TextStyle(fontSize: FontSize.s24),
                              ))
                            ])),
                  ),
          ),
          // ListView(
          //   shrinkWrap: true,
          //   physics: ClampingScrollPhysics(),
          //   children: List.generate(provider.scores.length,
          //       (index) => ScoreWidget(score: provider.scores[index])),
          // )
        ],
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key, required this.score}) : super(key: key);
  final Score score;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            score.name.toString(),
            style: TextStyle(fontSize: FontSize.s24),
          ),
          Text(
            score.score.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.s24),
          )
        ],
      ),
    );
  }
}
