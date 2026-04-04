import 'map_style.dart';

class MapStylePresets {
  static const MapColors DEFAULT_COLORS = MapColors(
    primary: '#3b82f6',
    secondary: '#6366f1',
    background: '#f8fafc',
    roads: '#94a3b8',
    water: '#0ea5e9',
    parks: '#22c55e',
    buildings: '#cbd5e1',
    labels: '#1e293b',
  );

  static const LayerVisibility DEFAULT_LAYERS = LayerVisibility();
  static const MarkerStyle DEFAULT_MARKER = MarkerStyle();
  static const PolylineStyle DEFAULT_POLYLINE = PolylineStyle();

  static final List<MapStylePreset> presets = [
    MapStylePreset(
      id: 'default',
      name: 'Default',
      style: const MapStyle(
        id: 'default',
        name: 'Default',
        theme: MapTheme.light,
        colors: DEFAULT_COLORS,
        layers: DEFAULT_LAYERS,
        markers: DEFAULT_MARKER,
        polyline: DEFAULT_POLYLINE,
      ),
    ),
    MapStylePreset(
      id: 'dark',
      name: 'Dark Mode',
      style: MapStyle(
        id: 'dark',
        name: 'Dark Mode',
        theme: MapTheme.dark,
        colors: const MapColors(
          primary: '#60a5fa',
          secondary: '#818cf8',
          background: '#0f172a',
          roads: '#475569',
          water: '#0369a1',
          parks: '#166534',
          buildings: '#334155',
          labels: '#e2e8f0',
        ),
        layers: DEFAULT_LAYERS,
        markers: DEFAULT_MARKER.copyWith(color: '#60a5fa'),
        polyline: DEFAULT_POLYLINE.copyWith(color: '#60a5fa'),
      ),
    ),
    MapStylePreset(
      id: 'satellite',
      name: 'Satellite',
      style: MapStyle(
        id: 'satellite',
        name: 'Satellite',
        theme: MapTheme.satellite,
        colors: DEFAULT_COLORS.copyWith(labels: '#ffffff'),
        layers: DEFAULT_LAYERS.copyWith(buildings: false, terrain: true),
        markers: DEFAULT_MARKER.copyWith(color: '#fbbf24'),
        polyline: DEFAULT_POLYLINE.copyWith(color: '#fbbf24', weight: 4.0),
      ),
    ),
    MapStylePreset(
      id: 'navigation',
      name: 'Navigation',
      style: MapStyle(
        id: 'navigation',
        name: 'Navigation',
        theme: MapTheme.light,
        colors: const MapColors(
          primary: '#2563eb',
          secondary: '#7c3aed',
          background: '#f1f5f9',
          roads: '#64748b',
          water: '#38bdf8',
          parks: '#4ade80',
          buildings: '#e2e8f0',
          labels: '#0f172a',
        ),
        layers: DEFAULT_LAYERS.copyWith(traffic: true, transit: true),
        markers: DEFAULT_MARKER.copyWith(color: '#2563eb'),
        polyline: DEFAULT_POLYLINE.copyWith(color: '#2563eb', weight: 6.0, opacity: 0.9),
      ),
    ),
    MapStylePreset(
      id: 'minimal',
      name: 'Minimal',
      style: MapStyle(
        id: 'minimal',
        name: 'Minimal',
        theme: MapTheme.light,
        colors: const MapColors(
          primary: '#000000',
          secondary: '#404040',
          background: '#ffffff',
          roads: '#d4d4d4',
          water: '#e0f2fe',
          parks: '#ecfdf5',
          buildings: '#f5f5f5',
          labels: '#404040',
        ),
        layers: const LayerVisibility(
          roads: true,
          labels: true,
          buildings: false,
          water: true,
          parks: false,
          terrain: false,
          traffic: false,
          transit: false,
        ),
        markers: DEFAULT_MARKER.copyWith(color: '#000000'),
        polyline: DEFAULT_POLYLINE.copyWith(color: '#000000', weight: 3.0, opacity: 1.0),
      ),
    ),
  ];
}
