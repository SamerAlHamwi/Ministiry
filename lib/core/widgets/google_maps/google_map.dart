import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {

  final LatLng point;

  const GoogleMaps({Key? key, required this.point}) : super(key: key);
  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? kInitCameraPosition;
  LatLng? initialPoint;

  @override
  void initState() {
    if(widget.point == null) initialPoint =LatLng(0.0, 0.0);
    else initialPoint = widget.point;
    kInitCameraPosition = CameraPosition(

      target: initialPoint!,
      zoom: 15,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return buildGoogleMap();

  }

  buildGoogleMap() {
    return AspectRatio(
      aspectRatio: 300/300,
      child: GoogleMap(


        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        ].toSet(),


        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: true,
        compassEnabled: true,
        zoomGesturesEnabled: true,

        tiltGesturesEnabled: true,
        markers: [Marker( markerId: MarkerId('point'),position: initialPoint!)].toSet(),

        mapType: MapType.normal,
        initialCameraPosition: kInitCameraPosition!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }


}