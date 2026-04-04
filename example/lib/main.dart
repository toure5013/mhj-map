import 'package:flutter/material.dart';
import 'package:navigatr/navigatr.dart';
import 'dart:ui';

void main() {
  runApp(const NavigatrExampleApp());
}

class NavigatrExampleApp extends StatelessWidget {
  const NavigatrExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigatr Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FF94),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const MapExampleScreen(),
    );
  }
}

class MapExampleScreen extends StatefulWidget {
  const MapExampleScreen({super.key});

  @override
  State<MapExampleScreen> createState() => _MapExampleScreenState();
}

class _MapExampleScreenState extends State<MapExampleScreen> {
  final Navigatr _navigatr = Navigatr();
  NavigatrMapController? _mapController;

  final TextEditingController _originController = TextEditingController(
    text: 'Paris, France',
  );
  final TextEditingController _destController = TextEditingController(
    text: 'Lyon, France',
  );

  AutocompleteResult? _selectedOrigin;
  AutocompleteResult? _selectedDestination;

  bool _isLoading = false;
  RouteResult? _routeResult;

  // ─── Map Customization ────────────────────────────────────────────
  NavigatrMapTheme _currentTheme = NavigatrMapThemes.standard;
  bool _showThemePicker = false;

  Future<void> _calculateRoute() async {
    setState(() => _isLoading = true);
    try {
      final NavigatrLatLng originCoords;
      if (_selectedOrigin != null &&
          _selectedOrigin!.displayName == _originController.text) {
        originCoords = NavigatrLatLng(
          lat: _selectedOrigin!.lat,
          lng: _selectedOrigin!.lng,
        );
      } else {
        final origin = await _navigatr.geocode(_originController.text);
        originCoords = NavigatrLatLng(lat: origin.lat, lng: origin.lng);
      }

      final NavigatrLatLng destCoords;
      if (_selectedDestination != null &&
          _selectedDestination!.displayName == _destController.text) {
        destCoords = NavigatrLatLng(
          lat: _selectedDestination!.lat,
          lng: _selectedDestination!.lng,
        );
      } else {
        final dest = await _navigatr.geocode(_destController.text);
        destCoords = NavigatrLatLng(lat: dest.lat, lng: dest.lng);
      }

      final result = await _navigatr.route(
        origin: originCoords,
        destination: destCoords,
      );

      setState(() {
        _routeResult = result;
        _isLoading = false;
      });

      if (_mapController != null) {
        _mapController!.clearAll();

        _mapController!.addMarker(
          position: originCoords,
          icon: _buildSmartMarker(Colors.blue, Icons.my_location),
        );
        _mapController!.addMarker(
          position: destCoords,
          icon: _buildSmartMarker(
            _parseHexColor(_currentTheme.markerColor),
            Icons.flag,
          ),
        );

        _mapController!.drawRoute(
          result.polyline,
          color: _parseHexColor(_currentTheme.polylineColor),
          width: 5.0,
          borderColor: Colors.black26,
          borderWidth: 1,
        );

        _mapController!.fitRoute(result.polyline);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Widget _buildSmartMarker(Color color, IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Color _parseHexColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  void _onThemeSelected(NavigatrMapTheme theme) {
    setState(() {
      _currentTheme = theme;
      _showThemePicker = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ─── The Map (with theme) ─────────────────────────────────
          NavigatrMap(
            key: ValueKey(_currentTheme.id),
            center: const NavigatrLatLng(lat: 48.8566, lng: 2.3522),
            zoom: 12,
            theme: _currentTheme,
            showZoomControls: true,
            onMapCreated: (controller) {
              _mapController = controller;
              // Redraw route if we had one
              if (_routeResult != null) {
                _calculateRoute();
              }
            },
            onTap: (position) {
              debugPrint('Map tapped: $position');
            },
          ),

          // ─── Search UI Overlay ────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildGlassContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSearchInput(
                          controller: _originController,
                          hint: 'Origin',
                          icon: Icons.my_location,
                          iconColor: Colors.blue,
                          onOptionSelected: (s) => _selectedOrigin = s,
                        ),
                        const Divider(height: 1, color: Colors.white24),
                        _buildSearchInput(
                          controller: _destController,
                          hint: 'Destination',
                          icon: Icons.location_on,
                          iconColor: const Color(0xFF00FF94),
                          onOptionSelected: (s) => _selectedDestination = s,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Theme Picker Button ──────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 120,
            right: 16,
            child: _buildGlassButton(
              icon: Icons.palette_outlined,
              onPressed: () =>
                  setState(() => _showThemePicker = !_showThemePicker),
            ),
          ),

          // ─── Theme Picker Panel ───────────────────────────────────
          if (_showThemePicker)
            Positioned(
              top: MediaQuery.of(context).padding.top + 170,
              right: 16,
              child: _buildThemePicker(),
            ),

          // ─── Current Theme Badge ──────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 120,
            left: 16,
            child: _buildGlassContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _parseHexColor(_currentTheme.polylineColor),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _currentTheme.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── Bottom Route Info ────────────────────────────────────
          if (_routeResult != null || _isLoading)
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: _buildGlassContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Estimated Travel',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _routeResult!.durationText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Distance',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _routeResult!.distanceText,
                                      style: TextStyle(
                                        color: _parseHexColor(
                                          _currentTheme.polylineColor,
                                        ),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _calculateRoute,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _parseHexColor(
                                    _currentTheme.polylineColor,
                                  ),
                                  foregroundColor:
                                      _currentTheme.isDark
                                          ? Colors.black
                                          : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'RECALCULATE ROUTE',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            )
          else
            Positioned(
              bottom: 40,
              right: 16,
              left: 16,
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _calculateRoute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _parseHexColor(
                      _currentTheme.polylineColor,
                    ),
                    foregroundColor:
                        _currentTheme.isDark ? Colors.black : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'GET DIRECTIONS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── UI Builders ──────────────────────────────────────────────────

  Widget _buildThemePicker() {
    return _buildGlassContainer(
      child: SizedBox(
        width: 220,
        height: 340,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: NavigatrMapThemes.all.length,
          itemBuilder: (context, index) {
            final theme = NavigatrMapThemes.all[index];
            final isSelected = theme.id == _currentTheme.id;

            return InkWell(
              onTap: () => _onThemeSelected(theme),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _parseHexColor(theme.polylineColor),
                        borderRadius: BorderRadius.circular(6),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                      child: theme.isDark
                          ? const Icon(
                              Icons.dark_mode,
                              color: Colors.white70,
                              size: 14,
                            )
                          : const Icon(
                              Icons.light_mode,
                              color: Colors.white70,
                              size: 14,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            theme.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                          Text(
                            theme.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: Colors.white, size: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSearchInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    void Function(AutocompleteResult)? onOptionSelected,
  }) {
    return Autocomplete<AutocompleteResult>(
      displayStringForOption: (AutocompleteResult option) =>
          option.displayName,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<AutocompleteResult>.empty();
        }
        return await _navigatr.autocomplete(textEditingValue.text);
      },
      onSelected: (AutocompleteResult selection) {
        controller.text = selection.displayName;
        onOptionSelected?.call(selection);
        _calculateRoute();
      },
      fieldViewBuilder:
          (context, fieldController, focusNode, onFieldSubmitted) {
        if (fieldController.text != controller.text) {
          fieldController.text = controller.text;
        }

        fieldController.addListener(() {
          if (controller.text != fieldController.text) {
            controller.text = fieldController.text;
          }
        });

        return TextField(
          controller: fieldController,
          focusNode: focusNode,
          onSubmitted: (value) => onFieldSubmitted(),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
            prefixIcon: Icon(icon, color: iconColor, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            suffixIcon: fieldController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white38,
                      size: 18,
                    ),
                    onPressed: () {
                      fieldController.clear();
                      controller.clear();
                    },
                  )
                : null,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A).withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.white10),
                    itemBuilder: (BuildContext context, int index) {
                      final AutocompleteResult option =
                          options.elementAt(index);
                      return ListTile(
                        leading: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white38,
                          size: 18,
                        ),
                        title: Text(
                          option.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          option.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                          ),
                        ),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
