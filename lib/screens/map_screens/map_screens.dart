import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laws/constants/constants.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
    permissionServices();

  }


  permissionServices() async {
    await Permission.location.request().then((value) async {
      if (value.isPermanentlyDenied) {
      } else if (value.isDenied) {
        permissionServices();
      } else {
         GoogleMapController controller = await _controller.future;
        Position p = await getUserCurrentLocation();
        _kGooglePlex = CameraPosition(
          target: LatLng(p.latitude, p.longitude),
          zoom: 14.4746,
        );
         controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
        setState(() {});

      }
    });
    // mbSheet();
  }

  Future<Position> getUserCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              mapToolbarEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.15,

            builder: (BuildContext context, ScrollController scrollController) {

              return Container(
                decoration: BoxDecoration(
                    color: kAppBrown,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    )
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.blue,
      //   onPressed: () async {
      //     getUserCurrentLocation().then((value) async {
      //       permissionServices();
      //     });
      //   },
      //   child: const Icon(Icons.my_location),
      // ),
    );
  }
}
