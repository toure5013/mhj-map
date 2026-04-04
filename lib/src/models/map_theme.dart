import 'tile_provider.dart';

/// Pre-built map themes combining tile providers with style configurations.
///
/// Each theme provides a complete, ready-to-use map appearance.
///
/// ```dart
/// NavigatrMap(
///   center: NavigatrLatLng(lat: 48.85, lng: 2.35),
///   theme: NavigatrMapThemes.darkElegant,
/// )
/// ```
class NavigatrMapThemes {
  NavigatrMapThemes._();

  // ─── Light Themes ───────────────────────────────────────────────────

  /// Default OSM look — familiar and detailed.
  static const NavigatrMapTheme standard = NavigatrMapTheme(
    id: 'standard',
    name: 'Standard',
    description: 'Classic OpenStreetMap style with full details.',
    tileProvider: NavigatrTileProvider.openStreetMap,
    polylineColor: '#3b82f6',
    markerColor: '#3b82f6',
    isDark: false,
    category: MapThemeCategory.general,
  );

  /// Clean, light cartography — perfect for data overlays.
  static const NavigatrMapTheme cleanLight = NavigatrMapTheme(
    id: 'clean_light',
    name: 'Clean Light',
    description: 'Minimalist light basemap ideal for data visualization.',
    tileProvider: NavigatrTileProvider.cartoPositron,
    polylineColor: '#6366f1',
    markerColor: '#6366f1',
    isDark: false,
    category: MapThemeCategory.minimal,
  );

  /// Colorful and detailed — good for navigation apps.
  static const NavigatrMapTheme voyager = NavigatrMapTheme(
    id: 'voyager',
    name: 'Voyager',
    description: 'Colorful, detailed map for exploration and navigation.',
    tileProvider: NavigatrTileProvider.cartoVoyager,
    polylineColor: '#2563eb',
    markerColor: '#ef4444',
    isDark: false,
    category: MapThemeCategory.navigation,
  );

  /// Clean base without text — great for custom overlays.
  static const NavigatrMapTheme blankCanvas = NavigatrMapTheme(
    id: 'blank_canvas',
    name: 'Blank Canvas',
    description: 'No labels, clean canvas for custom overlays.',
    tileProvider: NavigatrTileProvider.cartoPositronNoLabels,
    polylineColor: '#000000',
    markerColor: '#ef4444',
    isDark: false,
    category: MapThemeCategory.minimal,
  );

  /// Esri professional street map.
  static const NavigatrMapTheme professional = NavigatrMapTheme(
    id: 'professional',
    name: 'Professional',
    description: 'Esri World Street Map — professional cartography.',
    tileProvider: NavigatrTileProvider.esriWorldStreet,
    polylineColor: '#0ea5e9',
    markerColor: '#0ea5e9',
    isDark: false,
    category: MapThemeCategory.general,
  );

  /// Esri light gray — ultra minimal.
  static const NavigatrMapTheme whisper = NavigatrMapTheme(
    id: 'whisper',
    name: 'Whisper',
    description: 'Ultra-minimal gray basemap for subtle backgrounds.',
    tileProvider: NavigatrTileProvider.esriLightGray,
    polylineColor: '#1e293b',
    markerColor: '#e11d48',
    isDark: false,
    category: MapThemeCategory.minimal,
  );

  // ─── Dark Themes ────────────────────────────────────────────────────

  /// Sleek dark map — modern and premium.
  static const NavigatrMapTheme darkElegant = NavigatrMapTheme(
    id: 'dark_elegant',
    name: 'Dark Elegant',
    description: 'Premium dark basemap for modern applications.',
    tileProvider: NavigatrTileProvider.cartoDarkMatter,
    polylineColor: '#00FF94',
    markerColor: '#00FF94',
    isDark: true,
    category: MapThemeCategory.dark,
  );

  /// Dark map without labels.
  static const NavigatrMapTheme darkSilent = NavigatrMapTheme(
    id: 'dark_silent',
    name: 'Dark Silent',
    description: 'Dark basemap without labels — sleek and minimal.',
    tileProvider: NavigatrTileProvider.cartoDarkMatterNoLabels,
    polylineColor: '#818cf8',
    markerColor: '#fbbf24',
    isDark: true,
    category: MapThemeCategory.dark,
  );

  // ─── Specialty Themes ───────────────────────────────────────────────

