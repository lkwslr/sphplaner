import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/subject.dart';

part 'lesson.g.dart';

@Collection()
class Lesson {
  Id id = Isar.autoIncrement;

  final subject = IsarLink<Subject>();

  String? room;

  @Index(unique: true, replace: true, composite: [CompositeIndex('hour')])
  int? dayOfWeek;

  int? hour;
}