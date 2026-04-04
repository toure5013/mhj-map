class GeocodeResult {
  final double lat;
  final double lng;
  final String displayName;

  const GeocodeResult({
    required this.lat,
    required this.lng,
    required this.displayName,
  });

  factory GeocodeResult.fromJson(Map<String, dynamic> json) {
    return GeocodeResult(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      displayName: json['displayName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
    'displayName': displayName,
  };
}
