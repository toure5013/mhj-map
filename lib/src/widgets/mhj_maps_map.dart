import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/lat_lng.dart';
import '../models/tile_provider.dart';
import '../models/map_theme.dart';

/// Controller to interact with a [MhjMapsMap] widget programmatically.
///
/// Obtained via the [MhjMapsMap.onMapCreated] callback.
///
/// ```dart
/// MhjMapsMapController? _controller;
///
/// MhjMapsMap(
///   center: MhjMapsLatLng(lat: 48.85, lng: 2.35),
///   onMapCreated: (controller) => _controller = controller,
/// )
///
/// // Later:
/// _controller?.addMarker(position: myPos, label: 'Hello');
/// _controller?.drawRoute(myPolyline, color: Colors.green);
/// ```
class MhjMapsMapController {
  late final MapController _mapController;
  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];
  final List<CircleMarker> _circles = [];
  final Function() _onUpdate;

  MhjMapsMapController({
    required Function() onUpdate,
  }) : _onUpdate = onUpdate {
    _mapController = MapController();
  }

  /// The underlying [MapController] for advanced use cases.
  MapController get mapController => _mapController;

  // ─── Markers ────────────────────────────────────────────────────────

  /// Adds a marker at the given position.
  void addMarker({
    required MhjMapsLatLng position,
    Widget? icon,
    String? label,
    double width = 40,
    double height = 40,
    Alignment alignment = Alignment.topCenter,
  }) {
    _markers.add(
      Marker(
        point: LatLng(position.lat, position.lng),
        width: width,
        height: height,
        alignment: alignment,
        child: icon ??
            const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    _onUpdate();
  }

  /// Adds a custom widget marker at the given position.
  void addCustomMarker({
    required MhjMapsLatLng position,
    required Widget child,
    double width = 80,
    double height = 80,
    Alignment alignment = Alignment.topCenter,
  }) {
    _markers.add(
      Marker(
        point: LatLng(position.lat, position.lng),
        width: width,
        height: height,
        alignment: alignment,
        child: child,
      ),
    );
    _onUpdate();
  }

  /// Adds a marker using a local PNG/JPG asset or network URL.
  void addImageMarker({
    required MhjMapsLatLng position,
    required String imagePath,
    bool isNetwork = false,
    double width = 40,
    double height = 40,
    Alignment alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
  }) {
    final imageWidget = isNetwork
        ? Image.network(imagePath, width: width, height: height, fit: fit)
        : Image.asset(imagePath, width: width, height: height, fit: fit);

    addCustomMarker(
      position: position,
      width: width,
      height: height,
      alignment: alignment,
      child: imageWidget,
    );
  }

  /// Adds a marker using an SVG (local asset or network).
  void addSvgMarker({
    required MhjMapsLatLng position,
    required String svgPath,
    bool isNetwork = false,
    Color? color,
    double width = 40,
    double height = 40,
    Alignment alignment = Alignment.center,
  }) {
    final svgFilter = color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
        : null;

    final svgWidget = isNetwork
        ? SvgPicture.network(
            svgPath,
            width: width,
            height: height,
            colorFilter: svgFilter,
          )
        : SvgPicture.asset(
            svgPath,
            width: width,
            height: height,
            colorFilter: svgFilter,
          );

    addCustomMarker(
      position: position,
      width: width,
      height: height,
      alignment: alignment,
      child: svgWidget,
    );
  }

  /// Removes all markers from the map.
  void clearMarkers() {
    _markers.clear();
    _onUpdate();
  }

  /// Returns the current number of markers.
  int get markerCount => _markers.length;

  // ─── Routes / Polylines ─────────────────────────────────────────────

  /// Draws a route polyline on the map.
  void drawRoute(
    List<MhjMapsLatLng> polyline, {
    Color color = const Color(0xFF00FF94),
    double width = 4.0,
    bool isDotted = false,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    _polylines.add(
      Polyline(
        points: polyline.map((e) => LatLng(e.lat, e.lng)).toList(),
        color: color,
        strokeWidth: width,
        isDotted: isDotted,
        borderColor: borderColor ?? Colors.transparent,
        borderStrokeWidth: borderWidth,
        strokeCap: StrokeCap.round,
        strokeJoin: StrokeJoin.round,
      ),
    );
    _onUpdate();
  }

  /// Draws a dashed route for walking / alternative routes.
  void drawDashedRoute(
    List<MhjMapsLatLng> polyline, {
    Color color = const Color(0xFF94a3b8),
    double width = 3.0,
  }) {
    drawRoute(polyline, color: color, width: width, isDotted: true);
  }

  /// Removes all polylines from the map.
  void clearRoute() {
    _polylines.clear();
    _onUpdate();
  }

  // ─── Circles ────────────────────────────────────────────────────────

  /// Adds a circle overlay on the map.
  void addCircle({
    required MhjMapsLatLng center,
    required double radiusMeters,
    Color color = const Color(0x303b82f6),
    Color borderColor = const Color(0xFF3b82f6),
    double borderWidth = 2,
  }) {
    _circles.add(
      CircleMarker(
        point: LatLng(center.lat, center.lng),
        radius: radiusMeters,
        useRadiusInMeter: true,
        color: color,
        borderColor: borderColor,
        borderStrokeWidth: borderWidth,
      ),
    );
    _onUpdate();
  }

  /// Removes all circles from the map.
  void clearCircles() {
    _circles.clear();
    _onUpdate();
  }

  // ─── Camera Controls ────────────────────────────────────────────────

  /// Fits the camera so the given polyline fits inside the viewport.
  void fitRoute(
    List<MhjMapsLatLng> polyline, {
    EdgeInsets padding = const EdgeInsets.all(50.0),
  }) {
    if (polyline.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(
      polyline.map((e) => LatLng(e.lat, e.lng)).toList(),
    );

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: padding,
      ),
    );
  }

  /// Fits the map to show all current markers.
  void fitMarkers({EdgeInsets padding = const EdgeInsets.all(50.0)}) {
    if (_markers.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(
      _markers.map((m) => m.point).toList(),
    );

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: padding,
      ),
    );
  }

  /// Moves the camera to a specific position.
  void moveTo(MhjMapsLatLng position, {double zoom = 13.0}) {
    _mapController.move(LatLng(position.lat, position.lng), zoom);
  }

  /// Zooms in by one level.
  void zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom + 1);
  }

  /// Zooms out by one level.
  void zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom - 1);
  }

  /// Rotates the map to the given angle in degrees.
  void rotateTo(double degrees) {
    _mapController.rotate(degrees);
  }

  /// Resets the map rotation to north.
  void resetRotation() {
    _mapController.rotate(0);
  }

  /// Current zoom level.
  double get currentZoom => _mapController.camera.zoom;

  /// Current center of the map.
  MhjMapsLatLng get currentCenter => MhjMapsLatLng(
        lat: _mapController.camera.center.latitude,
        lng: _mapController.camera.center.longitude,
      );

  // ─── Bulk Operations ────────────────────────────────────────────────

  /// Clears all overlays (markers, polylines, circles).
  void clearAll() {
    _markers.clear();
    _polylines.clear();
    _circles.clear();
    _onUpdate();
  }
}

