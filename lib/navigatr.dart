library navigatr;

// Models
export 'src/models/lat_lng.dart';
export 'src/models/route_result.dart';
export 'src/models/geocode_result.dart';
export 'src/models/autocomplete_result.dart';
export 'src/models/maneuver.dart';
export 'src/models/navigatr_config.dart';
export 'src/models/map_style.dart';
export 'src/models/map_style_presets.dart';
export 'src/models/tile_provider.dart';
export 'src/models/map_theme.dart';
export 'src/models/map_options.dart';

// Services
export 'src/services/navigatr_service.dart';

// Widgets
export 'src/widgets/navigatr_map.dart';

// Utilities
export 'src/utils/format_utils.dart';
export 'src/utils/polyline_decoder.dart';

import 'src/services/navigatr_service.dart';
import 'src/models/navigatr_config.dart';

/// The main entry point for the Navigatr SDK.
///
/// Provides geocoding, routing, and autocomplete services using free
/// OpenStreetMap infrastructure — zero API keys, zero cost.
///
/// ```dart
/// final nav = Navigatr();
///
/// // Geocode
/// final result = await nav.geocode('Paris, France');
///
/// // Route
/// final route = await nav.route(
///   origin: NavigatrLatLng(lat: 48.85, lng: 2.35),
///   destination: NavigatrLatLng(lat: 45.76, lng: 4.83),
/// );
///
/// // Autocomplete
/// final suggestions = await nav.autocomplete('Par');
/// ```
class Navigatr extends NavigatrService {
  Navigatr({super.config = const NavigatrConfig()});
}
