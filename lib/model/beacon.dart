final String tableBeacons = 'beacons';

class BeaconFields {
  static final List<String> values = [id, name];

  static const String id = '_id';
  static const String name = 'name';
}

class Beacon {
  final int? id;
  final String name;

  const Beacon({
    this.id,
    required this.name,
  });


  Beacon copy({int? id, String? name}) =>
    Beacon(id: id ?? this.id, name: name ?? this.name);

  Map<String, Object?> toJson() => {
    BeaconFields.id: id,
    BeaconFields.name: name,
  };

  static Beacon fromJson(Map<String, Object?> json) => Beacon(
    id: json[BeaconFields.id] as int?,
    name: json[BeaconFields.name] as String,
  );

}