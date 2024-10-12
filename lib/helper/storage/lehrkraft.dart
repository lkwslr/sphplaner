import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';

part 'lehrkraft.g.dart';

@collection
class Lehrkraft {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? kuerzel;

  String? name;
  String? fullLehrkraft;

  bool synced = true;

  final lerngruppen = IsarLinks<Lerngruppe>();
}
