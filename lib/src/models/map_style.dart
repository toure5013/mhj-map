import 'package:flutter/material.dart';

enum MapTheme { light, dark, satellite, terrain, custom }

class MapColors {
  final String? primary;
  final String? secondary;
  final String? background;
  final String? roads;
  final String? water;
  final String? parks;
  final String? buildings;
  final String? labels;

  const MapColors({
    this.primary,
    this.secondary,
    this.background,
    this.roads,
    this.water,
    this.parks,
    this.buildings,
    this.labels,
  });

  MapColors copyWith({
    String? primary,
    String? secondary,
    String? background,
    String? roads,
    String? water,
    String? parks,
    String? buildings,
    String? labels,
  }) {
    return MapColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      roads: roads ?? this.roads,
      water: water ?? this.water,
      parks: parks ?? this.parks,
      buildings: buildings ?? this.buildings,
      labels: labels ?? this.labels,
    );
  }
}

class LayerVisibility {
  final bool roads;
  final bool labels;
  final bool buildings;
  final bool water;
  final bool parks;
  final bool terrain;
  final bool traffic;
  final bool transit;

  const LayerVisibility({
    this.roads = true,
    this.labels = true,
    this.buildings = true,
    this.water = true,
    this.parks = true,
    this.terrain = false,
    this.traffic = false,
    this.transit = true,
  });

  LayerVisibility copyWith({
    bool? roads,
    bool? labels,
    bool? buildings,
    bool? water,
    bool? parks,
    bool? terrain,
    bool? traffic,
    bool? transit,
  }) {
    return LayerVisibility(
      roads: roads ?? this.roads,
      labels: labels ?? this.labels,
      buildings: buildings ?? this.buildings,
      water: water ?? this.water,
      parks: parks ?? this.parks,
      terrain: terrain ?? this.terrain,
      traffic: traffic ?? this.traffic,
      transit: transit ?? this.transit,
    );
  }
}

class MarkerStyle {
  final String? iconUrl;
  final Size iconSize;
  final Offset iconAnchor;
  final String color;
  final double scale;

  const MarkerStyle({
    this.iconUrl,
    this.iconSize = const Size(25, 41),
    this.iconAnchor = const Offset(12.5, 41),
    this.color = '#3b82f6',
    this.scale = 1.0,
  });

  MarkerStyle copyWith({
    String? iconUrl,
    Size? iconSize,
    Offset? iconAnchor,
    String? color,
    double? scale,
  }) {
    return MarkerStyle(
      iconUrl: iconUrl ?? this.iconUrl,
      iconSize: iconSize ?? this.iconSize,
      iconAnchor: iconAnchor ?? this.iconAnchor,
      color: color ?? this.color,
      scale: scale ?? this.scale,
    );
  }
}

class PolylineStyle {
  final String color;
  final double weight;
  final double opacity;
  final String? dashArray;
  final StrokeCap lineCap;
  final StrokeJoin lineJoin;

  const PolylineStyle({
    this.color = '#3b82f6',
    this.weight = 5.0,
    this.opacity = 0.8,
    this.dashArray,
    this.lineCap = StrokeCap.round,
    this.lineJoin = StrokeJoin.round,
  });

  PolylineStyle copyWith({
    String? color,
    double? weight,
    double? opacity,
    String? dashArray,
    StrokeCap? lineCap,
    StrokeJoin? lineJoin,
  }) {
    return PolylineStyle(
      color: color ?? this.color,
      weight: weight ?? this.weight,
      opacity: opacity ?? this.opacity,
      dashArray: dashArray ?? this.dashArray,
      lineCap: lineCap ?? this.lineCap,
      lineJoin: lineJoin ?? this.lineJoin,
    );
  }
}

class MapStyle {
  final String id;
  final String name;
  final MapTheme theme;
  final MapColors colors;
  final LayerVisibility layers;
  final MarkerStyle markers;
  final PolylineStyle polyline;

  const MapStyle({
    required this.id,
    required this.name,
    this.theme = MapTheme.light,
    this.colors = const MapColors(),
    this.layers = const LayerVisibility(),
    this.markers = const MarkerStyle(),
    this.polyline = const PolylineStyle(),
  });

  MapStyle copyWith({
    String? id,
    String? name,
    MapTheme? theme,
    MapColors? colors,
    LayerVisibility? layers,
    MarkerStyle? markers,
    PolylineStyle? polyline,
  }) {
    return MapStyle(
      id: id ?? this.id,
      name: name ?? this.name,
      theme: theme ?? this.theme,
      colors: colors ?? this.colors,
      layers: layers ?? this.layers,
      markers: markers ?? this.markers,
      polyline: polyline ?? this.polyline,
    );
  }
}

class MapStylePreset {
  final String id;
  final String name;
  final MapStyle style;

  const MapStylePreset({
    required this.id,
    required this.name,
    required this.style,
  });
}
