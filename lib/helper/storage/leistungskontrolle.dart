import 'package:isar/isar.dart';

import 'lerngruppe.dart';

part 'leistungskontrolle.g.dart';

@collection
class Leistungskontrolle {
  Id id = Isar.autoIncrement;

  DateTime? datum;

  String? art;

  List<int>? stunden;

  bool synced = true;

  final lerngruppe = IsarLink<Lerngruppe>();
}
