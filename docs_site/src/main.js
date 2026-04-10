import './style.css'
import { marked } from 'marked'

const markdownRaw = `
# MhjMaps 🗺️

[![pub package](https://img.shields.io/pub/v/mhj_maps.svg)](https://pub.dev/packages/mhj_maps)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**The open-source Maps SDK for Flutter.** Zero API keys, zero cost, high-performance routing, geocoding, and fully customizable map rendering.

MhjMaps is a drop-in alternative to Google Maps SDK that uses free, public OpenStreetMap infrastructure — no billing, no quotas, no API keys.

---

<section id="features">
## ✨ Features

| Feature | Description |
|---|---|
| 🗺️ **Map Widget** | Customizable \`MhjMapsMap\` widget powered by \`flutter_map\` |
| 🎨 **19 Built-in Themes** | Dark, light, satellite, topo, cycling, minimal, and premium night modes |
| 🔌 **19 Tile Providers** | OSM, CartoDB, Esri, OpenTopo, Wikimedia, Stamen and others |
| 🧭 **Routing** | Turn-by-turn routing via Valhalla (auto, bicycle, pedestrian) |
| 📍 **Geocoding** | Forward & reverse geocoding via Nominatim |
| 🔎 **Autocomplete** | Address suggestions via Photon |
| 📐 **Custom Markers** | Add any Flutter widget as a map marker |
| 🏗️ **Controller** | Full programmatic control (zoom, rotate, move, fit bounds) |
| 🎯 **Customization** | Native controls for boussole, capture d'écran, and scale |
| 💰 **Zero Cost** | No API keys, no billing — 100% free infrastructure |
</section>

---

<section id="installation">
## 📦 Installation

Add to your \`pubspec.yaml\`:

\`\`\`yaml
dependencies:
  mhj_maps: ^1.0.0
\`\`\`

Then run:

\`\`\`bash
flutter pub get
\`\`\`
</section>

---

<section id="quick-start">
## 🚀 Quick Start

### Display a Map

\`\`\`dart
import 'package:mhj_maps/mhj_maps.dart';

MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  zoom: 13,
)
\`\`\`

### Apply a Theme

Choose from **19 built-in themes** with a single parameter:

\`\`\`dart
MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  theme: MhjMapsMapThemes.darkElegant,
)
\`\`\`
</section>

---

<section id="map-themes">
## 🎨 Map Themes

MhjMaps ships with **19 ready-to-use themes**. Switch themes at runtime with zero configuration:

### Common Themes
| Theme | Description |
|---|---|
| \`MhjMapsMapThemes.standard\` | Classic OpenStreetMap look |
| \`MhjMapsMapThemes.darkElegant\` | Premium dark basemap (CartoDB Dark Matter) |
| \`MhjMapsMapThemes.satellite\` | High-resolution Esri Satellite imagery |
| \`MhjMapsMapThemes.terrain\` | Esri Topographic map with terrain details |

### New & Specialized Themes
| Theme | Description |
|---|---|
| \`MhjMapsMapThemes.midnight\` | Deep black with neon blue/pink highlights |
| \`MhjMapsMapThemes.highContrast\` | B&W (Stamen Toner) for maximum readability |
| \`MhjMapsMapThemes.forest\` | Nature-focused terrain with green tones |
| \`MhjMapsMapThemes.educational\` | Clear, informative map from Wikimedia |
| \`MhjMapsMapThemes.cyclePro\` | Advanced cycling routes and topography |
| \`MhjMapsMapThemes.arctic\` | Cold, blue-toned map for a fresh look |
</section>

---

<section id="customization">
## ⚙️ Customization

Customize the map look and feel with native properties:

\`\`\`dart
MhjMapsMap(
  center: myLocation,
  showCompass: true,             // Interactive compass
  useLargeZoomButtons: true,     // Premium UI controls
  showScale: true,               // Scale indicator
  showUserLocation: true,        // User location marker
  defaultMarkerSize: 48.0,       // Global marker scaling
  defaultPolylineStrokeWidth: 6.0,  // Route thickness
  interactive: true,             // Enable/disable gestures
)
\`\`\`
</section>

---

<section id="map-controller">
## 🎮 Map Controller

The \`MhjMapsMapController\` gives you full programmatic control:

\`\`\`dart
MhjMapsMapController? _controller;

MhjMapsMap(
  center: MhjMapsLatLng(lat: 48.85, lng: 2.35),
  onMapCreated: (controller) => _controller = controller,
)

// Later in your code:
_controller?.addMarker(position: myPos, label: 'Custom Destination');
_controller?.drawRoute(myPolyline, color: Colors.blue);
_controller?.fitRoute(myPolyline);
_controller?.resetRotation();
\`\`\`
</section>

---

<section id="geocoding">
## 📍 Geocoding

### Forward Geocoding

\`\`\`dart
final nav = MhjMaps();
final result = await nav.geocode('Tour Eiffel, Paris');
print('\${result.lat}, \${result.lng}');  // 48.8584, 2.2945
\`\`\`

### Reverse Geocoding

\`\`\`dart
final result = await nav.reverseGeocode(48.8584, 2.2945);
print(result.displayName);  // "Tour Eiffel, Avenue Anatole France, ..."
\`\`\`
</section>

---

<section id="autocomplete">
## 🔎 Autocomplete

\`\`\`dart
final suggestions = await nav.autocomplete('Par', limit: 5);

for (final s in suggestions) {
  print('\${s.name} — \${s.city}, \${s.country}');
}
\`\`\`
</section>

---

<section id="routing">
## 🧭 Routing

\`\`\`dart
final route = await nav.route(
  origin: MhjMapsLatLng(lat: 48.8566, lng: 2.3522),
  destination: MhjMapsLatLng(lat: 45.7640, lng: 4.8357),
  costing: 'auto',  // 'auto', 'bicycle', 'pedestrian'
);

print(route.durationText);   // "4 hrs 32 mins"
print(route.distanceText);   // "465.2 km"
</section>
`;

const init = async () => {
  const contentDiv = document.getElementById('markdown-content');
  if (contentDiv) {
    try {
      // Marked 17+ usage
      const html = await marked.parse(markdownRaw);
      contentDiv.innerHTML = html;
      console.log('Markdown successfully rendered.');
    } catch (e) {
      console.error('Failed to render Markdown:', e);
      contentDiv.innerHTML = '<div class="error">Failed to load content.</div>';
    }
  }

  // Smooth Scroll to Sections
  document.querySelectorAll('.nav-links a').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href.startsWith('#')) {
        e.preventDefault();
        const targetId = href.slice(1);
        const targetElement = document.getElementById(targetId);
        
        if (targetElement) {
          window.scrollTo({
            top: targetElement.offsetTop - 120,
            behavior: 'smooth'
          });
          
          document.querySelectorAll('.nav-links a').forEach(a => a.classList.remove('active'));
          this.classList.add('active');
        }
      }
    });
  });
};

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', init);
} else {
  init();
}
