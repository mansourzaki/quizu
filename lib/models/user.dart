

import 'package:quizu/models/score.dart';

class User {
  String? name;
  String mobile;
  List<Score>? scores;
  User({
     this.name,
    required this.mobile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mobile': mobile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      mobile: map['mobile'] as String,
    );
  }

}
