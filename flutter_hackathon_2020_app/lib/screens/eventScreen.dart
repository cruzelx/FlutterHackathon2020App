import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  static const LatLng _center = const LatLng(27.7201322, 85.289965);
  final Set<Marker> _eventMarkers = new Set();
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventMarkers.add(Marker(
      markerId: MarkerId("${DateTime.now() }_marker"),
      position: _center,
      infoWindow: InfoWindow(title: "Event Name")
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xfff0f0f0),
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: Icon(Icons.arrow_back),
                    pinned: true,
                    title: Text("Bagmati Cleaning Programme"),
                    expandedHeight: MediaQuery.of(context).size.height * 0.30,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: <Widget>[
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.unitednow.com/media/homepage/art.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.black.withOpacity(0.15),
                                  Colors.black.withOpacity(0.4)
                                ])),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 60.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Category Name",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {},
                              child: Text("+ Join the team",
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.redAccent,
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.event),
                                    SizedBox(width: 8.0),
                                    Text(
                                      DateFormat("yMMMMd")
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Description",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                Divider(),
                                Text(
                                  "jhafjshf asjflasf alskjfhalskfjhlas fjlsafhlas fdhafkljsdfhlksdj gdlskjfhg ldskfj ghdsfg ksdfkjshdf skdjfhskjdf sjdgksjg ksdjfghskjsfhksjdf sjkfhskfhsjkd f",
                                  maxLines: 7,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Icon(Icons.people,
                                        color: Colors.white, size: 25.0),
                                    SizedBox(width: 8.0),
                                    Text("124 Volunteers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Spacer()
                                  ],
                                ))),
                        SizedBox(height: 15.0),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Contact Info",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.email),
                                      SizedBox(width: 8.0),
                                      Text("cruze.alex@gmail.com "),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.phone),
                                      SizedBox(width: 8.0),
                                      Text("9863696695")
                                    ],
                                  )
                                ],
                              ),
                            )),
                        SizedBox(height: 15.0),
                        Container(
                          width: double.infinity,
                          height: 300.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: GoogleMap(
                              markers: _eventMarkers,
                              mapType: _currentMapType,
                              onMapCreated: _onMapCreated,
                              onCameraMove: _onCameraMove,
                              initialCameraPosition:
                                  CameraPosition(target: _center, zoom: 15.0)),
                        )
                      ],
                    )),
              ),
            )));
  }
}
