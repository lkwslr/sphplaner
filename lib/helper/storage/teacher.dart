import 'package:isar/isar.dart';

part 'teacher.g.dart';

@collection
class Teacher {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? nameShort;

  String? name;

  //@Backlink(to: 'teacher')
  //final subject = IsarLinks<Subject>();
}