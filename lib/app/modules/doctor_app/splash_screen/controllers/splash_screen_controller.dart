// import 'package:bionmed_app/screens/onboarding/onboarding_screen.dart';
import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/introduction_screen/views/introduction_screen_view.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();
  final cLogin = Get.put(LoginController());

  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  @override
  void onInit() async {
    getLocation();
    super.onInit();

    var phone = await box.read('phone');
    var idAccount = await box.read('idAccount');
    if (phone == null) {
      Future.delayed(const Duration(milliseconds: 1500))
          .then((value) => Get.to(() => IntroductionScreenView()));
    }
    if (phone != null) {
      if (idAccount == 1) {
        cLogin.loginV2(phoneNumber: phone, isSplash: true);
      } else if(idAccount == 2) {
        cLogin.loginNurse(phoneNumber: phone, isSplash: true);
      }else{
        cLogin.loginHospital(phoneNumber: phone, isSplash: true);
      }
    }
    

    
  
  }
  void getLocation() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    lat.value = position.latitude;
      long.value = position.longitude;
      // ignore: unused_local_variable
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
          log('lat ${lat.value}');
    log('long ${long.value}');
  
    }
    
}
