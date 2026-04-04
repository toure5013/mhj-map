import 'lat_lng.dart';

class Maneuver {
  final String instruction;
  final String type;
  final int distanceMeters;
  final String distanceText;
  final int durationSeconds;
  final String durationText;
  final NavigatrLatLng startPoint;

  const Maneuver({
    required this.instruction,
    required this.type,
    required this.distanceMeters,
    required this.distanceText,
    required this.durationSeconds,
    required this.durationText,
    required this.startPoint,
  });

  factory Maneuver.fromJson(Map<String, dynamic> json) {
    return Maneuver(
      instruction: json['instruction'] ?? '',
      type: json['type'] ?? '',
      distanceMeters: (json['distanceMeters'] as num).toInt(),
      distanceText: json['distanceText'] ?? '',
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      durationText: json['durationText'] ?? '',
      startPoint: NavigatrLatLng.fromJson(json['startPoint']),
    );
  }
}
