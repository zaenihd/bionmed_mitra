import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaldoDanRekeningDoctorController extends GetxController {
  RxBool loading = false.obs;
  RxList listBank = [].obs;
  RxList listDataBankDoctor = [].obs;
  RxList listDataWithDrawDoctor = [].obs;
  RxMap dataAddWithDrawDoctor = {}.obs;
  RxMap dataAddBankDoctor = {}.obs;
  RxInt selected = 90.obs;
  RxInt bankId = 0.obs;
  RxInt bankIdFromList = 0.obs;
  RxInt saldoTarikCurren = 0.obs;
  RxString name = ''.obs;
  RxString noRekening = ''.obs;
  RxString selectedBank = ''.obs;


  TextEditingController amountController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomerRekeningController = TextEditingController();
  TextEditingController nominalSaldoTarikController = TextEditingController();

  Future<dynamic> sendWithDrawDoctor({
    required String date,
    required int doctorBankId,
    required int amount,

    // required String deviceId,
    // File? files
    // required String image,
  }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "doctorBankId": doctorBankId,
      "amount": amount,
      "date": date,
    };
    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/withdraw/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final withDraw = json.decode(result.toString());
      dataAddWithDrawDoctor.value = withDraw['data'];

      // }
      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> addBankDoctor({
    required String noRek,
    required String name,
    required int bankId,

    // required String deviceId,
    // File? files
    // required String image,
  }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "bankId": bankId,
      "name": name,
      "no_rek": noRek,
    };
    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/bank/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final addBank = json.decode(result.toString());
      dataAddBankDoctor.value = addBank['data'];
      log(dataAddBankDoctor.toString());


      // }
      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> listBankDoctor() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      loading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}doctor/bank/${Get.find<LoginController>().idLogin}', Method.GET, params);
      final listBank = json.decode(result.toString());
      listDataBankDoctor.value = listBank['data'];

      log(listDataBankDoctor.toString());


      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  
  Future<dynamic> listWithDrawDoctor() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      loading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}doctor/withdraw/${Get.find<LoginController>().idLogin}', Method.GET, params);
      final listWithDraw = json.decode(result.toString());
      listDataWithDrawDoctor.value = listWithDraw['data'];
      log(Get.find<LoginController>().idLogin.toString());


      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> listDataBank() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      loading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}bank', Method.GET, params);
      final bank = json.decode(result.toString());
      listBank.value = bank['data'];

      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }





}
