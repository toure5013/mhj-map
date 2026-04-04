import './style.css'
import { createIcons, Github, Search, Menu, ExternalLink } from 'lucide'
import { marked } from 'marked'

// Initialize Icons
createIcons({
  icons: {
    Github,
    Search,
    Menu,
    ExternalLink
  }
})

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
| 🎨 **13 Built-in Themes** | Dark, light, satellite, topo, cycling, minimal, and more |
| 🔌 **13 Tile Providers** | OSM, CartoDB, Esri, OpenTopo, CyclOSM, HOT and others |
| 🧭 **Routing** | Turn-by-turn routing via Valhalla (auto, bicycle, pedestrian) |
| 📍 **Geocoding** | Forward & reverse geocoding via Nominatim |
| 🔎 **Autocomplete** | Address suggestions via Photon |
| 📐 **Custom Markers** | Add any Flutter widget as a map marker |
| 🟢 **Circle Overlays** | Radius visualization on the map |
| 🎯 **Tap Events** | \`onTap\`, \`onLongPress\`, \`onCameraMove\` callbacks |
| 🔄 **Camera Control** | Zoom, rotate, fit bounds, move programmatically |
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

Choose from **13 built-in themes** with a single parameter:

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

MhjMaps ships with **13 ready-to-use themes**. Switch themes at runtime with zero configuration:

### Light Themes

| Theme | Description |
|---|---|
| \`MhjMapsMapThemes.standard\` | Classic OpenStreetMap look |
| \`MhjMapsMapThemes.cleanLight\` | Minimalist CartoDB Positron |
| \`MhjMapsMapThemes.voyager\` | Colorful, detailed — ideal for nav apps |
| \`MhjMapsMapThemes.blankCanvas\` | No labels — perfect for custom overlays |
| \`MhjMapsMapThemes.professional\` | Esri World Street — professional cartography |
| \`MhjMapsMapThemes.whisper\` | Ultra-minimal gray basemap |

### Dark Themes

| Theme | Description |
|---|---|
| \`MhjMapsMapThemes.darkElegant\` | Premium dark basemap (CartoDB Dark Matter) |
| \`MhjMapsMapThemes.darkSilent\` | Dark, no labels — sleek and minimal |
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

// Render Markdown
const contentDiv = document.getElementById('markdown-content');
contentDiv.innerHTML = marked.parse(markdownRaw);

// Smooth Scroll to Sections
document.querySelectorAll('.nav-links a').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const targetId = this.getAttribute('href').slice(1);
    const targetElement = document.getElementById(targetId);
    
    if (targetElement) {
      window.scrollTo({
        top: targetElement.offsetTop - 120,
        behavior: 'smooth'
      });
      
      // Update active link
      document.querySelectorAll('.nav-links a').forEach(a => a.classList.remove('active'));
      this.classList.add('active');
    }
  });
});
