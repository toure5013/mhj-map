# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-04

### Added

- **MhjMapsMap Widget** — High-performance, customizable map widget powered by `flutter_map`.
  - `theme` parameter — Apply a complete visual theme in one line.
  - `tileProvider` parameter — Switch between 13+ free tile providers.
  - `onTap` / `onLongPress` — Tap and long-press callbacks with coordinates.
  - `onCameraMove` — Real-time camera position updates.
  - `showZoomControls` — Built-in zoom in/out overlay.
  - `additionalLayers` — Add custom layers on top of the map.
  - `minZoom` / `maxZoom` / `rotation` — Full camera control.

- **MhjMapsMapController** — Programmatic map control.
  - `addMarker()` / `addCustomMarker()` — Standard and custom widget markers.
  - `drawRoute()` / `drawDashedRoute()` — Solid and dashed polylines with borders.
  - `addCircle()` — Circle overlays for radius visualization.
  - `fitRoute()` / `fitMarkers()` — Auto-fit camera to content.
  - `zoomIn()` / `zoomOut()` / `rotateTo()` / `resetRotation()` — Camera methods.
  - `clearAll()` — Remove all overlays at once.

- **13 Built-in Map Themes** (`MhjMapsMapThemes`)
  - Light: `standard`, `cleanLight`, `voyager`, `blankCanvas`, `professional`, `whisper`
  - Dark: `darkElegant`, `darkSilent`
  - Specialty: `topographic`, `cycling`, `humanitarianMap`, `satellite`, `terrain`

- **13 Tile Providers** (`MhjMapsTileProvider`)
  - OpenStreetMap, CartoDB (Positron, Dark Matter, Voyager, No Labels variants),
    OpenTopoMap, CyclOSM, Humanitarian HOT, Esri (Street, Imagery, Topo, Light Gray)
  - `MhjMapsTileProvider.custom()` factory for any tile URL.

- **Routing** — Turn-by-turn routing via Valhalla.
  - Support for `auto`, `bicycle`, `pedestrian` costing modes.
  - Polyline decoding (precision 6).
  - Maneuver parsing with instructions.

- **Geocoding** — Forward and reverse geocoding via Nominatim.

- **Autocomplete** — Address suggestions via Photon.

- **Utilities**
  - `MhjMapsFormat.duration()` / `MhjMapsFormat.distance()` — Human-readable formatting.
  - `MhjMapsPolyline.decode()` — Encoded polyline decoder.

- **Models**
  - `MhjMapsLatLng`, `MhjMapsConfig`, `RouteResult`, `GeocodeResult`,
    `AutocompleteResult`, `Maneuver`, `MapStyle`, `MhjMapsMapOptions`,
    `MhjMapsBounds`, `MhjMapsInteractiveFlags`.
