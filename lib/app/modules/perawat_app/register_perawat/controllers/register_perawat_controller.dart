import 'dart:convert';
import 'dart:io';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterPerawatController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameNurseC = TextEditingController();
  TextEditingController tanggalLahirNurseC = TextEditingController();
  TextEditingController monerStrNurseC = TextEditingController();
  TextEditingController alamatNurseC = TextEditingController();
  TextEditingController controlleragama = TextEditingController();
  TextEditingController pengalamanC = TextEditingController();
  RxString imageUrlStr = ''.obs;
  
  Future<dynamic> registerNurse(
      {required String name,
      required String brithdayDate,
      required String gender,
      required String phoneNumber,
      required String strNumber,
      required String latit,
      required String longin,
      required String districts,
      required String city,
      required String country,
      required String deviceId,
      required String religion,
      required String address,
      required String pengalaman,
      File? files,
      File? filesStr
      // required String image,
      }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": name,
      "brithday_date": brithdayDate,
      "gender": gender,
      "phoneNumber": phoneNumber,
      "religion" : religion,
      "register_number_nurse": strNumber,
      "lat" :latit,
      "long" :longin,
      "districts" : districts,
      "city" :city,
      "country" :country,
      "address": address,
      "deviceId": deviceId,
      "experience": pengalaman,
      // "image" : image
    };
    
    try {
      isLoading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}register/nurse', Method.POST, params);
      final registerNurse = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$result");
      updateImage(files!, registerNurse['data']['userId'].toString());
      updateImageStrNumber(filesStr!, registerNurse['data']['userId'].toString());
      // ignore: avoid_print
      print('DAftar == $registerNurse');
      // }
      isLoading(false);
    } on Exception catch (e) {
      isLoading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<bool> updateImage(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}nurse/photo-profile/$id";
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
      print('done Bro gagal');
      return false;
    }
  }

  Future<bool> updateImageStrNumber(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}nurse/photo-str/$id";
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
      print('done Bro gagal STR');
      return false;
    }
  }
}
