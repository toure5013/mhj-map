import 'package:flutter/material.dart';
import 'lat_lng.dart';

/// Comprehensive options for configuring a [NavigatrMap] widget.
///
/// ```dart
/// NavigatrMap(
///   options: NavigatrMapOptions(
///     center: NavigatrLatLng(lat: 48.85, lng: 2.35),
///     zoom: 13,
///     minZoom: 4,
///     maxZoom: 18,
///     interactiveFlags: NavigatrInteractiveFlags.all,
///   ),
/// )
/// ```
class NavigatrMapOptions {
  /// Initial center of the map.
  final NavigatrLatLng center;

  /// Initial zoom level.
  final double zoom;

  /// Minimum allowed zoom level.
  final double minZoom;

  /// Maximum allowed zoom level.
  final double maxZoom;

  /// Map rotation in degrees.
  final double rotation;

  /// Whether the map should respond to user gestures.
  final bool interactive;

  /// Controls which gestures are enabled when [interactive] is true.
  final int interactiveFlags;

  /// Whether to keep the map centered around a certain area.
  final bool keepAlive;

  /// Background color behind the tiles.
  final Color backgroundColor;

  /// Optional bounding box to constrain the camera.
  final NavigatrBounds? maxBounds;

  /// Whether to show zoom controls as an overlay.
  final bool showZoomControls;

  /// Whether to show a compass indicator.
  final bool showCompass;

  /// Whether to show the current user location (requires permissions).
  final bool showUserLocation;

  /// Whether to show scale indicator.
  final bool showScale;

  /// Position of the attribution widget.
  final NavigatrAttributionPosition attributionPosition;

  const NavigatrMapOptions({
    required this.center,
    this.zoom = 13.0,
    this.minZoom = 1.0,
    this.maxZoom = 19.0,
    this.rotation = 0.0,
    this.interactive = true,
    this.interactiveFlags = NavigatrInteractiveFlags.all,
    this.keepAlive = true,
    this.backgroundColor = const Color(0xFFE8E8E8),
    this.maxBounds,
    this.showZoomControls = false,
    this.showCompass = false,
    this.showUserLocation = false,
    this.showScale = false,
    this.attributionPosition = NavigatrAttributionPosition.bottomRight,
  });

  NavigatrMapOptions copyWith({
    NavigatrLatLng? center,
    double? zoom,
    double? minZoom,
    double? maxZoom,
    double? rotation,
    bool? interactive,
    int? interactiveFlags,
    bool? keepAlive,
    Color? backgroundColor,
    NavigatrBounds? maxBounds,
    bool? showZoomControls,
    bool? showCompass,
    bool? showUserLocation,
    bool? showScale,
    NavigatrAttributionPosition? attributionPosition,
  }) {
    return NavigatrMapOptions(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
      minZoom: minZoom ?? this.minZoom,
      maxZoom: maxZoom ?? this.maxZoom,
      rotation: rotation ?? this.rotation,
      interactive: interactive ?? this.interactive,
      interactiveFlags: interactiveFlags ?? this.interactiveFlags,
      keepAlive: keepAlive ?? this.keepAlive,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      maxBounds: maxBounds ?? this.maxBounds,
      showZoomControls: showZoomControls ?? this.showZoomControls,
      showCompass: showCompass ?? this.showCompass,
      showUserLocation: showUserLocation ?? this.showUserLocation,
      showScale: showScale ?? this.showScale,
      attributionPosition: attributionPosition ?? this.attributionPosition,
    );
  }
}

/// Bounding box constraints for the map camera.
class NavigatrBounds {
  final NavigatrLatLng southWest;
  final NavigatrLatLng northEast;

  const NavigatrBounds({
    required this.southWest,
    required this.northEast,
  });
}

/// Flags to control which interactive gestures are enabled.
class NavigatrInteractiveFlags {
  static const int none = 0;
  static const int drag = 1 << 0;
  static const int flingAnimation = 1 << 1;
  static const int pinchMove = 1 << 2;
  static const int pinchZoom = 1 << 3;
  static const int doubleTapZoom = 1 << 4;
  static const int doubleTapDragZoom = 1 << 5;
  static const int scrollWheelZoom = 1 << 6;
  static const int rotate = 1 << 7;

  static const int all = drag |
      flingAnimation |
      pinchMove |
      pinchZoom |
      doubleTapZoom |
      doubleTapDragZoom |
      scrollWheelZoom |
      rotate;

  static const int pinchOnly = pinchMove | pinchZoom;
  static const int dragOnly = drag | flingAnimation;
}

/// Where to position the attribution text on the map.
enum NavigatrAttributionPosition {
  bottomLeft,
  bottomRight,
  topLeft,
  topRight,
}
