import 'dart:async';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
// ignore: depend_on_referenced_packages
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/utils/google_search/place_type.dart';
import 'package:search_map_location/widget/search_widget.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final registerC = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => registerC.isLoadingMaps.isTrue
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(registerC.locationMessage),
                  ElevatedButton(
                      onPressed: () async {
                        await registerC.getCurrentLocation().then((value) {
                          registerC.lat.value = value.latitude;
                          registerC.long.value = value.longitude;
                        });
                        await registerC.getUserLocation();
                        // Get.to(const MapSample());
                        // _getCurrentLocation().then((value) {
                        //   lat = value.latitude;
                        //   long = value.longitude;
                        // });
                        // setState(() {
                        //   locationMessage = "Latitude: $lat, Longitude: $long";
                        // });
                        // _liveLocation();
                      },
                      child: const Text('OPEN MAPS')),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await registerC.getCurrentLocation().then((value) {
                          registerC.lat.value = value.latitude;
                          registerC.long.value = value.longitude;
                        });
                        await registerC.getUserLocation();
                        Get.to(() => MapSample(
                              lat: registerC.lat.value,
                              long: registerC.long.value,
                            ));
                      },
                      child: const Text('Open Map')),
                  Obx(() => Text(
                      "${registerC.city.value} , ${registerC.kabupaten.value}")),
                ],
              ),
            ),
    ));
  }
}

// ignore: must_be_immutable
class AudioPlayUhuy extends StatelessWidget {
  AudioPlayUhuy({super.key});
  String url = 'assets/COMTelph_Phone ring 5 (ID 0375)_BSB.wav';
  bool isPlaying = false;
  final aud = AudioPlayer();
  final assetsAudioPlayer = AssetsAudioPlayer();

  void star(String url) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('audio Play'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('play'),
          onPressed: () async {
            await assetsAudioPlayer.open(Audio(url));
            assetsAudioPlayer.play();

// aud.play(url);

            // if (isPlaying) {
            //   String url = 'assets/COMTelph_Phone ring 5 (ID 0375)_BSB.wav';
            //   //  await audio.play();

            // }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MapSample extends StatefulWidget {
  MapSample({
    Key? key,
    required this.lat,
    required this.long,
  }) : super(key: key);

  double lat;
  double long;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // ignore: unused_field
  Position? _currentPosition;
  final registerC = Get.put(RegisterController());

  @override
  void initState() {
    widget.lat;
    // ignore: todo
    // TODO: implement initState
    super.initState();
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
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                // ignore: prefer_collection_literals
                markers: [
                  Marker(
                    markerId: const MarkerId("1"),
                    position:
                    registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),
                    //  LatLng(registerC.lat.value, registerC.long.value),
                    // position: LatLng(-6.5693770, 106.6710462),
                    draggable: true,
                    onDragEnd: (e) async {
                      List<Placemark> city = await placemarkFromCoordinates(
                          e.latitude, e.longitude);
                      Placemark placemark = city[0];
                      registerC.city.value = placemark.subAdministrativeArea!;
                      registerC.kabupaten.value = placemark.administrativeArea!;
                      registerC.lat.value = e.latitude;
                      registerC.long.value = e.longitude;
                       registerC.cityHospital.value = placemark.subAdministrativeArea!;
                      registerC.kabupatenHospital.value = placemark.administrativeArea!;
                      registerC.latHospital.value = e.latitude;
                      registerC.longHospital.value = e.longitude;
                    },
                  ),
                  Marker(
                    markerId: const MarkerId("2"),
                    position:registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),
                    // position: LatLng(-6.5693770, 106.6710462),
                    draggable: true,
                    onDragEnd: (e) async {
                      List<Placemark> city = await placemarkFromCoordinates(
                          e.latitude, e.longitude);
                      Placemark placemark = city[0];
                      registerC.city.value = placemark.subAdministrativeArea!;
                      registerC.kabupaten.value = placemark.administrativeArea!;
                      registerC.lat.value = e.latitude;
                      registerC.long.value = e.longitude;
                      registerC.cityHospital.value = placemark.subAdministrativeArea!;
                      registerC.kabupatenHospital.value = placemark.administrativeArea!;
                      registerC.latHospital.value = e.latitude;
                      registerC.longHospital.value = e.longitude;

                      // ignore: avoid_print
                      print(e.toJson());
                    },
                  ),
                ].toSet(),
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target:registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),
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
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: SearchLocation(
              // country: "ID",
              country: "ID",
              language: "id",
              hasClearButton: true,
              placeType: PlaceType.address,
              placeholder: "Masukkan Nama Kota Terlebih Dahulu",
              apiKey: "AIzaSyDFEfnWAt9nwFFb8fJXy3USgo94KgnTLSo",
              onSelected: (Place place) async {
                // ignore: prefer_collection_literals, unnecessary_new, unused_local_variable
                final Set<Marker> markers = new Set();
                final geolocation = await place.geolocation;
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(
                        geolocation!.fullJSON['geometry']['bounds']['northeast']
                            ['lat'],
                        geolocation.fullJSON['geometry']['bounds']['northeast']
                            ['lng']),
                  ),
                );
                if(registerC.isHospital.isFalse){

                registerC.lat.value = geolocation.fullJSON['geometry']['bounds']
                    ['northeast']['lat'];
                registerC.long.value = geolocation.fullJSON['geometry']
                    ['bounds']['northeast']['lng'];
                }else{
                  registerC.latHospital.value = geolocation.fullJSON['geometry']['bounds']
                    ['northeast']['lat'];
                registerC.longHospital.value = geolocation.fullJSON['geometry']
                    ['bounds']['northeast']['lng'];
                }
               await registerC.getUserLocationSearch();
               await registerC.getUserLocation();



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
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 70),
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
                                  style:
                                      blackTextStyle.copyWith(fontWeight: bold),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: 
                                  registerC.city.isEmpty ?   AutoSizeText(
                                    '${registerC.cityHospital}, ${registerC.kabupatenHospital}',
                                    maxLines: 1,
                                  ) :
                                  AutoSizeText(
                                    '${registerC.city}, ${registerC.kabupaten}',
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
                              registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),));
                            await registerC.getUserLocation();
                            // registerC.getUserLocationSearch();
                            Get.back();
                            // ignore: prefer_interpolation_to_compose_strings
                            log('lat lat' + registerC.lat.toString() +" " +  registerC.long.toString());
                          },
                          child: const Text('Pilih Lokasi'))
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      final GoogleMapController controller =
                          await _controller.future;
                      controller.animateCamera(CameraUpdate.newLatLng(registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),));
                      controller.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              // bearing: 192.8334901395799,
                              target: registerC.city.isNotEmpty ?
                     LatLng(registerC.lat.value, registerC.long.value) :
                     LatLng(registerC.latHospital.value, registerC.longHospital.value),
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
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.map),
      //   onPressed: () async {
      //     final GoogleMapController controller = await _controller.future;
      // controller.animateCamera(CameraUpdate.newLatLng(
      //     LatLng(registerC.lat.value, registerC.long.value)));
      // registerC.getUserLocation();
      //     // Get.back();
      //     print("useeee" + registerC.lat.toString());
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
