import 'package:flutter/material.dart';
import 'package:navigatr/navigatr.dart';
import 'dart:ui';

void main() {
  runApp(const NavigatrTestApp());
}

class NavigatrTestApp extends StatelessWidget {
  const NavigatrTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigatr Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FF94),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const TestMapScreen(),
    );
  }
}

class TestMapScreen extends StatefulWidget {
  const TestMapScreen({super.key});

  @override
  State<TestMapScreen> createState() => _TestMapScreenState();
}

class _TestMapScreenState extends State<TestMapScreen> {
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

  Future<void> _calculateRoute() async {
    setState(() => _isLoading = true);
    try {
      // 1. Get coordinates (use stored or geocode if manually typed)
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

      // 2. Get route
      final result = await _navigatr.route(
        origin: originCoords,
        destination: destCoords,
      );

      setState(() {
        _routeResult = result;
        _isLoading = false;
      });

      // 3. Update Map
      if (_mapController != null) {
        _mapController!.clearMarkers();
        _mapController!.clearRoute();

        _mapController!.addMarker(
          position: originCoords,
          icon: const Icon(Icons.location_on, color: Colors.blue, size: 40),
        );
        _mapController!.addMarker(
          position: destCoords,
          icon: const Icon(
            Icons.location_on,
            color: Color(0xFF00FF94),
            size: 40,
          ),
        );

        _mapController!.drawRoute(
          result.polyline,
          color: const Color(0xFF00FF94),
          width: 5.0,
        );

        _mapController!.fitRoute(result.polyline);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The Map
          NavigatrMap(
            center: const NavigatrLatLng(lat: 48.8566, lng: 2.3522), // Paris
            zoom: 12,
            onMapCreated: (controller) => _mapController = controller,
          ),

          // Search UI Overlay
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

          // Bottom Info Overlay
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
                                      style: const TextStyle(
                                        color: Color(0xFF00FF94),
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
                                  backgroundColor: const Color(0xFF00FF94),
                                  foregroundColor: Colors.black,
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
                    backgroundColor: const Color(0xFF00FF94),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'GET DIRECTIONS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
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
      displayStringForOption: (AutocompleteResult option) => option.displayName,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<AutocompleteResult>.empty();
        }
        return await _navigatr.autocomplete(textEditingValue.text);
      },
      onSelected: (AutocompleteResult selection) {
        controller.text = selection.displayName;
        if (onOptionSelected != null) {
          onOptionSelected(selection);
        }
        _calculateRoute();
      },
      fieldViewBuilder:
          (context, fieldController, focusNode, onFieldSubmitted) {
            // Link the provided controller with the fieldController
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
                      final AutocompleteResult option = options.elementAt(
                        index,
                      );
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
