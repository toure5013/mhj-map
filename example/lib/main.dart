import 'package:flutter/material.dart';
import 'package:navigatr/navigatr.dart';

void main() {
  runApp(const NavigatrExample());
}

class NavigatrExample extends StatelessWidget {
  const NavigatrExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigatr Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        primaryColor: const Color(0xFF00FF94),
        useMaterial3: true,
      ),
      home: const RouteDemoScreen(),
    );
  }
}

class RouteDemoScreen extends StatefulWidget {
  const RouteDemoScreen({super.key});

  @override
  State<RouteDemoScreen> createState() => _RouteDemoScreenState();
}

class _RouteDemoScreenState extends State<RouteDemoScreen> {
  final Navigatr nav = Navigatr();
  NavigatrMapController? _mapController;
  
  final TextEditingController _originController = TextEditingController(text: 'Accra Mall, Ghana');
  final TextEditingController _destController = TextEditingController(text: 'Kotoka Airport, Ghana');
  
  RouteResult? _currentRoute;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Auto-load route on start
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateRoute());
  }

  Future<void> _calculateRoute() async {
    setState(() => _isLoading = true);
    
    try {
      final originRes = await nav.geocode(_originController.text);
      final destRes = await nav.geocode(_destController.text);
      
      final origin = NavigatrLatLng(lat: originRes.lat, lng: originRes.lng);
      final dest = NavigatrLatLng(lat: destRes.lat, lng: destRes.lng);
      
      final result = await nav.route(origin: origin, destination: dest);
      
      setState(() {
        _currentRoute = result;
        _isLoading = false;
      });

      if (_mapController != null) {
        _mapController!.clearMarkers();
        _mapController!.clearRoute();
        
        _mapController!.addMarker(
          position: origin,
          label: 'Origin',
          icon: const Icon(Icons.my_location, color: Color(0xFF00FF94), size: 30),
        );
        _mapController!.addMarker(
          position: dest,
          label: 'Destination',
          icon: const Icon(Icons.location_on, color: Colors.orangeAccent, size: 30),
        );
        
        _mapController!.drawRoute(result.polyline);
        _mapController!.fitRoute(result.polyline);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigatr SDK Demo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          NavigatrMap(
            center: const NavigatrLatLng(lat: 5.6037, lng: -0.1870),
            zoom: 13,
            onMapCreated: (controller) => _mapController = controller,
          ),
          
          // UI Panel
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E26).withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _originController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.circle, size: 12, color: Color(0xFF00FF94)),
                      hintText: 'Origin',
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _destController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on, size: 16, color: Colors.orangeAccent),
                      hintText: 'Destination',
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _calculateRoute,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF94),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                        : const Text('Get Route', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  
                  if (_currentRoute != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Duration', _currentRoute!.durationText),
                        _buildStat('Distance', _currentRoute!.distanceText),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }
}
