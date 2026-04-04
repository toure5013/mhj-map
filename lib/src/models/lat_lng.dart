class MhjMapsLatLng {
  final double lat;
  final double lng;

  const MhjMapsLatLng({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };

  factory MhjMapsLatLng.fromJson(Map<String, dynamic> json) {
    return MhjMapsLatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'MhjMapsLatLng(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MhjMapsLatLng &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
