class Mood {
  int id;
  String name;
  DateTime date;

  Mood({required this.id, required this.name, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
    };
  }

  static Mood fromMap(Map<String, dynamic> map) {
    return Mood(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
    );
  }
}
