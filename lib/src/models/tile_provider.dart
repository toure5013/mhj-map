/// A tile provider configuration for the map widget.
///
/// Pre-built providers are available via [NavigatrTileProvider] static methods
/// for OpenStreetMap, CartoDB, Stadia Maps, and more.
class NavigatrTileProvider {
  /// Display name for this tile provider.
  final String name;

  /// URL template for the tile server (must contain `{z}`, `{x}`, `{y}`).
  final String urlTemplate;

  /// Attribution text to display on the map.
  final String attribution;

  /// Optional subdomains for load balancing (e.g. `['a','b','c']`).
  final List<String> subdomains;

  /// Maximum zoom level supported by this tile provider.
  final int maxZoom;

  /// Whether the tiles have a dark background.
  final bool isDark;

  /// A unique identifier for this tile provider.
  final String id;

  const NavigatrTileProvider({
    required this.id,
    required this.name,
    required this.urlTemplate,
    this.attribution = '© OpenStreetMap contributors',
    this.subdomains = const [],
    this.maxZoom = 19,
    this.isDark = false,
  });

  NavigatrTileProvider copyWith({
    String? id,
    String? name,
    String? urlTemplate,
    String? attribution,
    List<String>? subdomains,
    int? maxZoom,
    bool? isDark,
  }) {
    return NavigatrTileProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      urlTemplate: urlTemplate ?? this.urlTemplate,
      attribution: attribution ?? this.attribution,
      subdomains: subdomains ?? this.subdomains,
      maxZoom: maxZoom ?? this.maxZoom,
      isDark: isDark ?? this.isDark,
    );
  }

  // ─── Built-in Tile Providers ────────────────────────────────────────

  /// Standard OpenStreetMap tiles.
  static const NavigatrTileProvider openStreetMap = NavigatrTileProvider(
    id: 'osm_standard',
    name: 'OpenStreetMap',
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '© OpenStreetMap contributors',
  );

  /// CartoDB Positron — light, minimalist basemap.
  static const NavigatrTileProvider cartoPositron = NavigatrTileProvider(
    id: 'carto_positron',
    name: 'CartoDB Positron',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Dark Matter — sleek dark basemap.
  static const NavigatrTileProvider cartoDarkMatter = NavigatrTileProvider(
    id: 'carto_dark',
    name: 'CartoDB Dark Matter',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
    isDark: true,
  );

  /// CartoDB Voyager — colorful, detailed basemap.
  static const NavigatrTileProvider cartoVoyager = NavigatrTileProvider(
    id: 'carto_voyager',
    name: 'CartoDB Voyager',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Positron (no labels) — clean, minimal, no text.
  static const NavigatrTileProvider cartoPositronNoLabels = NavigatrTileProvider(
    id: 'carto_positron_nolabels',
    name: 'CartoDB Positron (No Labels)',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Dark Matter (no labels).
  static const NavigatrTileProvider cartoDarkMatterNoLabels =
      NavigatrTileProvider(
    id: 'carto_dark_nolabels',
    name: 'CartoDB Dark (No Labels)',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
    isDark: true,
  );

  /// OpenTopoMap — topographic map with contour lines.
  static const NavigatrTileProvider openTopoMap = NavigatrTileProvider(
    id: 'opentopomap',
    name: 'OpenTopoMap',
    urlTemplate: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, © OpenTopoMap (CC-BY-SA)',
    subdomains: ['a', 'b', 'c'],
    maxZoom: 17,
  );

  /// CyclOSM — bicycle-oriented map.
  static const NavigatrTileProvider cyclOSM = NavigatrTileProvider(
    id: 'cyclosm',
    name: 'CyclOSM',
    urlTemplate:
        'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, © CyclOSM',
    subdomains: ['a', 'b', 'c'],
  );

  /// OSM Humanitarian — emphasizes humanitarian features.
  static const NavigatrTileProvider humanitarian = NavigatrTileProvider(
    id: 'humanitarian',
    name: 'Humanitarian (HOT)',
    urlTemplate: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, Humanitarian OpenStreetMap Team',
    subdomains: ['a', 'b', 'c'],
  );

  /// Esri World Street Map.
  static const NavigatrTileProvider esriWorldStreet = NavigatrTileProvider(
    id: 'esri_street',
    name: 'Esri World Street',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Esri World Imagery — satellite imagery.
  static const NavigatrTileProvider esriWorldImagery = NavigatrTileProvider(
    id: 'esri_imagery',
    name: 'Esri Satellite',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, Maxar, Earthstar Geographics',
  );

  /// Esri World Topo Map.
  static const NavigatrTileProvider esriWorldTopo = NavigatrTileProvider(
    id: 'esri_topo',
    name: 'Esri Topo',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Esri Light Gray Canvas — minimal basemap for overlays.
  static const NavigatrTileProvider esriLightGray = NavigatrTileProvider(
    id: 'esri_light_gray',
    name: 'Esri Light Gray',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Create a custom tile provider from any URL template.
  factory NavigatrTileProvider.custom({
    required String urlTemplate,
    String name = 'Custom',
    String attribution = '',
    List<String> subdomains = const [],
    int maxZoom = 19,
    bool isDark = false,
  }) {
    return NavigatrTileProvider(
      id: 'custom_${urlTemplate.hashCode}',
      name: name,
      urlTemplate: urlTemplate,
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
      isDark: isDark,
    );
  }

  /// Returns all built-in tile providers.
  static List<NavigatrTileProvider> get allProviders => [
        openStreetMap,
        cartoPositron,
        cartoDarkMatter,
        cartoVoyager,
        cartoPositronNoLabels,
        cartoDarkMatterNoLabels,
        openTopoMap,
        cyclOSM,
        humanitarian,
        esriWorldStreet,
        esriWorldImagery,
        esriWorldTopo,
        esriLightGray,
      ];

  /// Returns all light-themed tile providers.
  static List<NavigatrTileProvider> get lightProviders =>
      allProviders.where((p) => !p.isDark).toList();

  /// Returns all dark-themed tile providers.
  static List<NavigatrTileProvider> get darkProviders =>
      allProviders.where((p) => p.isDark).toList();

  @override
  String toString() => 'NavigatrTileProvider($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatrTileProvider &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
