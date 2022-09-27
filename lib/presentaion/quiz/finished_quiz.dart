import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizu/router.dart';
import 'package:share_plus/share_plus.dart';

class FinishedScreen extends StatelessWidget {
  const FinishedScreen({Key? key, required this.score}) : super(key: key);
  final int score;
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
          const Text(
            '🏁',
            style: TextStyle(fontSize: 128),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'You have completed',
            style: TextStyle(fontSize: 32),
          ),
          Text(
            score.toString(),
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Correct answers!',
            style: TextStyle(fontSize: 32),
          ),
          IconButton(
              onPressed: () async {
                Share.share('I answered $score correct answers in QuizU!');
              },
              icon: const Icon(Icons.share))
        ],
      ),
    );
  }
}
