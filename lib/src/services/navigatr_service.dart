import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lat_lng.dart';
import '../models/route_result.dart';
import '../models/geocode_result.dart';
import '../models/autocomplete_result.dart';
import '../models/maneuver.dart';
import '../models/navigatr_config.dart';
import '../utils/polyline_decoder.dart';
import '../utils/format_utils.dart';

class NavigatrService {
  final NavigatrConfig config;

  NavigatrService({this.config = const NavigatrConfig()});

  Future<RouteResult> route({
    required NavigatrLatLng origin,
    required NavigatrLatLng destination,
    String costing = 'auto',
  }) async {
    final response = await http.post(
      Uri.parse('${config.valhallaUrl}/route'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'locations': [
          {'lat': origin.lat, 'lon': origin.lng, 'type': 'break'},
          {'lat': destination.lat, 'lon': destination.lng, 'type': 'break'}
        ],
        'costing': costing,
        'directions_options': {'units': 'km'},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Route request failed: ${response.statusCode} ${response.body}');
    }

    final data = jsonDecode(response.body);
    final trip = data['trip'];
    final summary = trip['summary'];
    final shape = trip['legs'][0]['shape'];

    final polyline = NavigatrPolyline.decode(shape);
    final int durationSeconds = (summary['time'] as num).toInt();
    final double distanceKm = (summary['length'] as num).toDouble();
    final int distanceMeters = (distanceKm * 1000).round();

    // Parse maneuvers if they exist
    List<Maneuver>? maneuvers;
    if (trip['legs'][0]['maneuvers'] != null) {
      maneuvers = (trip['legs'][0]['maneuvers'] as List).map((m) {
        final double mLon = (m['lon'] as num).toDouble();
        final double mLat = (m['lat'] as num).toDouble();
        
        return Maneuver(
          instruction: m['instruction'] ?? '',
          type: (m['type'] as int).toString(),
          distanceMeters: ((m['length'] as num).toDouble() * 1000).round(),
          distanceText: NavigatrFormat.distance(((m['length'] as num).toDouble() * 1000).round()),
          durationSeconds: (m['time'] as num).toInt(),
          durationText: NavigatrFormat.duration((m['time'] as num).toInt()),
          startPoint: NavigatrLatLng(lat: mLat, lng: mLon),
        );
      }).toList();
    }

    return RouteResult(
      durationSeconds: durationSeconds,
      durationText: NavigatrFormat.duration(durationSeconds),
      distanceMeters: distanceMeters,
      distanceText: NavigatrFormat.distance(distanceMeters),
      polyline: polyline,
      maneuvers: maneuvers,
    );
  }

  Future<GeocodeResult> geocode(String address) async {
    final response = await http.get(
      Uri.parse('${config.nominatimUrl}/search?q=${Uri.encodeComponent(address)}&format=json&limit=1'),
      headers: {'User-Agent': 'navigatr-flutter/1.0'},
    );

    if (response.statusCode != 200) {
      throw Exception('Geocoding request failed: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    if (data is! List || data.isEmpty) {
      throw Exception('No geocoding results found for address: $address');
    }

    final result = data[0];
    return GeocodeResult(
      lat: double.parse(result['lat']),
      lng: double.parse(result['lon']),
      displayName: result['display_name'] ?? '',
    );
  }

  Future<GeocodeResult> reverseGeocode(double lat, double lng) async {
    final response = await http.get(
      Uri.parse('${config.nominatimUrl}/reverse?lat=$lat&lon=$lng&format=json'),
      headers: {'User-Agent': 'navigatr-flutter/1.0'},
    );

    if (response.statusCode != 200) {
      throw Exception('Reverse geocoding request failed: ${response.statusCode}');
    }

    final result = jsonDecode(response.body);
    return GeocodeResult(
      lat: lat,
      lng: lng,
      displayName: result['display_name'] ?? '',
    );
  }

  Future<List<AutocompleteResult>> autocomplete(String query, {int limit = 5}) async {
    final response = await http.get(
      Uri.parse('${config.photonUrl}/api?q=${Uri.encodeComponent(query)}&limit=$limit'),
    );

    if (response.statusCode != 200) {
      throw Exception('Autocomplete request failed: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final List<dynamic> features = data['features'] ?? [];

    return features.map((f) {
      final props = f['properties'];
      final coords = f['geometry']['coordinates'];
      
      return AutocompleteResult(
        lat: (coords[1] as num).toDouble(),
        lng: (coords[0] as num).toDouble(),
        name: props['name'] ?? '',
        displayName: [
          props['name'],
          props['street'],
          props['city'] ?? props['town'] ?? props['village'],
          props['state'],
          props['country']
        ].where((e) => e != null).join(', '),
        city: props['city'] ?? props['town'] ?? props['village'],
        state: props['state'],
        country: props['country'],
        street: props['street'],
        postcode: props['postcode'],
      );
    }).toList();
  }
}
