// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/splash_screen/controllers/splash_screen_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JadwalSayaController extends GetxController {
  RxInt idJadwal = 0.obs;
  RxBool isloading = false.obs;
  RxList dataDokter = [].obs;
  RxList jadwalDoctor = [].obs;
  RxList statusJadwal = [].obs;
  RxString name = "".obs;
  RxString namePic = "".obs;
  RxString birthDay = "".obs;
  RxString experience = "".obs;
  RxString strNumber = "".obs;
  RxString sipNumber = "".obs;
  RxString address = ''.obs;
  RxString codeAccess = ''.obs;
  RxString addressPicHospital = ''.obs;
  RxString tanggalLahirPicHospital = ''.obs;
  RxString emailHospital = ''.obs;
  RxList pengalamanDokter = [].obs;
  RxList pendidikanDokter = [].obs;
  RxString profileImage = ''.obs;
  RxString profileImagePic = ''.obs;
  RxInt spesialist = 0.obs;
  RxString spesialis = ''.obs;
  RxList service = [].obs;
  RxList jadwal = [].obs;
  RxList listServiceData = [].obs;
  RxList listServiceDataFilter = [].obs;
  RxBool isVerifi = false.obs;
  RxInt serviceId = 0.obs;
  RxInt idNurse = 0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

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
    log('lat dari profile ${lat.value}');
    log('long dari profile ${long.value}');
  }

  final loginC = Get.find<LoginController>();
  final paketLayananNurse = Get.put(PaketLayananNurseController());

  Future<dynamic> updateJadwanOnOff({required bool isActive}) async {
    final params = <String, dynamic>{
      "isActive": isActive,
    };
    // isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/onoff/schedule/${idJadwal.value}',
          Method.POST,
          params);
      final pengalaman = json.decode(result.toString());
      // ignore: avoid_print
      print("cek masuk nih$pengalaman");
      // }
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> loginData({required String phoneNumber}) async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/doctor', Method.POST, params);
      final donors = json.decode(result.toString());
      // if (donors['code'] == 200)
      if (donors['data']['doctor'] != null) {
        codeAccess.value = "";
        dataDokter.value = donors['data']['doctor']['doctor_schedules'];
        name.value = donors['data']['doctor']['name'];
        birthDay.value = donors['data']['doctor']['brithdayDate'];
        experience.value = donors['data']['doctor']['experience'];
        strNumber.value = donors['data']['doctor']['strNumber'];
        sipNumber.value = donors['data']['doctor']['sipNumber'];
        address.value = donors['data']['doctor']['address'];
        // pengalamanDokter.value = donors['data']['doctor']['doctor_experiences'];
        pendidikanDokter.value = donors['data']['doctor']['doctor_educations'];
        profileImage.value = donors['data']['doctor']['image'];
        spesialist.value = donors['data']['doctor']['specialist']['id'];
        jadwal.value = donors['data']['doctor']['doctor_schedules'];
        service.value = donors['data']['doctor']['doctor_services'];
        spesialis.value = donors['data']['doctor']['specialist']['name'];
        isVerifi.value = donors['isVerification'];

        // if(isVerifi.value == false){
        //     print('Masuk Weu');
        //     // Get.defaultDialog();
        //     lengkapiProfil(Get.context!);
        //   };
      }

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> loginDataNurse({required String phoneNumber}) async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/nurse', Method.POST, params);
      final donors = json.decode(result.toString());
      // if (donors['code'] == 200)
      if (donors['data']['nurse'] != null) {
        codeAccess.value = "";
        // dataDokter.value = donors['data']['nurse']['nurse_schedules'];
        name.value = donors['data']['nurse']['name'];
        idNurse.value = donors['data']['nurse']['id'];
        birthDay.value = donors['data']['nurse']['brithday_date'] ?? "";
        // experience.value = donors['data']['nurse']['experience'];
        strNumber.value = donors['data']['nurse']['register_number_nurse'];
        // sipNumber.value = donors['data']['nurse']['sipNumber'];
        address.value = donors['data']['nurse']['address'] ?? "Alamat";
        pengalamanDokter.value = donors['data']['nurse']['nurse_experiences'];
        pendidikanDokter.value = donors['data']['nurse']['nurse_educations'];
        profileImage.value = donors['data']['nurse']['image'] != ""
            ? donors['data']['nurse']['image']
            : donors['data']['nurse']['hospital'].toString() == "[]"
                ? donors['data']['nurse']['image']
                : donors['data']['nurse']['hospital']['image'];
        // spesialist.value = donors['data']['nurse']['specialist']['id'];
        // jadwal.value = donors['data']['nurse']['nurse_schedules'];
        service.value = donors['data']['nurse']['nurse_services'];
        spesialis.value = donors['data']['nurse']['nurse_services'][0]
                ['service']['name'] ??
            "";
        Get.find<JadwalSayaController>().serviceId.value =
            donors['data']['nurse']['nurse_services'][0]['serviceId'];
        log('coba zen  ${Get.find<JadwalSayaController>().serviceId.value}');
        // isVerifi.value = donors['isVerification'];

        // if(isVerifi.value == false){
        //     print('Masuk Weu');
        //     // Get.defaultDialog();
        //     lengkapiProfil(Get.context!);
        //   };
      }

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  RxMap dataHospital = {}.obs;

  Future<dynamic> loginDataHospital({required String phoneNumber}) async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/hospital', Method.POST, params);
      final donors = json.decode(result.toString());
      // if (donors['code'] == 200)
      if (donors['data']['hospital'] != null) {
        dataHospital.value = donors['data']['hospital'];
        codeAccess.value = donors['data']['hospital']['codeAccess'] ?? "null";
        // dataDokter.value = donors['data']['hospital']['hospital_schedules'];
        name.value = donors['data']['hospital']['name'] ?? "";
        namePic.value = donors['data']['hospital']['picName'] ?? "";
        emailHospital.value = donors['data']['email'];
        // birthDay.value = donors['data']['hospital']['brithday_date'];
        // experience.value = donors['data']['hospital']['experience'];
        // strNumber.value = donors['data']['hospital']['register_number_hospital'];
        // sipNumber.value = donors['data']['hospital']['sipNumber'];
        address.value = donors['data']['hospital']['address'] ?? "Alamat";
        addressPicHospital.value =
            donors['data']['hospital']['picAddress'] ?? "alamat";
        tanggalLahirPicHospital.value =
            donors['data']['hospital']['picBrithday'] ?? "";
        // pengalamanDokter.value = donors['data']['hospital']['hospital_experiences'];
        // pendidikanDokter.value = donors['data']['hospital']['hospital_educations'];
        profileImage.value = donors['data']['hospital']['image'] ?? "";
        profileImagePic.value = donors['data']['hospital']['picImage'];
        // spesialist.value = donors['data']['hospital']['specialist']['id'];
        // jadwal.value = donors['data']['hospital']['hospital_schedules'];
        // service.value = donors['data']['hospital']['hospital_services'];
        spesialis.value = donors['data']['hospital']['description'] ?? "";
        // isVerifi.value = donors['isVerification'];

        // if(isVerifi.value == false){
        //     print('Masuk Weu');
        //     // Get.defaultDialog();
        //     lengkapiProfil(Get.context!);
        //   };
        log(codeAccess.toString());
      }

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> loginDataAmbulance({required String phoneNumber}) async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/ambulance', Method.POST, params);
      final donors = json.decode(result.toString());
      // if (donors['code'] == 200)
      if (donors['data']['ambulance'] != null) {
        dataHospital.value = donors['data']['ambulance'];
        // dataDokter.value = donors['data']['ambulance']['ambulance_schedules'];
        name.value = donors['data']['ambulance']['name'];
        profileImage.value = donors['data']['ambulance']['image'];
        profileImagePic.value = donors['data']['ambulance']['hospital']['picImage'] ?? "";
        namePic.value = donors['data']['ambulance']['hospital']['picName'] ?? "null"; 

        log(codeAccess.toString());
      }

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> checkPengalaman() async {
    isloading(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}doctor/data/experience/${loginC.idLogin}',
        Method.GET, {});
    final layanan = json.decode(result.toString());
    isloading(false);

    pengalamanDokter.value = layanan['data'];
    return layanan['data'];
  }

  getdata() async {
    final box = GetStorage();
    var phone = await box.read('phone');
    if (phone != null) {
      await loginData(phoneNumber: phone);
    }
  }

  Future<dynamic> checkJadwal() async {
    // isloading(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}doctor/data/schedule/${loginC.idLogin}/${Get.find<JadwalSayaController>().serviceId}',
        // /${serviceId.value}',
        Method.GET,
        {});
    final jadwal = json.decode(result.toString());
    log('haha +$jadwal');

    // isloading(false);
    return jadwal['data'];
  }

  Future<dynamic> checkJadwalNurse() async {
    isloading(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}nurse/data/schedule/${idNurse.value}/${Get.find<JadwalSayaController>().serviceId.value}?lat=${lat.value}&long=${long.value}',
        // /${serviceId.value}',
        Method.GET,
        {});
    final jadwal = json.decode(result.toString());
    // isloading(false);
    log('haha +$jadwal');
    return jadwal['data'];
  }

  Future<dynamic> checkJadwalTimHospital() async {
    // isloading(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}nurse/data/schedule/${paketLayananNurse.idTimHospital.value}/${Get.find<JadwalSayaController>().serviceId}?lat=${Get.put(SplashScreenController()).lat.value}&long=${Get.put(SplashScreenController()).long.value}',
        // /${serviceId.value}',
        Method.GET,
        {});
    final jadwal = json.decode(result.toString());
    // isloading(false);
    log('haha +$jadwal');
    return jadwal['data'];
  }
  
  Future<dynamic> checkJadwalTimAmbulance() async {
    // isloading(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}ambulance/data/schedule/${paketLayananNurse.idTimHospital.value}/${Get.find<JadwalSayaController>().serviceId}?lat=${Get.put(SplashScreenController()).lat.value}&long=${Get.put(SplashScreenController()).long.value}',
        // /${serviceId.value}',
        Method.GET,
        {});
    final jadwal = json.decode(result.toString());
    log('zaa${paketLayananNurse.idTimHospital.value}');
    // isloading(false);
    // log('haha +$jadwal${paketLayananNurse.idTimHospital.value}');
    return jadwal['data'];
  }

  getdataNurse() async {
    final box = GetStorage();
    var phone = await box.read('phone');
    if (phone != null) {
      await loginData(phoneNumber: phone);
    }
  }

  Future<dynamic> listService() async {
    isloading(true);
    final result =
        await RestClient().request('${MainUrl.urlApi}services', Method.GET, {});
    final service = json.decode(result.toString());
    isloading(false);

    listServiceData.value = service['data'];
    listServiceDataFilter.value = [
      listServiceData.where((p0) => p0['sequence'] == 1).toList(),
      listServiceData.where((p0) => p0['sequence'] == 2).toList(),
      listServiceData.where((p0) => p0['sequence'] == 4).toList()
    ];
    // ignore: avoid_print
    print('Zaeni : $listServiceDataFilter');

    return service['data'];
  }

  // Future<dynamic> lengkapiProfil(BuildContext context) {
  //   return showModalBottomSheet(
  //       isDismissible: false,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //       context: context,
  //       builder: (context) {
  //         return SizedBox(
  //             height: 380,
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                           margin: const EdgeInsets.only(bottom: 18, top: 14),
  //                           width: Get.width / 1.9,
  //                           height: 10,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: const Color(0xffEDEDED)),
  //                         ),
  //                         const SizedBox(
  //                           height: 16,
  //                         ),
  //                         Image.asset('assets/icon/icon_lengkapi_profil.png'),
  //                         const SizedBox(
  //                           height: 20.0,
  //                         ),
  //                         Text(
  //                           'Lengkapi Data',
  //                           style: blackTextStyle.copyWith(
  //                               fontWeight: bold, fontSize: 16),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         const SizedBox(
  //                           height: 14.0,
  //                         ),
  //                         Text(
  //                           'Lengkapi data anda untuk menginformasikan\njadwal praktek',
  //                           style: subtitleTextStyle,
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         const SizedBox(
  //                           height: 24,
  //                         ),
  //                         const SizedBox(
  //                           height: 24,
  //                         ),
  //                         ButtomGradient(
  //                           label: "Lengkapi Sekarang",
  //                           onTap: () {
  //                             Get.toNamed(Routes.LENGKAPI_PROFIL);
  //                           },
  //                         )
  //                       ])
  //                 ]));
  //       });
  // }
}
