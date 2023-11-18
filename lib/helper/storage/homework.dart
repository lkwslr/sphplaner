import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/subject.dart';
import 'package:sphplaner/helper/storage/user.dart';

part 'homework.g.dart';

@collection
class Homework {
  Id id = Isar.autoIncrement;

  String? title;

  String? description;

  int? due;

  bool finished = false;

  bool online = false;

  @Index(unique: true, replace: true)
  String? onlineIdentifier;

  @Backlink(to: 'homeworks')
  final user = IsarLink<User>();

  final subject = IsarLink<Subject>();

  @override
  String toString() {
    Map homework = {
      "title": title,
      "description": description,
      "due": due,
      "finished": finished,
      "online": online,
      "onlineIdentifier": onlineIdentifier,
      "user": user.value?.username,
      "subject": subject.value?.subjectName
    };
    return jsonEncode(homework);
  }
}