/// A high-performance, customizable map widget powered by OpenStreetMap.
///
/// ## Basic Usage
/// ```dart
/// MhjMapsMap(
///   center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
///   zoom: 13,
/// )
/// ```
///
/// ## With a Theme
/// ```dart
/// MhjMapsMap(
///   center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
///   theme: MhjMapsMapThemes.darkElegant,
/// )
/// ```
///
/// ## With Custom Tile Provider
/// ```dart
/// MhjMapsMap(
///   center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
///   tileProvider: MhjMapsTileProvider.cartoVoyager,
/// )
/// ```
///
/// ## Full Customization
/// ```dart
/// MhjMapsMap(
///   center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
///   zoom: 15,
///   minZoom: 4,
///   maxZoom: 18,
///   showZoomControls: true,
///   showAttribution: true,
///   tileProvider: MhjMapsTileProvider.custom(
///     urlTemplate: 'https://mytiles.example.com/{z}/{x}/{y}.png',
///     name: 'My Custom Tiles',
///   ),
///   onTap: (position) => print('Tapped at $position'),
///   onLongPress: (position) => print('Long pressed at $position'),
///   onMapCreated: (controller) {
///     controller.addMarker(position: myPos);
///     controller.drawRoute(myPolyline);
///   },
/// )
/// ```
class MhjMapsMap extends StatefulWidget {
  /// Initial center of the map.
  final MhjMapsLatLng center;

  /// Initial zoom level (default: 13.0).
  final double zoom;

  /// Minimum zoom level (default: 1.0).
  final double minZoom;

  /// Maximum zoom level (default: 19.0).
  final double maxZoom;

  /// Initial rotation in degrees.
  final double rotation;

  /// Tile URL template. Overridden by [tileProvider] or [theme].
  final String? tileUrl;

  /// Attribution text. Overridden by [tileProvider] or [theme].
  final String? attribution;

  /// A tile provider configuration. Takes priority over [tileUrl].
  final MhjMapsTileProvider? tileProvider;

  /// A complete theme combining tiles + styling. Takes highest priority.
  final MhjMapsMapTheme? theme;

  /// Whether to show zoom controls overlay.
  final bool showZoomControls;

  /// Whether to show attribution.
  final bool showAttribution;

  /// Background color behind tiles.
  final Color? backgroundColor;

  /// Callback when the map is created and the controller is ready.
  final Function(MhjMapsMapController controller)? onMapCreated;

  /// Callback when the user taps on the map.
  final Function(MhjMapsLatLng position)? onTap;

