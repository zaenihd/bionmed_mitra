import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ControllerMaps extends GetxController {
  RxString originLabel = "".obs;
  RxString originName = "".obs;
  RxString originPhone = "".obs;
  RxString originAddress = "Add Location".obs;
  RxString originKecamatan = "".obs;
  RxString originKelurahan = "".obs;
  RxString originKota = "".obs;
  RxString originProvinsi = "".obs;
  RxString originKodePos = "".obs;
  RxString originNegara = "".obs;
  RxString originEmailAddress = "".obs;
  RxDouble originLatitude = 0.0.obs;
  RxDouble originLongitude = 0.0.obs;
  RxBool isOrigin = false.obs;

  var latitude = 'Getting Latitude..'.obs;
  var longitude = 'Getting Longitude..'.obs;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription; 

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }


  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    // super.onClose();
    streamSubscription.cancel();
  }

  getLocation() async{
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Service are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissioin are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission error permanently.');
    }
    streamSubscription = Geolocator.getPositionStream().listen((Position position) {
      latitude.value = 'Latitude : ${position.latitude}';
      longitude.value = 'Longitude : ${position.longitude}';
      getAddressFromLatLang(position);
    });
    }

    Future<void>getAddressFromLatLang(Position position) async{
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      address.value = 'Address : ${place.locality}, ${place.country}';
    }
  }
