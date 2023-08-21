import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/utils/google_search/place_type.dart';

import '../../../../../theme.dart';

class Maaapp extends StatefulWidget {
  const Maaapp({
    Key? key,
    // required this.lat,
    // required this.long,
  }) : super(key: key);

  // double lat;
  // double long;

  @override
  State<Maaapp> createState() => MaaappState();
}

class MaaappState extends State<Maaapp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // ignore: unused_field
  Position? _currentPosition;
  final mapC = Get.put(MapController());

  @override
  void initState() {
    getlokasi();
    // widget.lat;
    mapC.lat.value;
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void cameraLokasi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(mapC.lat.value, mapC.long.value)));
    mapC.getUserLocation();
  }

  void getlokasi() async {
    await mapC.getCurrentLocation().then((value) {
      mapC.lat.value = value.latitude;
      mapC.long.value = value.longitude;
      cameraLokasi();
    });
  }

  // ignore: unused_element
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  // ignore: unused_field
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // ignore: prefer_final_fields

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // ignore: prefer_final_fields

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 400,
          width: Get.width,
          child: Stack(
            children: [
              Obx(() => GoogleMap(
                    // ignore: prefer_collection_literals
                    markers: [
                      Marker(
                        markerId: const MarkerId("1"),
                        position:
                            LatLng(mapC.lat.value, mapC.long.value),
                        // position: LatLng(-6.5693770, 106.6710462),
                        draggable: true,
                        onDragEnd: (e) async {
                          List<Placemark> city = await placemarkFromCoordinates(
                              e.latitude, e.longitude);
                          Placemark placemark = city[0];
                          mapC.city.value =
                              placemark.subAdministrativeArea!;
                          mapC.kabupaten.value =
                              placemark.administrativeArea!;
                          mapC.lat.value = e.latitude;
                          mapC.long.value = e.longitude;
                        },
                      ),
                      Marker(
                        markerId: const MarkerId("2"),
                        position:
                            LatLng(mapC.lat.value, mapC.long.value),
                        // position: LatLng(-6.5693770, 106.6710462),
                        draggable: true,
                        onDragEnd: (e) async {
                          List<Placemark> city = await placemarkFromCoordinates(
                              e.latitude, e.longitude);
                          Placemark placemark = city[0];
                          mapC.city.value =
                              placemark.subAdministrativeArea!;
                          mapC.kabupaten.value =
                              placemark.administrativeArea!;
                          mapC.lat.value = e.latitude;
                          mapC.long.value = e.longitude;
                        },
                      ),
                    ].toSet(),
                    mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(mapC.lat.value, mapC.long.value),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      // setState(() {
                      //   mapController = controller;
                      // });
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: SearchLocation(
                  hasClearButton: true,
                  placeType: PlaceType.address,
                  placeholder: "Cari Lokasi",
                  apiKey: "AIzaSyDFEfnWAt9nwFFb8fJXy3USgo94KgnTLSo",
                  onSelected: (Place place) async {
                    // ignore: prefer_collection_literals, unnecessary_new, unused_local_variable
                    final Set<Marker> markers = new Set();
                    final geolocation = await place.geolocation;
                    final GoogleMapController controller =
                        await _controller.future;
                    controller.animateCamera(
                      CameraUpdate.newLatLng(
                        LatLng(
                            geolocation!.fullJSON['geometry']['bounds']
                                ['northeast']['lat'],
                            geolocation.fullJSON['geometry']['bounds']
                                ['northeast']['lng']),
                      ),
                    );

                    mapC.lat.value = geolocation.fullJSON['geometry']
                        ['bounds']['northeast']['lat'];
                    mapC.long.value = geolocation.fullJSON['geometry']
                        ['bounds']['northeast']['lng'];
                    mapC.getUserLocationSearch();


                    

                    // controller.animateCamera(
                    //     CameraUpdate.newLatLng(geolocation!.coordinates));
                    // // controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                    // controller.animateCamera(
                    //     CameraUpdate.newLatLng(geolocation.coordinates));
                    // print(geolocation!.fullJSON.toString());
                    // print("inin-==-=-=-=-  " + geolocation!.fullJSON['geometry']['bounds']['northeast']['lat'].toString());
                    // print("inin-==-=-=-=-  " + geolocation.fullJSON['geometry']['bounds']['northeast']['lng'].toString());
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 70),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            width: 200,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lokasi saat ini',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: AutoSizeText(
                                        '${mapC.city}, ${mapC.kabupaten}',
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final GoogleMapController controller =
                                    await _controller.future;
                                controller.animateCamera(CameraUpdate.newLatLng(
                                    LatLng(mapC.lat.value,
                                        mapC.long.value)));
                                mapC.getUserLocation();
                                // mapC.getUserLocationSearch();
                                Get.back();
                              },
                              child: const Text('Pilih Lokasi'))
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(CameraUpdate.newLatLng(
                              LatLng(
                                  mapC.lat.value, mapC.long.value)));
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  // bearing: 192.8334901395799,
                                  target: LatLng(mapC.lat.value,
                                      mapC.long.value),
                                  // tilt: 59.440717697143555,
                                  zoom: 19.151926040649414)));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: whiteColor,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('KOTA : ${mapC.city}'),
                Text('KABUPATEN : ${mapC.kabupaten}'),
                Text('LAT : ${mapC.lat}'),
                Text('LONG : ${mapC.long}'),
              ],
            ),
          ),
        )
      ],
    )
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.map),
        //   onPressed: () async {
        //     final GoogleMapController controller = await _controller.future;
        // controller.animateCamera(CameraUpdate.newLatLng(
        //     LatLng(mapC.lat.value, mapC.long.value)));
        // mapC.getUserLocation();
        //     // Get.back();
        //     print("useeee" + mapC.lat.toString());
        //   },
        //   // label: Text(''),
        //   // icon: const Icon(Icons.directions_boat),
        // ),
        );
  }

  // ignore: unused_element
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

//CONTROLLER
class MapController extends GetxController {
  //Maps
  RxString city = ''.obs;
  RxString kabupaten = ''.obs;
  RxString negara = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kodePos = ''.obs;
  RxString desa = ''.obs;

  // late double lat;
  // late double long;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  String locationMessage = "Current Location";
  RxBool isLoadingMaps = false.obs;
  RxDouble latMaps = 0.0.obs;
  RxDouble longMaps = 0.0.obs;

  getUserLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat.value, long.value);
    Placemark place = placemarks[0];
    city.value = place.subAdministrativeArea.toString();
    kabupaten.value = place.administrativeArea.toString();
    desa.value = place.subLocality.toString();
    negara.value = place.country.toString();
    kecamatan.value = place.locality.toString();
    kodePos.value = place.postalCode.toString();

  }

  getUserLocationSearch() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat.value, lat.value);
    Placemark place = placemarks[0];
    city.value = place.subAdministrativeArea.toString();
    kabupaten.value = place.administrativeArea.toString();
    desa.value = place.subLocality.toString();
    negara.value = place.country.toString();
    kecamatan.value = place.locality.toString();
    kodePos.value = place.postalCode.toString();
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }
    return await Geolocator.getCurrentPosition();
  }
}
