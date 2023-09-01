import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class RegisterController extends GetxController {
  //Maps
  RxString city = ''.obs;
  RxString kabupaten = ''.obs;
  RxString negara = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kodePos = ''.obs;
  RxString desa = ''.obs;

  RxBool isHospital = false.obs;

  RxString cityHospital = ''.obs;
  RxString kabupatenHospital = ''.obs;
  RxString negaraHospital = ''.obs;
  RxString kecamatanHospital = ''.obs;
  RxString kodePosHospital = ''.obs;
  RxString desaHospital = ''.obs;

  // late double lat;
  // late double long;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxDouble latHospital = 0.0.obs;
  RxDouble longHospital = 0.0.obs;
  String locationMessage = "Current Location";
  RxBool isLoadingMaps = false.obs;
  RxDouble latMaps = 0.0.obs;
  RxDouble longMaps = 0.0.obs;

  getUserLocation() async {
    //  Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    isLoadingMaps(true);
    if (isHospital.isFalse) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat.value, long.value);
      Placemark place = placemarks[0];
      city.value = place.subAdministrativeArea.toString();
      kabupaten.value = place.administrativeArea.toString();
      desa.value = place.subLocality.toString();
      negara.value = place.country.toString();
      kecamatan.value = place.locality.toString();
      kodePos.value = place.postalCode.toString();
      log('user nih boss ==============');
      // lat.value = position.latitude;
      // long.value = position.longitude;
    } else {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latHospital.value, longHospital.value);
      Placemark place = placemarks[0];
      cityHospital.value = place.subAdministrativeArea.toString();
      kabupatenHospital.value = place.administrativeArea.toString();
      desaHospital.value = place.subLocality.toString();
      negaraHospital.value = place.country.toString();
      kecamatanHospital.value = place.locality.toString();
      kodePosHospital.value = place.postalCode.toString();
      log('hospital nih boss ==============');

      // latHospital.value = position.latitude;
      // longHospital.value = position.longitude;
    }
    isLoadingMaps(false);
  }

  getUserLocationSearch() async {
    //  Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);

    if (isHospital.isFalse) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat.value, lat.value);
      Placemark place = placemarks[0];
      city.value = place.subAdministrativeArea.toString();
      kabupaten.value = place.administrativeArea.toString();
      desa.value = place.subLocality.toString();
      negara.value = place.country.toString();
      kecamatan.value = place.locality.toString();
      kodePos.value = place.postalCode.toString();
      // lat.value = position.latitude;
      // long.value = position.longitude;
    } else {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latHospital.value, longHospital.value);
      Placemark place = placemarks[0];
      cityHospital.value = place.subAdministrativeArea.toString();
      kabupatenHospital.value = place.administrativeArea.toString();
      desaHospital.value = place.subLocality.toString();
      negaraHospital.value = place.country.toString();
      kecamatanHospital.value = place.locality.toString();
      kodePosHospital.value = place.postalCode.toString();
      // latHospital.value = position.latitude;
      // longHospital.value = position.longitude;
    }
  }

  Future<Position> getCurrentLocation() async {
    isLoadingMaps(true);

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
      isLoadingMaps(false);
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }
    return await Geolocator.getCurrentPosition();
  }
  // void _liveLocation() {
  //   LocationSettings locationSettings = const LocationSettings(
  //       accuracy: LocationAccuracy.high, distanceFilter: 100);

  //   Geolocator.getPositionStream(locationSettings: locationSettings)
  //       .listen((Position position) {
  //     lat = position.latitude;
  //     long = position.longitude;

  //     setState(() {
  //       locationMessage = "Latitude: $lat , Longitude: $long";
  //     });
  //   });
  // }

  //Register
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPengalaman = TextEditingController();
  final TextEditingController controllerNomerStr = TextEditingController();
  final TextEditingController controllerNomerSip = TextEditingController();
  final TextEditingController controllerKota = TextEditingController();
  final TextEditingController controllerAlamat = TextEditingController();

  RxString phoneNumber = "".obs;
  String selectedValue = '';
  RxInt registData = 0.obs;
  RxInt registDataImage = 0.obs;
  RxInt registDataUserId = 0.obs;
  RxString timesMulai = ''.obs;
  RxString timesMulaiUI = ''.obs;
  RxString timesBerakhir = ''.obs;
  RxString timesBerakhirUI = ''.obs;
  RxList listPendidikan = [].obs;
  RxList listPengalaman = [].obs;
  RxList listJadwalMulai = [].obs;
  RxList listJadwalBerakhir = [].obs;
  RxBool isButtonActive = false.obs;
  RxBool isLoading = false.obs;

  final regis = [].obs;
  var isToLoadMore = true;
  var page = 1;

  Future<dynamic> register(
      {required String name,
      required String brithdayDate,
      required String address,
      required String gender,
      required String phoneNumber,
      required String experience,
      required String strNumber,
      required String sipNumber,
      required String latit,
      required String longin,
      required String districts,
      required String city,
      required String country,
      required String deviceId,
      File? files
      // required String image,
      }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": name,
      "brithdayDate": brithdayDate,
      "address": address,
      "gender": gender,
      "phoneNumber": phoneNumber,
      "experience": experience,
      "strNumber": strNumber,
      "sipNumber": sipNumber,
      "lat": latit,
      "long": longin,
      "districts": districts,
      "city": city,
      "country": country,
      "deviceId": deviceId,
      // "image" : image
    };

    try {
      isLoading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}register/doctor', Method.POST, params);
      final regis = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$regis");
      registData.value = regis['data']['id'];
      registDataUserId.value = regis['data']['userId'];
      registDataImage.value = regis['data']['id'];
      updateImage(files!, regis['data']['userId'].toString());
      // }
      isLoading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<bool> updateImage(File imageFile, String id) async {
    // ignore: unused_local_variable
    String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}doctor/photo-profile/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('Failed');
      return false;
    }
  }
}
