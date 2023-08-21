import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaketLayananNurseController extends GetxController {
  TextEditingController namaPaketC = TextEditingController();
  TextEditingController deskripsiPaketC = TextEditingController();
  TextEditingController hargaPaketC = TextEditingController();
  TextEditingController diskonPaket = TextEditingController();
  RxDouble totalHargaPaket = 0.0.obs;
  RxBool tambahDiskon = false.obs;
  RxBool isloading = false.obs;
  RxInt serviceIdNurse = 0.obs;

  RxList nursepaketData = [].obs;

  RxString namaPaket = ''.obs;
  RxString deskripsiPaket = ''.obs;
  RxString hargaPaket = ''.obs;
  RxString hargaCurrens = ''.obs;

  RxInt idPaket = 0.obs;

  Future<dynamic> getNursePket() async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}service-price-nurse/${Get.put(LoginController()).idLogin}/$serviceIdNurse',
          Method.GET,
          params);
      var nursePaket = json.decode(result.toString());
      nursepaketData.value = nursePaket['data'];
      log(nursepaketData.toString());

      isloading(false);
    } on Exception catch (e) {
      isloading(false);
      nursepaketData.clear();
      // ignore: avoid_print
      print("Cek error pesan haha $e");
    }
  }

  final dio = Dio();

  Future<dynamic> deleteNursePket() async {
    isloading(true);
    // final params = <String, dynamic>{};
    try {
      // ignore: unused_local_variable
      final response = await dio.delete(
        '${MainUrl.urlApi}package-nurse/delete/${idPaket.value}',
        options: Options(
          headers: {
            // Add any headers required for your API
          },
          // Add any other options like query parameters, authentication, etc.
        ),
      );

      // Handle the response
    } catch (error) {
      // Handle the error
      // ignore: avoid_print
      print("Cek error pesan hahaha $error");
    }
  }

  Future<dynamic> tambahPaketLayananNurse() async {
    final params = <String, dynamic>{
      "name": namaPaketC.text,
      "description": deskripsiPaketC.text,
      "price": int.parse(hargaCurrens.value),
      "discount": diskonPaket.text == "" ? "0" : diskonPaket.text,
      "sop": tampunganNurseId
    };
    isloading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}package-nurse/${Get.put(LoginController()).idLogin}/$serviceIdNurse',
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

  // Future<dynamic> editPaketLayananNurse() async {
  //   final params = <String, dynamic>{
  //     "name": namaPaketC.text,
  //     "description": deskripsiPaketC.text,
  //     "price": int.parse(hargaCurrens.value),
  //     "discount": diskonPaket.text == "" ? "0" : diskonPaket.text,
  //     "sop": tampunganNurseId
  //   };
  //   isloading(true);
  //   try {
  //     final result = await RestClient().request(
  //         '${MainUrl.urlApi}package-nurse/update/${idPaket.value}',
  //         Method.PATCH,
  //         params);
  //     // ignore: unused_local_variable
  //     final paketLayanan = json.decode(result.toString());
  //     // ignore: avoid_print
  //     print("Berhasil Edit yaa" + paketLayanan.toString());
  //     // jadwalDokter = jadwal['data']['doctor_schedules'];
  //     // }

  //     isloading(false);
  //   } on Exception catch (e) {
  //     // ignore: avoid_print
  //     log("ADA YG SALAH NIH" + e.toString());
  //   }
  // }

  Future<void> editPaketLayananNurse() async {
     final params = <String, dynamic>{
      "name": namaPaketC.text,
      "description": deskripsiPaketC.text,
      "price": int.parse(hargaCurrens.value),
      "discount": diskonPaket.text == "" ? "0" : diskonPaket.text,
      "sop": tampunganNurseId
    };

    final response = await http.put(
      Uri.parse('${MainUrl.urlApi}package-nurse/update/${idPaket.value}',),
      headers: {
        'Content-Type': 'application/json',
        // Add any required headers here
      },
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      // PUT request was successful
      print('PUT request successful');
      log('Response: ${response.body}');
    } else {
      // Error occurred during PUT request
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  // CONTROLLER SCOPE OF
  RxBool value = false.obs;
  RxList tampunganNurseId = [].obs;
  RxList tampunganNurseIdEdit = [].obs;
  RxBool selected = false.obs;
  RxList nurseScopeData = [].obs;
  RxList dataActive = [].obs;
  RxList packageNurseSops = [].obs;

  Future<dynamic> getNurseWorkScope() async {
    isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse-work-scope/$serviceIdNurse',
          Method.GET,
          params);
      var nurseWorkScope = json.decode(result.toString());
      nurseScopeData.value = nurseWorkScope['data'];
      // ignore: unused_local_variable
      //  if(){}
      // ignore: unused_local_variable
      for (var i in nurseScopeData) {
        dataActive.add({"value": false});
      }
      // ignore: avoid_print
      print('hahah $dataActive');

      isloading(false);
    } on Exception catch (e) {
      isloading(false);
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  
}
