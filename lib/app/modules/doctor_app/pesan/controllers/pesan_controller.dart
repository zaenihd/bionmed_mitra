import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class PesanController extends GetxController {
final loginC = Get.find<LoginController>();

RxList dataPesan = [].obs;

  RxBool isloading = false.obs;
  RxInt orderIdInbox = 0.obs;
  RxInt statusLayanan = 0.obs;
  RxString nameLayanan = "".obs;
  RxString orderCode = "".obs;
  RxString tanggalPesan = "".obs;
  RxString jamMulai = "".obs;
  RxString jamSelesai = "".obs;
  RxInt inboxId = 0.obs;
  RxInt readInbox = 0.obs;
  RxMap read = {}.obs;
  RxInt activeNotif = 0.obs;


  Future<dynamic> notification(
  ) async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/doctor/${loginC.idLogin}', Method.POST, params);
      var pesan = json.decode(result.toString());
      dataPesan.value = pesan['data'] ?? [];
      activeNotif.value =
          dataPesan.where((d) => d['status'] == 1).toList().length;


      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> readPesan(
  ) async {
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/read/$inboxId', Method.POST, params);
      var bacaPesan = json.decode(result.toString());
      read.value = bacaPesan;
      log(read.toString());
      readInbox.value = bacaPesan['status'] ?? 0;


      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> hapusPesan(
  ) async {
    // isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/delete/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  //-------------------------------------PESAN NURSE-------------------------------------
   Future<dynamic> notificationNurse(
  ) async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/nurse/${loginC.idLogin}', Method.POST, params);
      var pesan = json.decode(result.toString());
      dataPesan.value = pesan['data'] ?? [];
      activeNotif.value =
          dataPesan.where((d) => d['status'] == 1).toList().length;


      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> readPesanNurse(
  ) async {
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/nurse/read/$inboxId', Method.POST, params);
      var bacaPesan = json.decode(result.toString());
      read.value = bacaPesan;
      // readInbox.value = bacaPesan['status'];
      log(read.toString()); 


      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> hapusPesanNurse(
  ) async {
    // isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/nurse/delete/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  
}
