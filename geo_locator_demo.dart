import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocatorDemo extends StatefulWidget {
  const GeolocatorDemo({Key? key}) : super(key: key);

  @override
  _GeolocatorDemoState createState() => _GeolocatorDemoState();
}

class _GeolocatorDemoState extends State<GeolocatorDemo> {
  //
  TextEditingController searchController = TextEditingController();
  LatLng initialLatLng = LatLng(20.5937, 78.9629);
  late GoogleMapController mapController;
  Marker? marker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Here',
          ),
        ),
        //
        actions: [
          IconButton(
            onPressed: () {
              showPosition();
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      //
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLatLng,
          zoom: 5,
        ),

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },

        //
        markers: {
          if (marker != null) marker!,
        },
      ),
    );
  }

  Future<void> showPosition() async {
    if (searchController.text.isNotEmpty) {
      List<Location> locations =
          await locationFromAddress(searchController.text);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              locations[0].latitude,
              locations[0].longitude,
            ),
            zoom: 15,
          ),
        ),
      );

      if (locations.length > 0) {
        marker = Marker(
          markerId: MarkerId('Search'),
          position: LatLng(
            locations[0].latitude,
            locations[0].longitude,
          ),
        );

        setState(() {
          //
        });
      }
    }
  }
}