  /// Callback when the user long-presses on the map.
  final Function(MhjMapsLatLng position)? onLongPress;

  /// Callback when the camera position changes.
  final Function(MhjMapsLatLng center, double zoom)? onCameraMove;

  /// Additional layers to render on top of the map.
  final List<Widget>? additionalLayers;

  const MhjMapsMap({
    super.key,
    required this.center,
    this.zoom = 13.0,
    this.minZoom = 1.0,
    this.maxZoom = 19.0,
    this.rotation = 0.0,
    this.tileUrl,
    this.attribution,
    this.tileProvider,
    this.theme,
    this.showZoomControls = false,
    this.showAttribution = true,
    this.backgroundColor,
    this.onMapCreated,
    this.onTap,
    this.onLongPress,
    this.onCameraMove,
    this.additionalLayers,
  });

  @override
  State<MhjMapsMap> createState() => _MhjMapsMapState();
}

class _MhjMapsMapState extends State<MhjMapsMap> {
  late MhjMapsMapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MhjMapsMapController(onUpdate: () {
      if (mounted) setState(() {});
    });

    // Defer onMapCreated to avoid build-time setState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMapCreated?.call(_controller);
    });
  }

  // Resolve the tile configuration from theme > tileProvider > tileUrl > default
  String get _resolvedTileUrl {
    if (widget.theme != null) return widget.theme!.tileProvider.urlTemplate;
    if (widget.tileProvider != null) return widget.tileProvider!.urlTemplate;
    return widget.tileUrl ?? 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  }

  String get _resolvedAttribution {
    if (widget.theme != null) return widget.theme!.tileProvider.attribution;
    if (widget.tileProvider != null) return widget.tileProvider!.attribution;
    return widget.attribution ?? '© OpenStreetMap contributors';
  }

  List<String> get _resolvedSubdomains {
    if (widget.theme != null) return widget.theme!.tileProvider.subdomains;
    if (widget.tileProvider != null) return widget.tileProvider!.subdomains;
    return const [];
  }

  int get _resolvedMaxZoom {
    if (widget.theme != null) return widget.theme!.tileProvider.maxZoom;
    if (widget.tileProvider != null) return widget.tileProvider!.maxZoom;
    return 19;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _controller._mapController,
          options: MapOptions(
            initialCenter: LatLng(widget.center.lat, widget.center.lng),
            initialZoom: widget.zoom,
            minZoom: widget.minZoom,
            maxZoom: widget.maxZoom,
            initialRotation: widget.rotation,
            backgroundColor: widget.backgroundColor ??
                (widget.theme?.isDark == true
                    ? const Color(0xFF1a1a2e)
                    : const Color(0xFFE8E8E8)),
            onTap: widget.onTap != null
                ? (tapPosition, point) {
                    widget.onTap!(MhjMapsLatLng(
                      lat: point.latitude,
                      lng: point.longitude,
                    ));
                  }
                : null,
            onLongPress: widget.onLongPress != null
                ? (tapPosition, point) {
                    widget.onLongPress!(MhjMapsLatLng(
                      lat: point.latitude,
                      lng: point.longitude,
                    ));
                  }
                : null,
            onPositionChanged: widget.onCameraMove != null
                ? (camera, hasGesture) {
                    final center = camera.center;
                    final zoom = camera.zoom;
                    if (center != null && zoom != null) {
                      widget.onCameraMove!(
                        MhjMapsLatLng(
                          lat: center.latitude,
                          lng: center.longitude,
                        ),
                        zoom,
                      );
                    }
                  }
                : null,
          ),
          children: [
            TileLayer(
              urlTemplate: _resolvedTileUrl,
              userAgentPackageName: 'dev.mhj_maps.flutter',
              subdomains: _resolvedSubdomains,
              maxZoom: _resolvedMaxZoom.toDouble(),
            ),
            CircleLayer(circles: _controller._circles),
            PolylineLayer(polylines: _controller._polylines),
            MarkerLayer(markers: _controller._markers),
            if (widget.additionalLayers != null) ...widget.additionalLayers!,
            if (widget.showAttribution && _resolvedAttribution.isNotEmpty)
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    _resolvedAttribution,
                    onTap: () {},
                  ),
                ],
              ),
          ],
        ),
        // Zoom controls overlay
        if (widget.showZoomControls)
          Positioned(
            right: 16,
            bottom: 80,
            child: Column(
              children: [
                _ZoomButton(
                  icon: Icons.add,
                  onPressed: _controller.zoomIn,
                  isDark: widget.theme?.isDark ?? false,
                ),
                const SizedBox(height: 8),
                _ZoomButton(
                  icon: Icons.remove,
                  onPressed: _controller.zoomOut,
                  isDark: widget.theme?.isDark ?? false,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _ZoomButton({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: isDark ? const Color(0xFF2a2a3e) : Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 20,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
