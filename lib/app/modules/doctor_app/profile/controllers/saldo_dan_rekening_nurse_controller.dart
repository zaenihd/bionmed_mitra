import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class SaldoDanRekeningNurseController extends GetxController {
  RxBool loading = false.obs;
  RxList listBank = [].obs;
  RxList listDataBankNurse = [].obs;
  RxList listDataWithDrawNurse = [].obs;
  RxMap dataAddWithDrawNurse = {}.obs;
  RxMap dataAddBankNurse = {}.obs;

  Future<dynamic> sendWithDrawNurse({
    required String date,
    required int nurseBankId,
    required int amount,

    // required String deviceId,
    // File? files
    // required String image,
  }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "nurseBankId": nurseBankId,
      "amount": amount,
      "date": date,
    };
    try {
      loading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/add/withdraw/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final withDraw = json.decode(result.toString());
      dataAddWithDrawNurse.value = withDraw['data'];

      // }
      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> addBanknurse({
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
          '${MainUrl.urlApi}nurse/add/bank/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final addBank = json.decode(result.toString());
      dataAddBankNurse.value = addBank['data'];


      // }
      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> listBanknurse() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      loading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse/bank/${Get.find<LoginController>().idLogin}', Method.GET, params);
      final listBank = json.decode(result.toString());
      listDataBankNurse.value = listBank['data'];
      log("list   " + listDataBankNurse.toString());


      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  
  Future<dynamic> listWithDrawnurse() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      loading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse/withdraw/4', Method.GET, params);
      final listWithDraw = json.decode(result.toString());
      listDataWithDrawNurse.value = listWithDraw['data'];


      loading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      // print('zzezezeez ' + e.toString());
      log('qwerty');
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
