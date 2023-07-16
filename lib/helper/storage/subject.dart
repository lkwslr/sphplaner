import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/lesson.dart';

part 'subject.g.dart';

@collection
class Subject {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? subject;

  String? subjectName;

  int color = 4292600319;

  String? teacher;

  //final teacher = IsarLink<Teacher>();

  @Backlink(to: 'subject')
  final lessons = IsarLinks<Lesson>();
}