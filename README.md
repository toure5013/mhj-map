# Navigatr Flutter SDK

The open-source alternative to Google Maps SDK for Flutter. Zero API keys, zero cost, high-performance routing, geocoding and map rendering.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  navigatr:
    path: ../packages/flutter
```

Or when published:

```yaml
dependencies:
  navigatr: ^1.0.0
```

## Features

- **Routing**: High-performance routing via Valhalla.
- **Geocoding**: Forward and reverse geocoding via Nominatim.
- **Autocomplete**: Address suggestions via Photon.
- **Map Component**: Ready-to-use Flutter widget powered by `flutter_map`.
- **Zero Configuration**: No API keys required for public infrastructure.

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:navigatr/navigatr.dart';

void main() async {
  final nav = Navigatr();

  // Geocode an address
  final origin = await nav.geocode('Accra Mall, Ghana');
  final dest = await nav.geocode('Kotoka Airport, Ghana');

  // Calculate route
  final route = await nav.route(
    origin: NavigatrLatLng(lat: origin.lat, lng: origin.lng),
    destination: NavigatrLatLng(lat: dest.lat, lng: dest.lng),
  );

  print('Duration: ${route.durationText}');
  print('Distance: ${route.distanceText}');
}
```

## Embedding a Map

```dart
NavigatrMap(
  center: NavigatrLatLng(lat: 5.6037, lng: -0.1870),
  zoom: 13,
  onMapCreated: (controller) {
    // control the map here
    controller.drawRoute(myPolyline);
    controller.addMarker(position: myPos, label: 'My Location');
  },
)
```

## Architecture

This SDK follows the distributed client-side architecture of the Navigatr project. Requests are made directly from the user's device to public OpenStreetMap-supported infrastructure (Valhalla, Nominatim, Photon).

## License

MIT
