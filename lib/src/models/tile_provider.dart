/// A tile provider configuration for the map widget.
///
/// Pre-built providers are available via [MhjMapsTileProvider] static methods
/// for OpenStreetMap, CartoDB, Stadia Maps, and more.
class MhjMapsTileProvider {
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

  const MhjMapsTileProvider({
    required this.id,
    required this.name,
    required this.urlTemplate,
    this.attribution = '© OpenStreetMap contributors',
    this.subdomains = const [],
    this.maxZoom = 19,
    this.isDark = false,
  });

  MhjMapsTileProvider copyWith({
    String? id,
    String? name,
    String? urlTemplate,
    String? attribution,
    List<String>? subdomains,
    int? maxZoom,
    bool? isDark,
  }) {
    return MhjMapsTileProvider(
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
  static const MhjMapsTileProvider openStreetMap = MhjMapsTileProvider(
    id: 'osm_standard',
    name: 'OpenStreetMap',
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '© OpenStreetMap contributors',
  );

  /// CartoDB Positron — light, minimalist basemap.
  static const MhjMapsTileProvider cartoPositron = MhjMapsTileProvider(
    id: 'carto_positron',
    name: 'CartoDB Positron',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Dark Matter — sleek dark basemap.
  static const MhjMapsTileProvider cartoDarkMatter = MhjMapsTileProvider(
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
  static const MhjMapsTileProvider cartoVoyager = MhjMapsTileProvider(
    id: 'carto_voyager',
    name: 'CartoDB Voyager',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Positron (no labels) — clean, minimal, no text.
  static const MhjMapsTileProvider cartoPositronNoLabels = MhjMapsTileProvider(
    id: 'carto_positron_nolabels',
    name: 'CartoDB Positron (No Labels)',
    urlTemplate:
        'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png',
    attribution:
        '© OpenStreetMap contributors, © CARTO',
    subdomains: ['a', 'b', 'c', 'd'],
  );

  /// CartoDB Dark Matter (no labels).
  static const MhjMapsTileProvider cartoDarkMatterNoLabels =
      MhjMapsTileProvider(
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
  static const MhjMapsTileProvider openTopoMap = MhjMapsTileProvider(
    id: 'opentopomap',
    name: 'OpenTopoMap',
    urlTemplate: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, © OpenTopoMap (CC-BY-SA)',
    subdomains: ['a', 'b', 'c'],
    maxZoom: 17,
  );

  /// CyclOSM — bicycle-oriented map.
  static const MhjMapsTileProvider cyclOSM = MhjMapsTileProvider(
    id: 'cyclosm',
    name: 'CyclOSM',
    urlTemplate:
        'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, © CyclOSM',
    subdomains: ['a', 'b', 'c'],
  );

  /// OSM Humanitarian — emphasizes humanitarian features.
  static const MhjMapsTileProvider humanitarian = MhjMapsTileProvider(
    id: 'humanitarian',
    name: 'Humanitarian (HOT)',
    urlTemplate: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
    attribution:
        '© OpenStreetMap contributors, Humanitarian OpenStreetMap Team',
    subdomains: ['a', 'b', 'c'],
  );

  /// Esri World Street Map.
  static const MhjMapsTileProvider esriWorldStreet = MhjMapsTileProvider(
    id: 'esri_street',
    name: 'Esri World Street',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Esri World Imagery — satellite imagery.
  static const MhjMapsTileProvider esriWorldImagery = MhjMapsTileProvider(
    id: 'esri_imagery',
    name: 'Esri Satellite',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, Maxar, Earthstar Geographics',
  );

  /// Esri World Topo Map.
  static const MhjMapsTileProvider esriWorldTopo = MhjMapsTileProvider(
    id: 'esri_topo',
    name: 'Esri Topo',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Wikimedia Maps.
  static const MhjMapsTileProvider wikimedia = MhjMapsTileProvider(
    id: 'wikimedia',
    name: 'Wikimedia',
    urlTemplate: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
    attribution: '© OpenStreetMap contributors, Wikimedia maps',
  );

  /// Stamen Toner — high-contrast black and white.
  static const MhjMapsTileProvider stamenToner = MhjMapsTileProvider(
    id: 'stamen_toner',
    name: 'Stamen Toner',
    urlTemplate: 'https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png',
    attribution:
        'Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under ODbL.',
  );

  /// Stamen Terrain.
  static const MhjMapsTileProvider stamenTerrain = MhjMapsTileProvider(
    id: 'stamen_terrain',
    name: 'Stamen Terrain',
    urlTemplate: 'https://stamen-tiles.a.ssl.fastly.net/terrain/{z}/{x}/{y}.jpg',
    attribution:
        'Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under ODbL.',
  );

  /// OpenCycleMap — cycling-oriented topographic map.
  static const MhjMapsTileProvider openCycleMap = MhjMapsTileProvider(
    id: 'opencyclemap',
    name: 'OpenCycleMap',
    urlTemplate: 'https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png',
    attribution: '© OpenStreetMap contributors, © Thunderforest',
    subdomains: ['a', 'b', 'c'],
  );

  /// Esri Light Gray Canvas — minimal basemap for overlays.
  static const MhjMapsTileProvider esriLightGray = MhjMapsTileProvider(
    id: 'esri_light_gray',
    name: 'Esri Light Gray',
    urlTemplate:
        'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
    attribution: '© Esri, © OpenStreetMap contributors',
  );

  /// Create a custom tile provider from any URL template.
  factory MhjMapsTileProvider.custom({
    required String urlTemplate,
    String name = 'Custom',
    String attribution = '',
    List<String> subdomains = const [],
    int maxZoom = 19,
    bool isDark = false,
  }) {
    return MhjMapsTileProvider(
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
  static List<MhjMapsTileProvider> get allProviders => [
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
        wikimedia,
        stamenToner,
        stamenTerrain,
        openCycleMap,
      ];

  /// Returns all light-themed tile providers.
  static List<MhjMapsTileProvider> get lightProviders =>
      allProviders.where((p) => !p.isDark).toList();

  /// Returns all dark-themed tile providers.
  static List<MhjMapsTileProvider> get darkProviders =>
      allProviders.where((p) => p.isDark).toList();

  @override
  String toString() => 'MhjMapsTileProvider($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MhjMapsTileProvider &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
