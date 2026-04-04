import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/lat_lng.dart';

class NavigatrMapController {
  late final MapController _mapController;
  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];
  final Function() _onUpdate;

  NavigatrMapController({
    required Function() onUpdate,
  }) : _onUpdate = onUpdate {
    _mapController = MapController();
  }

  void addMarker({
    required NavigatrLatLng position,
    Widget? icon,
    String? label,
  }) {
    _markers.add(
      Marker(
        point: LatLng(position.lat, position.lng),
        width: 40,
        height: 40,
        child: icon ?? const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    _onUpdate();
  }

  void clearMarkers() {
    _markers.clear();
    _onUpdate();
  }

  void drawRoute(List<NavigatrLatLng> polyline, {Color color = const Color(0xFF00FF94), double width = 4.0}) {
    _polylines.add(
      Polyline(
        points: polyline.map((e) => LatLng(e.lat, e.lng)).toList(),
        color: color,
        strokeWidth: width,
        strokeCap: StrokeCap.round,
        strokeJoin: StrokeJoin.round,
      ),
    );
    _onUpdate();
  }

  void clearRoute() {
    _polylines.clear();
    _onUpdate();
  }

  void fitRoute(List<NavigatrLatLng> polyline, {EdgeInsets padding = const EdgeInsets.all(50.0)}) {
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

  void moveTo(NavigatrLatLng position, {double zoom = 13.0}) {
    _mapController.move(LatLng(position.lat, position.lng), zoom);
  }
}

class NavigatrMap extends StatefulWidget {
  final NavigatrLatLng center;
  final double zoom;
  final String? tileUrl;
  final String? attribution;
  final Function(NavigatrMapController controller)? onMapCreated;

  const NavigatrMap({
    super.key,
    required this.center,
    this.zoom = 13.0,
    this.tileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    this.attribution = '© OpenStreetMap contributors',
    this.onMapCreated,
  });

  @override
  State<NavigatrMap> createState() => _NavigatrMapState();
}

class _NavigatrMapState extends State<NavigatrMap> {
  late NavigatrMapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NavigatrMapController(onUpdate: () {
      if (mounted) setState(() {});
    });
    if (widget.onMapCreated != null) {
      widget.onMapCreated!(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _controller._mapController,
      options: MapOptions(
        initialCenter: LatLng(widget.center.lat, widget.center.lng),
        initialZoom: widget.zoom,
      ),
      children: [
        TileLayer(
          urlTemplate: widget.tileUrl!,
          userAgentPackageName: 'dev.navigatr.flutter',
          subdomains: const ['a', 'b', 'c'],
        ),
        PolylineLayer(polylines: _controller._polylines),
        MarkerLayer(markers: _controller._markers),
        if (widget.attribution != null)
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                widget.attribution!,
                onTap: () {},
              ),
            ],
          ),
      ],
    );
  }
}
