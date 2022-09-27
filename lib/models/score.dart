import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Score {
  String? name;
  int? score;
  String? date;
  Score({
    this.name,
    this.score,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'score': score,
      'date': date,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      name: map['name'] != null ? map['name'] as String : null,
      score: map['score'] != null ? map['score'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }



  
}
