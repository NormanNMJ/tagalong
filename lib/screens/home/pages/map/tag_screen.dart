// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../constants/api_keys.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng sourceLocation =
      LatLng(4.9525, 7.0001); // Eneka, Port Harcourt
  static const LatLng destinationLocation =
      LatLng(4.9186, 7.0025); // Another location in Port Harcourt

  final Location _locationController = Location();
  LatLng? _currentP;

  Map<PolylineId, Polyline> polylines = {};

  BitmapDescriptor yourLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor friendLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/mee.png")
        .then(
      (icon) {
        yourLocationIcon = icon;
      },
    );
      BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/tag.png")
        .then(
      (icon) {
        friendLocationIcon = icon;
      },
    );
      BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/flag.png")
        .then(
      (icon) {
        destinationLocationIcon = icon;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
    getLocationUpdate().then(
      (_) => {
        getPolylinePoints().then(
          (coordinates) => {generatePolylineFromPoints(coordinates)},
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text('Loading ...'),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: const CameraPosition(
                  target: sourceLocation, zoom: 30, tilt: 30 ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(23),
                  position: _currentP!,
                ),
                 Marker(
                  markerId: const MarkerId("friendLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(120),
                  position: sourceLocation,
                ),
                 Marker(
                  markerId: const MarkerId("destinationLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(230),
                  position: destinationLocation,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: pos, zoom: 30, tilt: 30);

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            _currentP =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            _cameraToPosition(_currentP!);
          });
        }
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiMapKey,
      PointLatLng(
        sourceLocation.latitude,
        sourceLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    } else {}
    return polylineCoordinates;
  }

  generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.green,
      points: polylineCoordinates,
      width: 8,
    );

    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
