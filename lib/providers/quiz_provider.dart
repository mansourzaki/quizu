import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizu/helpers/db_helper.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/presentaion/quiz/error_screen.dart';
import 'package:quizu/presentaion/quiz/finished_quiz.dart';
import 'package:quizu/router.dart';

import '../helpers/api_helper.dart';
import '../helpers/secure_storage.dart';
import '../models/question.dart';
import '../models/score.dart';
import '../presentaion/home_pages/questions_screen.dart';

class QuizProvider with ChangeNotifier {
  int currentIndex = 0;
  List<Question> questions = [];
  List<Score> scores = [];
  List<Score> myScores = [];
  int score = 1;
  int currentPage = 0;
  bool isLoading = false;
  Timer? timer;
  Duration remainingTime = Duration();
  void nextPage(int index) async {
    if (index == 1) {
       getTopScores();
    }
    currentPage = index;

    notifyListeners();
  }

  QuizProvider() {
    getTopScores();
    getMyScores();
  }

  void nextQuestion() {
    if (questions.length - 1 == currentIndex) {
      score++;
      sendScore(score.toString());
      final newScore =
          Score(date: DateTime.now().toIso8601String(), score: score);
      addNewScore(newScore);
      // myScores.add(newScore);
      log('reached final page');
      AppRouter.navigatWithReplcamentToWidget(FinishedScreen(
        score: score,
      ));

      questions.clear();
      log('in if');

      return;
    } else {
      log(currentIndex.toString() + ' ' + questions.length.toString());

      log('ni else');
      currentIndex++;
      log(currentIndex.toString());
      score++;
    }

    notifyListeners();
  }

  void scoreUp() {
    score++;
    notifyListeners();
  }

  void skipQuestion() {
    if (questions.length - 1 == currentIndex) {
      score++;
      sendScore(score.toString());
      final newScore =
          Score(date: DateTime.now().toIso8601String(), score: score);
      addNewScore(newScore);
      // myScores.add(newScore);
      log('reached final page');
      AppRouter.navigatWithReplcamentToWidget(FinishedScreen(
        score: score,
      ));

      questions.clear();
      log('in if');

      return;
    } else {
      log(currentIndex.toString() + ' ' + questions.length.toString());

      log('ni else');
      currentIndex++;
      log(currentIndex.toString());
    }

    notifyListeners();
  }

  void exitForWrongAnswer() {
    currentIndex = 0;
    AppRouter.navigatWithReplcamentToWidget(const ErrorScreen());
    notifyListeners();
  }

  countDownFun() {
    log('in count down');
    final seconds = remainingTime.inSeconds;
    remainingTime = Duration(seconds: seconds - 1);
    notifyListeners();
  }

  Future<void> getQuestions() async {
    changeLoadingStatus(true);
    score = 0;
    currentIndex = 0;
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token') ?? '';
    final response = await ApiHelper.apiHelper.getQuestions(token);
    questions = response;
    startTimer();

    AppRouter.navigateToWidget(QuestionScreen(questions: questions));
    changeLoadingStatus(false);
    notifyListeners();
    //return response;
  }

  Future<void> restartQuiz() async {
    score = 0;
    currentIndex = 0;
    startTimer();
    AppRouter.navigatWithReplcamentToWidget(
        QuestionScreen(questions: questions));
    //return response;
  }

  startTimer() async {
    remainingTime = const Duration(seconds: 120);
    if (timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (remainingTime.inSeconds == 110) {
          final newScore =
              Score(date: DateTime.now().toIso8601String(), score: score);
          await sendScore(newScore.score.toString());
          addNewScore(newScore);

          stopTimer();
          AppRouter.navigatWithReplcamentToWidget(FinishedScreen(score: score));
        } else {
          countDownFun();
        }
      });
    } else {
      timer!.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (remainingTime.inSeconds == 0) {
          final newScore =
              Score(date: DateTime.now().toIso8601String(), score: score);
          await sendScore(newScore.score.toString());
          addNewScore(newScore);
          stopTimer();
        } else {
          countDownFun();
        }
      });
    }
  }

  stopTimer() {
    timer!.cancel();
    score = 0;
    notifyListeners();
  }

  Future<void> getTopScores() async {
    changeLoadingStatus(true);
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token') ?? '';
    log(token.toString());
    final response = await ApiHelper.apiHelper.getTopScores(token);
    scores = response;
    log(response[0].name.toString());
    changeLoadingStatus(false);
    notifyListeners();
    //return response;
  }

  void changeLoadingStatus(bool v) {
    isLoading = v;
    notifyListeners();
  }

  Future<void> getMyScores() async {
    myScores.clear();
    myScores = await DbHelper.dbHelper.selectAllScores();
    myScores.sort(
      (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)),
    );
    notifyListeners();
  }

  Future<void> addNewScore(Score score) async {
    DbHelper.dbHelper.insertNewScroe(score);
    myScores.add(score);
    notifyListeners();
  }

  void deleteAllMyScore() async {
    await DbHelper.dbHelper.deleteAll();
    myScores.clear();
    notifyListeners();
  }

  Future<void> sendScore(String score) async {
    final token =
        await SecureStorageHelper.secureStoreageHelper.readToken('token') ?? '';
    await ApiHelper.apiHelper.sendScore(score, token);
  }
}
