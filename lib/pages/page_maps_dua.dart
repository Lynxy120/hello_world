import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMapsDua extends StatefulWidget {
  const PageMapsDua({super.key});

  @override
  State<PageMapsDua> createState() => _PageMapsDuaState();
}

class _PageMapsDuaState extends State<PageMapsDua> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId("Campus"),
        position: const LatLng(-0.9123423046681882, 100.46566949469042),
        infoWindow: const InfoWindow(title: "Kampus PNP"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-0.9123423046681882, 100.46566949469042),
        zoom: 15,
      ),
      mapType: MapType.satellite,
      markers: _markers,
    );
  }
}