  /// Topographic — shows elevation and contour lines.
  static const NavigatrMapTheme topographic = NavigatrMapTheme(
    id: 'topographic',
    name: 'Topographic',
    description: 'Contour lines and elevation data for outdoor use.',
    tileProvider: NavigatrTileProvider.openTopoMap,
    polylineColor: '#dc2626',
    markerColor: '#dc2626',
    isDark: false,
    category: MapThemeCategory.outdoor,
  );

  /// Cycling optimized.
  static const NavigatrMapTheme cycling = NavigatrMapTheme(
    id: 'cycling',
    name: 'Cycling',
    description: 'Optimized for cyclists with bike lanes and routes.',
    tileProvider: NavigatrTileProvider.cyclOSM,
    polylineColor: '#16a34a',
    markerColor: '#16a34a',
    isDark: false,
    category: MapThemeCategory.outdoor,
  );

  /// Humanitarian map — emphasis on essential infrastructure.
  static const NavigatrMapTheme humanitarianMap = NavigatrMapTheme(
    id: 'humanitarian',
    name: 'Humanitarian',
    description: 'Emphasizes critical infrastructure and humanitarian data.',
    tileProvider: NavigatrTileProvider.humanitarian,
    polylineColor: '#dc2626',
    markerColor: '#dc2626',
    isDark: false,
    category: MapThemeCategory.general,
  );

  /// Satellite imagery.
  static const NavigatrMapTheme satellite = NavigatrMapTheme(
    id: 'satellite',
    name: 'Satellite',
    description: 'High-resolution satellite imagery from Esri.',
    tileProvider: NavigatrTileProvider.esriWorldImagery,
    polylineColor: '#fbbf24',
    markerColor: '#fbbf24',
    isDark: true,
    category: MapThemeCategory.satellite,
  );

  /// Esri topographic.
  static const NavigatrMapTheme terrain = NavigatrMapTheme(
    id: 'terrain',
    name: 'Terrain',
    description: 'Esri topographic map with terrain details.',
    tileProvider: NavigatrTileProvider.esriWorldTopo,
    polylineColor: '#2563eb',
    markerColor: '#ef4444',
    isDark: false,
    category: MapThemeCategory.outdoor,
  );

  /// Returns all available built-in themes.
  static List<NavigatrMapTheme> get all => [
        standard,
        cleanLight,
        voyager,
        blankCanvas,
        professional,
        whisper,
        darkElegant,
        darkSilent,
        topographic,
        cycling,
        humanitarianMap,
        satellite,
        terrain,
      ];

  /// Returns themes filtered by category.
  static List<NavigatrMapTheme> byCategory(MapThemeCategory category) =>
      all.where((t) => t.category == category).toList();

  /// Light themes only.
  static List<NavigatrMapTheme> get light =>
      all.where((t) => !t.isDark).toList();

  /// Dark themes only.
  static List<NavigatrMapTheme> get dark =>
      all.where((t) => t.isDark).toList();
}

/// A complete map theme combining tiles + styling.
class NavigatrMapTheme {
  /// Unique identifier.
  final String id;

  /// Human-readable name.
  final String name;

  /// Short description of the theme.
  final String description;

  /// The tile provider (defines the basemap look).
  final NavigatrTileProvider tileProvider;

  /// Default polyline color (hex string).
  final String polylineColor;

  /// Default marker color (hex string).
  final String markerColor;

  /// Whether the theme is dark.
  final bool isDark;

  /// Category for filtering.
  final MapThemeCategory category;

  const NavigatrMapTheme({
    required this.id,
    required this.name,
    required this.description,
    required this.tileProvider,
    this.polylineColor = '#3b82f6',
    this.markerColor = '#3b82f6',
    this.isDark = false,
    this.category = MapThemeCategory.general,
  });

  NavigatrMapTheme copyWith({
    String? id,
    String? name,
    String? description,
    NavigatrTileProvider? tileProvider,
    String? polylineColor,
    String? markerColor,
    bool? isDark,
    MapThemeCategory? category,
  }) {
    return NavigatrMapTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      tileProvider: tileProvider ?? this.tileProvider,
      polylineColor: polylineColor ?? this.polylineColor,
      markerColor: markerColor ?? this.markerColor,
      isDark: isDark ?? this.isDark,
      category: category ?? this.category,
    );
  }

  @override
  String toString() => 'NavigatrMapTheme($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatrMapTheme &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Categories for organizing map themes.
enum MapThemeCategory {
  /// General purpose maps.
  general,

  /// Dark-themed maps.
  dark,

  /// Minimal / clean maps for data overlays.
  minimal,

  /// Outdoor / topographic / cycling maps.
  outdoor,

  /// Satellite imagery.
  satellite,

  /// Navigation-oriented maps.
  navigation,
}
