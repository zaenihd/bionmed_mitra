import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final box = GetStorage();
  RxBool loading = false.obs;

  

  //Tambah Rekening
  TextEditingController nameC = TextEditingController();
  TextEditingController noRekeningC = TextEditingController();

  // Edit Profile
  final TextEditingController controllerName = TextEditingController(
      text: Get.find<JadwalSayaController>().name.toString());
  final TextEditingController controllerDate = TextEditingController(
      text: Get.find<JadwalSayaController>().birthDay.toString());
  final TextEditingController controllerAdress = TextEditingController(
      text: Get.find<JadwalSayaController>().address.toString());
  final TextEditingController controllerPengalaman = TextEditingController(
      text: Get.find<JadwalSayaController>().experience.toString());
  final TextEditingController controllerNomerStr = TextEditingController(
      text: Get.find<JadwalSayaController>().strNumber.toString());
  final TextEditingController controllerNomerSip = TextEditingController(
      text: Get.find<JadwalSayaController>().sipNumber.toString());
  final loginC = Get.put(LoginController());

  Future<dynamic> updateProfil(
      {required String name,
      required String brithdayDate,
      required String address,
      required String gender,
      // required String phoneNumber,
      required String experience,
      required String strNumber,
      required String sipNumber,
      required String lat,
      required String long,
      File? files

      // required String deviceId,
      // File? files
      // required String image,
      }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": name,
      "brithdayDate": brithdayDate,
      "address": address,
      "gender": gender,
      // "phoneNumber": phoneNumber,z
      "experience": experience,
      "strNumber": strNumber,
      "sipNumber" : sipNumber,
      "lat":lat,
      "long": long

      // "image" : image
    };
    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/profile/${loginC.id}', Method.POST, params);
      // ignore: unused_local_variable
      final editProfil = json.decode(result.toString());
      if(files != null){
              updateImage(files, Get.find<LoginController>().userIdLogin.toString());

      }
      log('MASUUK $editProfil');

      // }
      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
  Future<dynamic> updateProfilNurse(
      {required String name,
      required String brithdayDate,
      required String address,

      // required String deviceId,
      // File? files
      // required String image,
      }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": name,
      "brithday_date": brithdayDate,
      "address": address,

      // "image" : image
    };
    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/profile/${loginC.idLogin}', Method.POST, params);
      // ignore: unused_local_variable
      final editProfil = json.decode(result.toString());
      // ignore: avoid_print
      print('Zae  $editProfil');

      // }
      loading(false);
    } on Exception catch (e) {

      Get.defaultDialog(title: 'Terjadi Kesalahan', middleText: e.toString());
      loading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<bool> updateImage(File imageFile, String id) async {
    // ignore: unused_local_variable
    String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}doctor/photo-profile/$id";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    // ignore: unused_local_variable
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // ignore: avoid_print
      print('Failed');
      return false;
    }
  }
  

  Future<dynamic> lengkapiProfil(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 380,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/icon/icon_lengkapi_profil.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Lengkapi Data',
                            style: blackTextStyle.copyWith(
                                fontWeight: bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Lengkapi data anda untuk menginformasikan\njadwal praktek',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Lengkapi Sekarang",
                            onTap: () {
                              Get.toNamed(Routes.LENGKAPI_PROFIL);
                            },
                          )
                        ])
                  ]));
        });
  }

  //EDIT LAYANAN
  Future<dynamic> editService({
    required List serviceId,
  }) async {
    final params = <String, dynamic>{
      "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/service/${loginC.idLogin}',
          Method.POST,
          params);
      final layanan = json.decode(result.toString());
      return layanan;
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //Edit SPESIALIS
  // RxString
  RxList choiceBank = [].obs;
  RxBool selected = false.obs;
  RxString selected1 = "".obs;
  RxBool isSelected = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isloading = false.obs;

  TextEditingController pengalaman = TextEditingController();

  void toggle11(int index) => selectedIndex.value = index;

  toogle1() {
    isSelected = isSelected;
  }

  Future<dynamic> editSpesialis({
    required int serviceId,
    // required Map doctor_services,
  }) async {
    final params = <String, dynamic>{
      "specialistId": serviceId,
      // 'specialist' : doctor_services
    };
    try {
      // ${registerC.registData}
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/specialist/${loginC.userIdLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final regis = json.decode(result.toString());
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //EDIT PENGALAMAN
  RxList tambahPengalaman = [].obs;

  Future<dynamic> editPengalaman({required List experience}) async {
    final params = <String, dynamic>{
      "request": experience
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/experience/${loginC.idLogin}',
          Method.POST,
          params);

      final pengalaman = json.decode(result.toString());
      // ignore: avoid_print
      print("cek update $pengalaman");
      return pengalaman;
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //EDIT PENDIDIKAN
  TextEditingController pendidikan = TextEditingController();
  TextEditingController tahunMasuk = TextEditingController();
  TextEditingController tahunLulus = TextEditingController();
  RxList listPendidikan = [].obs;

  Future<dynamic> editPendidikan({required List education}) async {
    final params = <String, dynamic>{
      "request": education
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/education/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final pendidikan = json.decode(result.toString());
      // }

    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

}
