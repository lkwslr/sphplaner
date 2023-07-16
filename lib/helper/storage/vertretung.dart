import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/subject.dart';
import 'package:sphplaner/helper/storage/user.dart';

part 'vertretung.g.dart';

@collection
class Vertretung {
  Id id = Isar.autoIncrement;

  @Index(
      unique: true,
      replace: true,
      composite: [CompositeIndex('dayOfWeek'), CompositeIndex('hour')])
  String? date;
  int? dayOfWeek;
  int? hour;
  String? room;
  String? teacher;
  final subject = IsarLink<Subject>();

  String? type;
  String? note;

  final user = IsarLink<User>();
}
