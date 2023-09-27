import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LengkapiDataHospitalController extends GetxController {
  final loginC = Get.find<LoginController>();
  RxBool isJadwal = false.obs;

  @override
  void onInit() {
    getService();
    if (isFromProfile.isFalse) {
      // serviceHospital();
    }
    // TODO: implement onInit
    super.onInit();
  }

  getService() async {
    await serviceHospital();
  }

  RxBool isloading = false.obs;
  RxBool isFromProfile = false.obs;
  RxInt nurseId = 0.obs;
  RxInt serviceId = 0.obs;
  //====================TIM LAYANAN=======================
  RxBool isAddedTeamService = false.obs;
  RxBool isEditTim = false.obs;
  RxList listTimLayanan = [].obs;
  RxString serviceName = "".obs;
  RxString serviceImage = "".obs;
  RxInt timId = 0.obs;
  RxInt index = 0.obs;
  TextEditingController namaTimController = TextEditingController();
  TextEditingController nomerHpTimController = TextEditingController();
  TextEditingController deskripsiTimController = TextEditingController();
  //====================PAKET TIM LAYANAN=======================
  RxBool tambahDiskon = false.obs;
  RxString hargaCurrens = "".obs;
  RxString hargaTanpaDiskon = "".obs;
  RxDouble totalHargaPaket = 0.0.obs;
  TextEditingController namaPaketController = TextEditingController();
  TextEditingController deskripsiPaketController = TextEditingController();
  TextEditingController hargaPaketController = TextEditingController();
  TextEditingController diskonPaketController = TextEditingController();
  RxInt hospitalId = 0.obs;

  //==================LIST SERVICE HOSPITAL========================
  RxList listServiceHospital = [].obs;
  RxList listTimServiceHospital = [].obs;
  Future<dynamic> serviceHospital() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/service/${loginC.idLogin}',
          Method.GET,
          params);
      final serviceHospital = json.decode(result.toString());
      listServiceHospital.value = serviceHospital['data'];
      if (isFromProfile.isTrue) {
        listServiceHospital.value = listServiceHospital
            .where(
              (p0) => p0['team'].length != 0,
            )
            .toList();
        log("filter :${listServiceHospital.where(
              (p0) => p0['team'].length != 0,
            ).toList()}");
      }
      if (serviceHospital['code'] == 200) {
        log("hahhahah$listServiceHospital");
      }
      isloading(false);
    } on Exception catch (e) {
      isloading(false);

      // ignore: avoid_print
      print(e.toString());
    }
  }

  //==================TAMBAH TIM LAYANAN HOSPITAL==========================

  Future<dynamic> tambahTimLayananHospital() async {
    final params = <String, dynamic>{
      "hospitalId": loginC.idLogin,
      "serviceId": serviceId.value,
      "name": namaTimController.text,
      "phoneNumber": nomerHpTimController.text,
      "description": deskripsiTimController.text
    };
    isloading(true);
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}hospital/team', Method.POST, params);
      // ignore: unused_local_variable
      final paketLayanan = json.decode(result.toString());
      log("tambah paket ");
      log("tambah paket $paketLayanan");
      Get.back();
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // Get.defaultDialog();
      showPopUp(
          onTap: () {
            Get.back();
          },
          imageAction: 'assets/json/eror.json',
          description: "Nomer telah digunakan!");
      // Get.defaultDialog(
      //     title: "Terjadi kesalahan", middleText: "Nomer telah digunakan!");
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //==================EDIT TIM LAYANAN HOSPITAL==========================

  Future<dynamic> updateTimLayananHospital() async {
    final params = <String, dynamic>{
      "hospitalId": loginC.idLogin,
      "serviceId": serviceId.value,
      "name": namaTimController.text,
      "phoneNumber": nomerHpTimController.text,
      "description": deskripsiTimController.text
    };
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/team/update/$timId', Method.POST, params);
      // ignore: unused_local_variable
      final paketLayanan = json.decode(result.toString());
      log("ahhahaha $paketLayanan");
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //==================HAPUS TIM LAYANAN HOSPITAL==========================
  Future<dynamic> deleteTimLayananHospital() async {
    final params = <String, dynamic>{"serviceId": serviceId.value};
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/team/delete/$timId', Method.POST, params);
      // ignore: unused_local_variable
      final timHospital = json.decode(result.toString());
      log(timHospital.toString());
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //==================LIST PAKET TIM HOSPITAL========================
  RxList nursepaketData = [].obs;
  Future<dynamic> paketTimHospital() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}service-price-nurse/$nurseId/$serviceId',
          Method.GET,
          params);
      final paketTimHospital = json.decode(result.toString());
      nursepaketData.value = paketTimHospital['data'];
      if (paketTimHospital['code'] == 200) {}
      isloading(false);
    } on Exception catch (e) {
      isloading(false);

      // ignore: avoid_print
      print(e.toString());
    }
  }

  //==================TAMBAH PAKET TIM HOSPITAL========================
  Future<dynamic> tambahPaketLayananNurse({
    required String nurseId,
    required String serviceId,
  }) async {
    final params = <String, dynamic>{
      "name": namaPaketController.text,
      "description": deskripsiPaketController.text,
      "price": int.parse(hargaCurrens.value),
      "discount":
          diskonPaketController.text == "" ? "0" : diskonPaketController.text,
      "sop": Get.find<PaketLayananNurseController>().tampunganNurseId
    };
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}package-nurse/$nurseId/$serviceId',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final paketLayanan = json.decode(result.toString());
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

//================================EDIT PAKET TIM HOSPITAL===========================
  Future<void> editPaketLayananNurse() async {
    final params = <String, dynamic>{
      "name": namaPaketController.text,
      "description": deskripsiPaketController.text,
      "price": int.parse(hargaCurrens.value),
      "discount":
          diskonPaketController.text == "" ? "0" : diskonPaketController.text,
      "sop": Get.find<PaketLayananNurseController>().tampunganNurseId
    };

    final response = await http.put(
      Uri.parse(
        '${MainUrl.urlApi}package-nurse/update/${Get.find<PaketLayananNurseController>().idPaket.value}',
      ),
      headers: {
        'Content-Type': 'application/json',
        // Add any required headers here
      },
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      // PUT request was successful
      log('Response: ${response.body}');
    } else {
      // Error occurred during PUT request
    }
  }

//================================ALL TIM HOSPITAL===========================
  RxList listAllTimHospital = [].obs;
  Future<dynamic> allTimHospital() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/all/team/${loginC.idLogin}',
          Method.GET,
          params);
      final allTimHospital = json.decode(result.toString());
      listAllTimHospital.value = allTimHospital['data'];
      if (allTimHospital['code'] == 200) {
        log(listAllTimHospital.toString());
      }
      isloading(false);
    } on Exception catch (e) {
      isloading(false);

      // ignore: avoid_print
      print(e.toString());
    }
  }
}
