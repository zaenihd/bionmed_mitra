import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/url.dart';
import '../../jadwal_saya/controllers/jadwal_saya_controller.dart';

class LengkapiProfilController extends GetxController {
  //CONTROLLER PENDIDIKAN

  TextEditingController pendidikan = TextEditingController();
  TextEditingController tahunMasuk = TextEditingController();
  TextEditingController tahunLulus = TextEditingController();
  RxList listPendidikan = [].obs;
  RxBool isloading = false.obs;
  final loginC = Get.put(LoginController());

  Future<dynamic> tambahPendidikan({required List education}) async {
    final params = <String, dynamic>{
      "request": education
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/education/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final pendidikan = json.decode(result.toString());
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //CONTROLLER PRAKTEK

  TextEditingController pengalamanC = TextEditingController();
  RxList listPengalaman = [].obs;

  Future<dynamic> tambahPengalaman({required List experience}) async {
    final params = <String, dynamic>{
      "request": experience
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/experience/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final pengalaman = json.decode(result.toString());
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //CONTROLLER JAM PRAKTEK
  RxString timesMulaiUI = ''.obs;
  RxString timesBerakhirUI = ''.obs;
  RxString timesMulaiUISelasa = ''.obs;
  RxString timesBerakhirUISelasa = ''.obs;
  RxString timesMulaiUIRabu = ''.obs;
  RxString timesBerakhirUIRabu = ''.obs;
  RxString timesMulaiUIKamis = ''.obs;
  RxString timesBerakhirUIKamis = ''.obs;
  RxString timesMulaiUIJumat = ''.obs;
  RxString timesBerakhirUIJumat = ''.obs;
  RxString timesMulaiUISabtu = ''.obs;
  RxString timesBerakhirUISabtu = ''.obs;
  RxString timesMulaiUIMinggu = ''.obs;
  RxString timesBerakhirUIMinggu = ''.obs;
  String selectedValue = '';
  RxList listJadwal = [].obs;
  RxBool active = false.obs;
  RxBool activeSelasa = false.obs;
  RxBool activeRabu = false.obs;
  RxBool activeKamis = false.obs;
  RxBool activeJumat = false.obs;
  RxBool activeSabtu = false.obs;
  RxBool activeMinggu = false.obs;

  RxList jadwalSenin = [].obs;
  RxList jadwalSelasa = [].obs;
  RxList jadwalRabu = [].obs;
  RxList jadwalKamis = [].obs;
  RxList jadwalJumat = [].obs;
  RxList jadwalSabtu = [].obs;
  RxList jadwalMinggu = [].obs;

  RxList jadwal = [].obs;
  RxInt itemCount = 0.obs;
  RxInt activeSwicth = 0.obs;

  String jadwalDokter = "";

  Future<dynamic> tambahJadwal({
    required List scheduler,
  }) async {
    final params = <String, dynamic>{
      "request": scheduler

      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/schedule/${loginC.idLogin}/${Get.find<JadwalSayaController>().serviceId}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final jadwal = json.decode(result.toString());
      // jadwalDokter = jadwal['data']['doctor_schedules'];
       if(jadwal['code'] == 200){
      // Get.back();
      }
      // }
      // Get.back();
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      Get.defaultDialog(title: 'Error', middleText: e.toString());
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //TAMBAH JADWAL NURSE
  Future<dynamic> tambahJadwalNurse({
    required List scheduler,
  }) async {
    final params = <String, dynamic>{
      "request": scheduler

      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/schedule/${Get.find<JadwalSayaController>().serviceId}/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final jadwal = json.decode(result.toString());
      if(jadwal['code'] == 200){
        // ignore: avoid_print
        print('zaza == . $jadwal' );
      }

      log( 'hahaa$jadwal');
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }
      isloading(false);
    } on Exception catch (e) {
      Get.defaultDialog(title: 'Error', middleText: e.toString());

      // ignore: avoid_print
      print(e.toString());
    }
  }


  Future<dynamic> tambahJadwalHospital({
    required List scheduler,
  }) async {
    final params = <String, dynamic>{
      "request": scheduler

      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/schedule/${Get.find<JadwalSayaController>().serviceId}/${Get.put(PaketLayananNurseController()).idTimHospital.value}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final jadwal = json.decode(result.toString());
      if(jadwal['code'] == 200){
        // ignore: avoid_print
        print('zaza == . $jadwal' );
      }

      log( 'hahaa$jadwal');
      // jadwalDokter = jadwal['data']['doctor_schedules'];
      // }
      isloading(false);
    } on Exception catch (e) {
      Get.defaultDialog(title: 'Error', middleText: e.toString());

      // ignore: avoid_print
      print(e.toString());
    }
  }

  //NURSING HOME 
  Future<dynamic> tambahPendidikanNurse({required List education}) async {
    final params = <String, dynamic>{
      "request": education
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/education/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final pendidikan = json.decode(result.toString());
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print("GAGAL +" + e.toString());
    }
  }

  Future<dynamic> tambahPengalamanNurse({required List experience}) async {
    final params = <String, dynamic>{
      "request": experience
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/experience/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final pengalaman = json.decode(result.toString());
      // }
      isloading(false);
    } on Exception catch (e) {
      isloading(false);

      // ignore: avoid_print
      print("ZAZA GAGAl$e");
    }
  }

  Future<dynamic> updateProfilNurseVerifikasi(
) async {
    // isloading(true);
    final params = <String, dynamic>{
      "verifiedStatus": 2,

    };
    try {
      // loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/profile/${loginC.idLogin}', Method.POST, params);
      // ignore: unused_local_variable
      final editProfil = json.decode(result.toString());
      // ignore: avoid_print
      print('Zae  $editProfil');

      // }
      // loading(false);
    } on Exception catch (e) {

      Get.defaultDialog(title: 'Terjadi Kesalahan', middleText: e.toString());
      // loading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
