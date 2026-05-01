import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsMulti extends StatefulWidget {
  const PageMapsMulti({super.key});

  @override
  State<PageMapsMulti> createState() => _PageMapsMultiState();
}

class _PageMapsMultiState extends State<PageMapsMulti> {

  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();

    _markers.addAll([
      const Marker(
        markerId: MarkerId("PNP"),
        position: LatLng(-0.9145679, 100.4635761),
        infoWindow: InfoWindow(title: "Politeknik Negeri Padang"),
      ),
      const Marker(
        markerId: MarkerId("UNAND"),
        position: LatLng(-0.9143, 100.4590),
        infoWindow: InfoWindow(title: "Universitas Andalas"),
      ),
      const Marker(
        markerId: MarkerId("UNP"),
        position: LatLng(-0.8900, 100.3530),
        infoWindow: InfoWindow(title: "Universitas Negeri Padang"),
      ),
      const Marker(
        markerId: MarkerId("Sitinjau"),
        position: LatLng(-0.9328453527423642, 100.53391348004837),
        infoWindow: InfoWindow(title: "Sitinjau Lauik"),
      ),
    ]);
  }

  void _changeMapType(MapType type) {
    setState(() {
      _currentMapType = type;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Map Type'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(
        children: [

          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-0.9123423046681882, 100.46566949469042),
              zoom: 15,
            ),
            mapType: _currentMapType,
            markers: _markers,
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildMapButton("Normal", MapType.normal),
                    _buildMapButton("Satellite", MapType.satellite),
                    _buildMapButton("Hybrid", MapType.hybrid),
                    _buildMapButton("Terrain", MapType.terrain),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(String label, MapType type) {
    bool isActive = _currentMapType == type;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        width: 110,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? Colors.blue : Colors.white,
            foregroundColor: isActive ? Colors.white : Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          onPressed: () {
            _changeMapType(type);
          },
          child: Text(label),
        ),
      ),
    );
  }
}