// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  String question;
  String a;
  String b;
  String c;
  String d;
  String correct;
  Question({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correct,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Question': question,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'correct': correct,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['Question'] as String,
      a: map['a'] as String,
      b: map['b'] as String,
      c: map['c'] as String,
      d: map['d'] as String,
      correct: map[map['correct']] as String,
    );
  }
}
