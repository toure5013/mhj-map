import 'lat_lng.dart';
import 'maneuver.dart';

class RouteResult {
  final int durationSeconds;
  final String durationText;
  final int distanceMeters;
  final String distanceText;
  final List<MhjMapsLatLng> polyline;
  final List<Maneuver>? maneuvers;
  final List<AlternateRoute>? alternates;

  const RouteResult({
    required this.durationSeconds,
    required this.durationText,
    required this.distanceMeters,
    required this.distanceText,
    required this.polyline,
    this.maneuvers,
    this.alternates,
  });
}

class AlternateRoute {
  final int durationSeconds;
  final String durationText;
  final int distanceMeters;
  final String distanceText;
  final List<MhjMapsLatLng> polyline;

  const AlternateRoute({
    required this.durationSeconds,
    required this.durationText,
    required this.distanceMeters,
    required this.distanceText,
    required this.polyline,
  });
}
