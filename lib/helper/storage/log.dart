import 'package:isar/isar.dart';

part 'log.g.dart';

@Collection()
class Log {
  Id id = Isar.autoIncrement;

  String? name;

  String? level;

  int? time;

  String? message;
}