import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/homework.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? username;

  int? school;

  String? schoolName;

  String? firstName;

  String? lastName;

  String? displayName;

  String? email;

  String? birthDate;

  String? profileImage;

  String? grade;

  String? course;

  bool? autoUpdate;

  String? theme;

  bool? login;

  final homeworks = IsarLinks<Homework>();
}