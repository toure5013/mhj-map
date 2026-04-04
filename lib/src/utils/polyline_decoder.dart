import 'dart:math';
import '../models/lat_lng.dart';

class MhjMapsPolyline {
  /// Decodes an encoded polyline string into an array of coordinates.
  /// Uses the Google polyline encoding algorithm with precision 6 (for Valhalla).
  static List<MhjMapsLatLng> decode(String encoded, {int precision = 6}) {
    final factor = pow(10, precision);
    final List<MhjMapsLatLng> coordinates = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < encoded.length) {
      int shift = 0;
      int result = 0;
      int byte;

      // Decode latitude
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);

      final int deltaLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += deltaLat;

      // Decode longitude
      shift = 0;
      result = 0;

      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);

      final int deltaLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += deltaLng;

      coordinates.add(MhjMapsLatLng(
        lat: lat / factor,
        lng: lng / factor,
      ));
    }

    return coordinates;
  }
}
