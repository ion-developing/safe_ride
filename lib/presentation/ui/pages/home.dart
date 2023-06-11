import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../templates.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static String id = 'home';
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<Marker> _markers = {};
  static late CameraPosition cameraPosition;

  @override
  initState() {
    super.initState();
    setCameraPosition();
  }

  Future<void> setCameraPosition() async {
    Position position = await getCurrentLocation();
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      startController.text = "${position.latitude}, ${position.longitude}";
    });
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission is denied forever, we cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Widget startTextField = Templates.locationFiled(
        startController,
        "Current Location",
        CupertinoIcons.location_fill,
        TextInputType.streetAddress);
    Widget destinationTextField = Templates.locationFiled(
        destinationController,
        "Destination",
        CupertinoIcons.star_circle_fill,
        TextInputType.streetAddress);

    return Scaffold(
      backgroundColor: Templates.whiteColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
              onTap: (latlang) {
                if (_markers.isNotEmpty) {
                  _markers.clear();
                }
                setState(() {
                  _markers.add(Marker(
                    markerId: MarkerId(latlang.toString()),
                    position: latlang,
                    icon: BitmapDescriptor.defaultMarker,
                  ));
                  destinationController.text =
                      "${latlang.latitude}, ${latlang.longitude}";
                });
              },
            ),
            // child: Container(color: Colors.red,),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.1,
              maxChildSize: 0.75,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Templates.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Templates.lightGreyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Templates.spaceBoxH,
                          Column(
                            children: [
                              const Text('Where?', style: Templates.subtitle),
                              Templates.spaceBoxH,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: Templates.lightGreyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          startTextField,
                                          Templates.spaceBoxNH(10),
                                          destinationTextField,
                                        ],
                                      ),
                                    ),
                                    Templates.spaceBoxW,
                                    IconButton(
                                        icon: const Icon(
                                          CupertinoIcons.arrow_2_squarepath,
                                          color: Templates.darkGreyColor,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          final temp = startController.text;
                                          startController.text =
                                              destinationController.text;
                                          destinationController.text = temp;
                                        }),
                                  ],
                                ),
                              ),
                              Templates.spaceBoxH,
                              Templates.elevatedButton("Search Route", () {}),
                              Templates.spaceBoxH,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Templates.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Templates.lightGreyColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('23 min',
                                            style: Templates.subtitle),
                                        Text('Best Route',
                                            style: Templates.goodLabel),
                                      ],
                                    ),
                                    Templates.spaceBoxNH(8),
                                    const Text(
                                      'Lorem ipsum dolor - sit amet, consectetur adipiscing elit',
                                      style: Templates.body,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Templates.spaceBoxNH(8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Templates.selectButton(
                                            "Choose", () => {}),
                                      ],
                                    ),
                                    Templates.spaceBoxNH(8),
                                    Row(
                                      children: [
                                        Templates.routeTag(
                                            "Bikeway", Icons.directions_bike),
                                        Templates.spaceBoxW,
                                        Templates.routeTag(
                                            "shared path", CupertinoIcons.car),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Templates.spaceBoxH,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Templates.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Templates.lightGreyColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('30 min',
                                            style: Templates.subtitle),
                                        Text('Slower Route',
                                            style: Templates.badLabel),
                                      ],
                                    ),
                                    Templates.spaceBoxNH(8),
                                    const Text(
                                      'Lorem ipsum dolor - sit amet, consectetur adipiscing elit',
                                      style: Templates.body,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Templates.spaceBoxNH(8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Templates.selectButton(
                                            "Choose", () => {}),
                                      ],
                                    ),
                                    Templates.spaceBoxNH(8),
                                    Row(
                                      children: [
                                        Templates.routeTag(
                                            "Bikeway", Icons.directions_bike),
                                        Templates.spaceBoxW,
                                        Templates.routeTag(
                                            "shared path", CupertinoIcons.car),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
        ]),
      ),
    );
  }
}