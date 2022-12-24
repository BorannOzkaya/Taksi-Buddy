import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:taksibuddy/chat_page/chat_page.dart';

import '../constants.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late PageController _pageController;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static const LatLng sourceLocation = LatLng(40.2234, 28.8506);
  static const LatLng destinationLocation = LatLng(40.2326, 28.8390);

  LocationData? myCurrentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) => myCurrentLocation = location);

    location.onLocationChanged.listen((location) {
      myCurrentLocation = location;

      setState(() {});
    });
  }

  List<LatLng> polyLineCoordinates = [];

  GoogleMapController? _controller;
  // Location currentLocation = Location();
  Set<Marker> _markers = {};

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    setState(() {
      //getLocation();
      getPolyPoints();
      getCurrentLocation();
      super.initState();
    });
  }

  // void getLocation() async {
  //   var location = await currentLocation.getLocation();AIzaSyCfTIXxDwxLdWxVIwb8oq7Vuo2mILrcSlQ
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     _controller
  //         ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 15.0,
  //     )));
  //     setState(() {
  //       _markers.add(Marker(
  //           markerId: MarkerId('Home'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //     });
  //   });
  // }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCaSZvCJx91VRcsFldp_6XHZISSHtBB7Vs",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      SafeArea(
        child: Container(
          height: size.height * 0.771,
          child: myCurrentLocation == null
              ? const Center(
                  child: Text("Loading"),
                )
              : GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(myCurrentLocation!.latitude!,
                          myCurrentLocation!.longitude!),
                      zoom: 14.5),
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('route'),
                      points: polyLineCoordinates,
                      color: primaryColor,
                      width: 3,
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('Current Location'),
                      position: LatLng(myCurrentLocation!.latitude!,
                          myCurrentLocation!.longitude!),
                    ),
                    Marker(
                      markerId: MarkerId('Home'),
                      position: sourceLocation,
                    ),
                    Marker(
                      markerId: MarkerId('destination'),
                      position: destinationLocation,
                    )
                  },
                ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 520, left: 140),
        child: FloatingActionButton.extended(
          heroTag: "btn1",
          icon: Icon(Icons.location_on),
          backgroundColor: primaryColor.withOpacity(0.7),
          onPressed: () {
            print("object");
          },
          label: Text("Explore"),
        ),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 320, left: 5),
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.layers),
                  backgroundColor: primaryColor.withOpacity(0.7),
                  onPressed: () {
                    print("object");
                  },
                ),
                SizedBox(
                  height: 80,
                ),
                FloatingActionButton(
                  heroTag: "btn3",
                  tooltip: "Sohbet",
                  child: Icon(CupertinoIcons.chat_bubble),
                  backgroundColor: primaryColor.withOpacity(0.7),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChatPage(
                    //               email: 'weqe',
                    //             )));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 320, left: 270),
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn4",
                  child: Icon(Icons.keyboard_tab_outlined),
                  backgroundColor: primaryColor.withOpacity(0.7),
                  onPressed: () {
                    print("object");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: "btn5",
                  child: Icon(Icons.location_searching_outlined),
                  backgroundColor: primaryColor.withOpacity(0.7),
                  onPressed: () {
                    print("object");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: "btn6",
                  child: Icon(Icons.search),
                  backgroundColor: primaryColor.withOpacity(0.7),
                  onPressed: () {
                    print("object");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}

class Deneme extends StatelessWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
