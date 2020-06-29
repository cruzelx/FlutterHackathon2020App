import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class EventLocationMapScreen extends StatefulWidget {
  @override
  _EventLocationMapScreenState createState() => _EventLocationMapScreenState();
}

class _EventLocationMapScreenState extends State<EventLocationMapScreen> {
  Completer<GoogleMapController> _mapController = Completer();

  final Set<Marker> _eventMarkers = new Set();
  LatLng _lastMapPosition;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController.complete(controller);
    });
  }

  _onCameraMove(CameraPosition position) {
    setState(() {
      _lastMapPosition = position.target;
    });
  }

  Position _position;
  StreamSubscription<Position> _positionStream;

  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
  }

  void initializer() async {
    const locationOptions = const LocationOptions(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionStream = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
        _lastMapPosition = LatLng(_position.latitude, _position.longitude);
      });
    });

    _eventMarkers.add(Marker(
        markerId: MarkerId("${DateTime.now()}_marker"),
        position: LatLng(_position.latitude, _position.longitude),
        infoWindow: InfoWindow(title: "Event Name")));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventMarkers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            _eventMarkers.add(Marker(
                markerId: MarkerId("${DateTime.now()}_marker"),
                position: _lastMapPosition,
                infoWindow: InfoWindow(title: "Event Name")));
            Navigator.pop(context,
                [_lastMapPosition.latitude, _lastMapPosition.longitude]);
          },
          label: Text("Set Location"),
          icon: Icon(Icons.location_on),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: <Widget>[
            GoogleMap(
                markers: _eventMarkers,
                mapType: _currentMapType,
                onMapCreated: _onMapCreated,
                onCameraMove: _onCameraMove,
                initialCameraPosition: CameraPosition(
                    target: LatLng(_position?.latitude ?? 27.714274,
                        _position?.longitude ?? 85.293339),
                    zoom: 15.0)),
            Positioned(
              child: Icon(Icons.location_on),
              left: MediaQuery.of(context).size.width * 0.50 - 11,
              top: MediaQuery.of(context).size.height * 0.50 - 35,
            ),
          ],
        ),
      ),
    );
  }
}
