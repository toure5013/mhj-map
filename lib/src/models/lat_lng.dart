class NavigatrLatLng {
  final double lat;
  final double lng;

  const NavigatrLatLng({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };

  factory NavigatrLatLng.fromJson(Map<String, dynamic> json) {
    return NavigatrLatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'NavigatrLatLng(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatrLatLng &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
