# Mhj-maps 🗺️

[![pub package](https://img.shields.io/pub/v/mhj_maps.svg)](https://pub.dev/packages/mhj_maps)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**The open-source Maps SDK for Flutter.** Zero API keys, zero cost, high-performance routing, geocoding, and fully customizable map rendering.

Mhj-maps is a drop-in alternative to Google Maps SDK that uses free, public OpenStreetMap infrastructure — no billing, no quotas, no API keys.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🗺️ **Map Widget** | Customizable `MhjMapsMap` widget powered by `flutter_map` |
| 🎨 **13 Built-in Themes** | Dark, light, satellite, topo, cycling, minimal, and more |
| 🔌 **13 Tile Providers** | OSM, CartoDB, Esri, OpenTopo, CyclOSM, HOT and others |
| 🧭 **Routing** | Turn-by-turn routing via Valhalla (auto, bicycle, pedestrian) |
| 📍 **Geocoding** | Forward & reverse geocoding via Nominatim |
| 🔎 **Autocomplete** | Address suggestions via Photon |
| 📐 **Custom Markers** | Add any Flutter widget as a map marker |
| 🟢 **Circle Overlays** | Radius visualization on the map |
| 🎯 **Tap Events** | `onTap`, `onLongPress`, `onCameraMove` callbacks |
| 🔄 **Camera Control** | Zoom, rotate, fit bounds, move programmatically |
| 💰 **Zero Cost** | No API keys, no billing — 100% free infrastructure |

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  mhj_maps: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

### Display a Map

```dart
import 'package:mhj_maps/mhj_maps.dart';

MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  zoom: 13,
)
```

### Apply a Theme

Choose from **13 built-in themes** with a single parameter:

```dart
MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  theme: MhjMapsMapThemes.darkElegant,
)
```

### Calculate a Route

```dart
final nav = Mhj-maps();

final route = await nav.route(
  origin: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  destination: MhjMapsLatLng(lat: 45.7640, lng: 4.8357),
);

print('Duration: ${route.durationText}');  // "4 hrs 32 mins"
print('Distance: ${route.distanceText}');  // "465.2 km"
```

---

## 🎨 Map Themes

MhjMaps ships with **13 ready-to-use themes**. Switch themes at runtime with zero configuration:

### Light Themes

| Theme | Description |
|---|---|
| `MhjMapsMapThemes.standard` | Classic OpenStreetMap look |
| `MhjMapsMapThemes.cleanLight` | Minimalist CartoDB Positron |
| `MhjMapsMapThemes.voyager` | Colorful, detailed — ideal for nav apps |
| `MhjMapsMapThemes.blankCanvas` | No labels — perfect for custom overlays |
| `MhjMapsMapThemes.professional` | Esri World Street — professional cartography |
| `MhjMapsMapThemes.whisper` | Ultra-minimal gray basemap |

### Dark Themes

| Theme | Description |
|---|---|
| `MhjMapsMapThemes.darkElegant` | Premium dark basemap (CartoDB Dark Matter) |
| `MhjMapsMapThemes.darkSilent` | Dark, no labels — sleek and minimal |

### Specialty Themes

| Theme | Description |
|---|---|
| `MhjMapsMapThemes.topographic` | Contour lines and elevation (OpenTopoMap) |
| `MhjMapsMapThemes.cycling` | Bike lanes and cycling routes (CyclOSM) |
| `MhjMapsMapThemes.humanitarianMap` | Critical infrastructure emphasis (HOT) |
| `MhjMapsMapThemes.satellite` | High-res satellite imagery (Esri) |
| `MhjMapsMapThemes.terrain` | Esri topographic with terrain details |

### Browse Themes Programmatically

```dart
// All themes
final all = MhjMapsMapThemes.all;

// Dark themes only
final dark = MhjMapsMapThemes.dark;

// By category
final outdoor = MhjMapsMapThemes.byCategory(MapThemeCategory.outdoor);
```

---

## 🔌 Tile Providers

Use any of the **13 built-in tile providers** directly, or create your own:

```dart
// Use a built-in provider
MhjMapsMap(
  center: myCenter,
  tileProvider: MhjMapsTileProvider.cartoVoyager,
)

// Use a custom tile server
MhjMapsMap(
  center: myCenter,
  tileProvider: MhjMapsTileProvider.custom(
    urlTemplate: 'https://mytiles.example.com/{z}/{x}/{y}.png',
    name: 'My Custom Tiles',
    attribution: '© My Company',
  ),
)
```

### Available Providers

| Provider | ID | Style |
|---|---|---|
| `MhjMapsTileProvider.openStreetMap` | Standard OSM | Light |
| `MhjMapsTileProvider.cartoPositron` | Minimalist light | Light |
| `MhjMapsTileProvider.cartoDarkMatter` | Sleek dark | Dark |
| `MhjMapsTileProvider.cartoVoyager` | Colorful & detailed | Light |
| `MhjMapsTileProvider.cartoPositronNoLabels` | Clean, no text | Light |
| `MhjMapsTileProvider.cartoDarkMatterNoLabels` | Dark, no text | Dark |
| `MhjMapsTileProvider.openTopoMap` | Topographic | Light |
| `MhjMapsTileProvider.cyclOSM` | Cycling | Light |
| `MhjMapsTileProvider.humanitarian` | HOT | Light |
| `MhjMapsTileProvider.esriWorldStreet` | Professional | Light |
| `MhjMapsTileProvider.esriWorldImagery` | Satellite | — |
| `MhjMapsTileProvider.esriWorldTopo` | Terrain | Light |
| `MhjMapsTileProvider.esriLightGray` | Ultra-minimal | Light |

---

## 🎮 Map Controller

The `MhjMapsMapController` gives you full programmatic control:

```dart
MhjMapsMapController? _controller;

MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.85, lng: 2.35),
  onMapCreated: (controller) => _controller = controller,
)
```

### Markers

MhjMaps provides robust helpers to add any kind of marker to your map:

```dart
// 1. Basic Icon Marker
_controller.addMarker(
  position: MhjMapsLatLng(lat: 48.85, lng: 2.35),
  icon: Icon(Icons.location_on, color: Colors.red, size: 40),
);

// 2. SVG Marker (Local or Network)
// MhjMaps has native flutter_svg support. You can even tint SVGs dynamically!
_controller.addSvgMarker(
  position: myPos,
  svgPath: 'assets/icons/pin.svg', // or 'https://...'
  isNetwork: false,
  color: Colors.blue, // Automatically tints the SVG
  width: 45,
  height: 45,
);

// 3. Image Marker (PNG/JPG)
_controller.addImageMarker(
  position: myPos,
  imagePath: 'https://example.com/marker.png',
  isNetwork: true,
  width: 40,
);

// 4. Custom Widget Marker (Any Flutter UI!)
_controller.addCustomMarker(
  position: myPos,
  child: Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text('€15', style: TextStyle(color: Colors.white)),
  ),
);

_controller.clearMarkers();
```

### Routes & Polylines

```dart
// Solid route
_controller.drawRoute(
  routeResult.polyline,
  color: Colors.blue,
  width: 5.0,
  borderColor: Colors.black26,
  borderWidth: 1,
);

// Dashed line (walking, alternative)
_controller.drawDashedRoute(altRoute.polyline, color: Colors.grey);

_controller.clearRoute();
```

### Circle Overlays

```dart
_controller.addCircle(
  center: MhjMapsLatLng(lat: 48.85, lng: 2.35),
  radiusMeters: 500,
  color: Colors.blue.withOpacity(0.2),
  borderColor: Colors.blue,
);
```

### Camera Control

```dart
_controller.moveTo(MhjMapsLatLng(lat: 48.85, lng: 2.35), zoom: 15);
_controller.zoomIn();
_controller.zoomOut();
_controller.rotateTo(45);
_controller.resetRotation();
_controller.fitRoute(polyline);
_controller.fitMarkers();

// Read current state
print(_controller.currentZoom);
print(_controller.currentCenter);
```

---

## 📍 Geocoding

### Forward Geocoding

```dart
final nav = MhjMaps();
final result = await nav.geocode('Tour Eiffel, Paris');
print('${result.lat}, ${result.lng}');  // 48.8584, 2.2945
print(result.displayName);
```

### Reverse Geocoding

```dart
final result = await nav.reverseGeocode(48.8584, 2.2945);
print(result.displayName);  // "Tour Eiffel, Avenue Anatole France, ..."
```

---

## 🔎 Autocomplete

```dart
final suggestions = await nav.autocomplete('Par', limit: 5);

for (final s in suggestions) {
  print('${s.name} — ${s.city}, ${s.country}');
  print('  → ${s.lat}, ${s.lng}');
}
```

---

## 🧭 Routing

```dart
final route = await nav.route(
  origin: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  destination: MhjMapsLatLng(lat: 45.7640, lng: 4.8357),
  costing: 'auto',  // 'auto', 'bicycle', 'pedestrian'
);

// Route summary
print(route.durationText);   // "4 hrs 32 mins"
print(route.distanceText);   // "465.2 km"
print(route.polyline.length); // Number of points

// Turn-by-turn instructions
for (final step in route.maneuvers ?? []) {
  print('${step.instruction} (${step.distanceText})');
}
```

---

## ⚡ Full Example

```dart
import 'package:flutter/material.dart';
import 'package:mhj_maps/mhj_maps.dart';

class MyMapScreen extends StatefulWidget {
  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  final nav = MhjMaps();
  MhjMapsMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MhjMapsMap(
        center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
        zoom: 13,
        theme: MhjMapsMapThemes.darkElegant,
        showZoomControls: true,
        onMapCreated: (controller) => _controller = controller,
        onTap: (position) async {
          // Add marker at tapped position
          _controller?.addMarker(position: position);

          // Reverse geocode
          final result = await nav.reverseGeocode(
            position.lat, position.lng,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.displayName)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = await nav.route(
            origin: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
            destination: MhjMapsLatLng(lat: 48.8738, lng: 2.2950),
          );
          _controller?.drawRoute(route.polyline);
          _controller?.fitRoute(route.polyline);
        },
        child: Icon(Icons.directions),
      ),
    );
  }
}
```

---

## 🏗 Architecture

MhjMaps uses a **distributed client-side architecture**. All requests go directly from the user's device to free public OpenStreetMap infrastructure:

| Service | Provider | Purpose |
|---|---|---|
| Routing | [Valhalla](https://valhalla.openstreetmap.de/) | Turn-by-turn directions |
| Geocoding | [Nominatim](https://nominatim.openstreetmap.org/) | Address ↔ coordinates |
| Autocomplete | [Photon](https://photon.komoot.io/) | Address suggestions |
| Map Tiles | Various (OSM, CartoDB, Esri) | Map rendering |

**No proxy server needed.** No API keys. No billing.

---

## 🔧 Configuration

### Custom API Endpoints

If you host your own Valhalla/Nominatim/Photon instances:

```dart
final nav = MhjMaps(
  config: MhjMapsConfig(
    valhallaUrl: 'https://my-valhalla.example.com',
    nominatimUrl: 'https://my-nominatim.example.com',
    photonUrl: 'https://my-photon.example.com',
  ),
);
```

---

## 📋 API Reference

### MhjMapsMap

| Parameter | Type | Default | Description |
|---|---|---|---|
| `center` | `MhjMapsLatLng` | **required** | Initial center |
| `zoom` | `double` | `13.0` | Initial zoom |
| `minZoom` | `double` | `1.0` | Minimum zoom |
| `maxZoom` | `double` | `19.0` | Maximum zoom |
| `rotation` | `double` | `0.0` | Initial rotation |
| `theme` | `MhjMapsMapTheme?` | `null` | Complete theme |
| `tileProvider` | `MhjMapsTileProvider?` | `null` | Tile provider |
| `tileUrl` | `String?` | OSM | Tile URL template |
| `showZoomControls` | `bool` | `false` | Show +/- buttons |
| `showAttribution` | `bool` | `true` | Show attribution |
| `onMapCreated` | `Function?` | `null` | Controller callback |
| `onTap` | `Function?` | `null` | Tap callback |
| `onLongPress` | `Function?` | `null` | Long press callback |
| `onCameraMove` | `Function?` | `null` | Camera move callback |
| `additionalLayers` | `List<Widget>?` | `null` | Extra map layers |

---

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guide](https://github.com/touresouleymane/mhj_maps/blob/main/CONTRIBUTING.md) before submitting a PR.

## 📄 License

Apache 2.0 — see [LICENSE](LICENSE) for details.

---

**Built with ❤️ by [MhjMaps](https://mhj_maps.mihradj.com)**
