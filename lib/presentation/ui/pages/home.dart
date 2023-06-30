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
  late GoogleMapController _controller;
  late Marker _origin;
  late Marker _destination;
  Set<Marker> _markers = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static late CameraPosition cameraPosition;
  late List<LatLng> cords = [];

  bool _loading = true;
  bool _editOriginMarker = false;
  bool _editDestinationMarker = false;

  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  initState() {
    setCameraPosition();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> setCameraPosition() async {
    setState(() {
      _loading = true;
    });
    Position position = await getCurrentLocation();
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
      );
      _markers.add(_origin);
      startController.text = "${position.latitude}, ${position.longitude}";
      _loading = false;
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

  setOriginMarker() {
    setState(() {
      _editDestinationMarker = false;
      _editOriginMarker = true;
    });
  }

  setDestinationMarker() {
    _editDestinationMarker = true;
    _editOriginMarker = false;
  }

  @override
  Widget build(BuildContext context) {
    // marker fields
    Widget startTextField = Templates.locationFiled(
        startController,
        "Current Location",
        CupertinoIcons.star_circle_fill,
        TextInputType.streetAddress,
        setOriginMarker);
    Widget destinationTextField = Templates.locationFiled(
        destinationController,
        "Destination",
        CupertinoIcons.location_fill,
        TextInputType.streetAddress,
        setDestinationMarker);

    return _loading
        ? Container(
      color: Templates.greyColor,
    )
        : Scaffold(
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
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              initialCameraPosition: cameraPosition,
              onMapCreated: (controller) {
                _controller = controller;
              },
              onTap: (data) {
                if (_editOriginMarker) {
                  setState(() {
                    _origin = Marker(
                      markerId: const MarkerId('origin'),
                      infoWindow: const InfoWindow(title: 'Origin'),
                      position: data,
                      icon: BitmapDescriptor.defaultMarker,
                    );
                    _markers.add(_origin);
                    startController.text =
                    "${data.latitude}, ${data.longitude}";
                  });
                } else if (_editDestinationMarker) {
                  setState(() {
                    _destination = Marker(
                      markerId: const MarkerId('destination'),
                      infoWindow: const InfoWindow(title: 'Destination'),
                      position: data,
                      icon: BitmapDescriptor.defaultMarkerWithHue(200),
                    );
                    _markers.add(_destination);
                    destinationController.text =
                    "${data.latitude}, ${data.longitude}";
                  });
                } else {
                  setState(() {
                    _editDestinationMarker = false;
                    _editOriginMarker = false;
                  });
                }
              },
              markers: _markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.red,
                  width: 5,
                  points: cords,
                ),
              },
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.1,
              maxChildSize: 0.8,
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
                              const Text('Where?',
                                  style: Templates.subtitle),
                              Templates.spaceBoxH,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                height:
                                MediaQuery.of(context).size.height *
                                    0.2,
                                decoration: BoxDecoration(
                                  color: Templates.lightGreyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
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
                                          CupertinoIcons
                                              .arrow_2_squarepath,
                                          color: Templates.darkGreyColor,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          if (startController
                                              .text.isNotEmpty &&
                                              destinationController
                                                  .text.isNotEmpty) {
                                            final tempText =
                                                startController.text;
                                            startController.text =
                                                destinationController
                                                    .text;
                                            destinationController.text =
                                                tempText;
                                            setState(() {
                                              final tempOrigin = _origin;
                                              _origin = Marker(
                                                markerId: const MarkerId(
                                                    'origin'),
                                                infoWindow:
                                                const InfoWindow(
                                                    title: 'Origin'),
                                                position:
                                                _destination.position,
                                                icon: BitmapDescriptor
                                                    .defaultMarker,
                                              );
                                              _destination = Marker(
                                                markerId: const MarkerId(
                                                    'destination'),
                                                infoWindow:
                                                const InfoWindow(
                                                    title:
                                                    'Destination'),
                                                position:
                                                tempOrigin.position,
                                                icon: BitmapDescriptor
                                                    .defaultMarkerWithHue(
                                                    200),
                                              );
                                              _markers = {
                                                _origin,
                                                _destination
                                              };
                                            });
                                          }
                                          return;
                                        }),
                                  ],
                                ),
                              ),
                              Templates.spaceBoxH,
                              Templates.elevatedButton(
                                  "Search Route", () {}),
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
                                        Templates.routeTag("Bikeway",
                                            Icons.directions_bike),
                                        Templates.spaceBoxW,
                                        Templates.routeTag("shared path",
                                            CupertinoIcons.car),
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
                                        Templates.routeTag("Bikeway",
                                            Icons.directions_bike),
                                        Templates.spaceBoxW,
                                        Templates.routeTag("shared path",
                                            CupertinoIcons.car),
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
