import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';

part 'schulstunde.g.dart';

@Collection()
class Schulstunde {
  Id id = Isar.autoIncrement;

  final fach = IsarLink<Lerngruppe>();

  String? raum;

  @Index(unique: true, replace: true, composite: [CompositeIndex('stunde')])
  int? wochentag;

  int? stunde;

  bool synced = true;
}