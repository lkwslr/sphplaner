import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/lehrkraft.dart';
import 'package:sphplaner/helper/storage/leistungskontrolle.dart';

part 'lerngruppe.g.dart';

@collection
class Lerngruppe {
  Id id = Isar.autoIncrement;

  String? name;

  String? halbjahr;

  @Index(unique: true)
  String? gruppenId;

  String? generatedName;

  String? fullName;

  String? zweig;

  int farbe = 4292600319;

  bool synced = true;

  bool edited = false;

  final lehrkraft = IsarLink<Lehrkraft>();

  final leistungskontrollen = IsarLinks<Leistungskontrolle>();
}
