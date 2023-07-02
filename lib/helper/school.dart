class School {
  const School({
    required this.name,
    required this.city,
    required this.id,
  });

  final String name;
  final String city;
  final String id;

  @override
  String toString() {
    return "$name $city";
  }
}
