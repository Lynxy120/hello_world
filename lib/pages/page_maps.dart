import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world/pages/page_maps_dua.dart';
import 'package:hello_world/pages/page_maps_hybrid.dart';
import 'package:hello_world/pages/page_maps_multi.dart';
import 'package:hello_world/pages/page_maps_terrain.dart';

class PageMaps extends StatelessWidget {
  const PageMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Maps'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-0.9123423046681882, 100.46566949469042),
          zoom: 17,
        ),
      ),
    );
  }
}

class PageMainMaps extends StatelessWidget {
  const PageMainMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Main Maps'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsDua()),
                );
              },
              child: Text('Maps Satellite'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMaps()),
                );
              },
              child: Text('Maps Normal'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsHybrid()),
                );
              },
              child: Text('Maps Hybrid'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsTerrain()),
                );
              },
              child: Text('Maps Terrain'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMapsMulti()),
                );
              },
              child: Text('Maps Multi Marker'),
            ),
          ],
        ),
      ),
    );
  }
}
