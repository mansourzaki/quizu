import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quizu/models/question.dart';
import 'package:quizu/models/user.dart';

import '../models/score.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Future<Map<String, dynamic>> login(String otp, String phone) async {
    String url = 'https://quizu.okoul.com/Login';
    Dio dio = Dio();

    Response response =
        await dio.post(url, data: {'OTP': otp, "mobile": phone});

    log(response.toString());

    return response.data;
  }

  Future<Map<String, dynamic>> saveName(String name, String token) async {
    String url = 'https://quizu.okoul.com/Name';

    Dio dio = Dio();
    Response response = await dio.post(url,
        data: {'name': name},
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());
    //log(response.data['haha'].toString());

    return response.data;
  }

  Future<List<Question>> getQuestions(String token) async {
    String url = 'https://quizu.okoul.com/Questions';
    log('get questions');
    Dio dio = Dio();
    Response<List<dynamic>> response = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());
    //log(response.data['haha'].toString());
    List<Question> list = [];
    if (response.data != null) {
      list = response.data!.map((e) => Question.fromMap(e)).toList();
    }

    return list;
  }

  Future<List<Score>> getTopScores(String token) async {
    String url = 'https://quizu.okoul.com/TopScores';
    log('get questions');
    Dio dio = Dio();
    Response<List<dynamic>> response = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());
    //log(response.data['haha'].toString());
    List<Score> list = [];
    if (response.data != null) {
      list = response.data!.map((e) => Score.fromMap(e)).toList();
    }

    return list;
  }

  Future<Map<String, dynamic>> sendScore(String score, String token) async {
    String url = 'https://quizu.okoul.com/Score';

    Dio dio = Dio();
    Response response = await dio.post(url,
        data: {'score': score},
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());

    return response.data;
  }

  Future<Map<String, dynamic>> verifyToken(String token) async {
    String url = 'https://quizu.okoul.com/Token';

    Dio dio = Dio();
    Response response = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());

    return response.data;
  }

  Future<User> getUserInfo(String token) async {
    String url = 'https://quizu.okoul.com/UserInfo';

    Dio dio = Dio();
    Response response = await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));

    log(response.toString());

    return User(mobile: response.data['mobile'], name: response.data['name']);
  }
}
