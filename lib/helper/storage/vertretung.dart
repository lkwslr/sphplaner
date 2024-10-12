import 'package:isar/isar.dart';

import 'lerngruppe.dart';

part 'vertretung.g.dart';

@collection
class Vertretung {
  Id id = Isar.autoIncrement;

  String? datum;
  int? wochentag;
  List<int> stunden = [];

  String? raum;
  String? vertretungsRaum;
  String? lehrkraft;
  String? vertretungsLehrkraft;
  String? kurs;
  String? vertretungsFach;
  String? fach;

  String? art;
  String? hinweis;

  final lerngruppe = IsarLink<Lerngruppe>();

  bool placeholder = false;
}
