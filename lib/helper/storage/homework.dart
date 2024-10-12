import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';

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

  final lerngruppe = IsarLink<Lerngruppe>();
}
