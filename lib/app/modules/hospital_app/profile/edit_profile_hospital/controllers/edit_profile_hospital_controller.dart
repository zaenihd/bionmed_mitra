import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/string.dart';
import '../../../../doctor_app/login/controllers/login_controller.dart';
import 'package:http/http.dart' as http;

class EditProfileHospitalController extends GetxController {
  TextEditingController namaHopitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().dataHospital['name']);
  TextEditingController emailHopitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().emailHospital.value);
  TextEditingController alamatHospitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().dataHospital['address']);
  TextEditingController deskripsiHospitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().dataHospital['description']);
  TextEditingController nomerHospitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().dataHospital['phoneNumber']);
  TextEditingController tahunBerdiriHospitalC = TextEditingController(
      text: Get.find<JadwalSayaController>().dataHospital['since']);
  RxString imageUrlHospital = ''.obs;
  RxString selectedStatus = ''.obs;
  RxString selectedGender = ''.obs;
  RxString dokumenPendukung = ''.obs;
  RxString dokumenSuratIjinOperasional = ''.obs;
  RxString dokumenKtp = ''.obs;
  RxBool isLoading = false.obs;
  var filesHospital;

  Future<dynamic> updateProfileHospital() async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": namaHopitalC.text,
      "email": emailHopitalC.text,
      "description": deskripsiHospitalC.text,
      "phoneNumber": nomerHospitalC.text,
      "lat": Get.put(RegisterController()).latHospital.value.toString() == "0.0"
          ? Get.find<JadwalSayaController>().dataHospital['lat'].toString()
          : Get.put(RegisterController()).latHospital.value.toString(),
      "long":
          Get.put(RegisterController()).longHospital.value.toString() == "0.0"
              ? Get.find<JadwalSayaController>().dataHospital['long'].toString()
              : Get.put(RegisterController()).longHospital.value.toString(),
      "districts": Get.put(RegisterController()).kecamatanHospital.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['district']
          : Get.put(RegisterController()).kecamatanHospital.value,
      "city": Get.put(RegisterController()).cityHospital.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['city']
          : Get.put(RegisterController()).cityHospital.value,
      "country": Get.put(RegisterController()).negaraHospital.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['country']
          : Get.put(RegisterController()).negaraHospital.value,
      "address": alamatHospitalC.text,
      "deviceId": "15aeqwew2113dai2j3bj2b23j32jjb23j12alldal",
      "since": tahunBerdiriHospitalC.text,
    };

    try {
      isLoading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/profile/housepital/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      final updateProfilePicCek = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$result");
      // ignore: avoid_print
      log('DAftar == $updateProfilePicCek');
      Get.back();
      if (filesHospital != null) {
        updateImageHospital(filesHospital,
            '${Get.find<JadwalSayaController>().dataHospital['userId']}');
      }
      if (fileDokumenIjinOperasional != null) {
        updateDokumenIjinOperasi(fileDokumenIjinOperasional,
            '${Get.find<JadwalSayaController>().dataHospital['userId']}');
      }
      if (fileDokumenPendukung != null) {
        updateDokumenPendukung(fileDokumenPendukung,
            '${Get.find<JadwalSayaController>().dataHospital['userId']}');
      }
      // popUpSelesai(Get.context!);
      // }
      isLoading(false);
    } on Exception catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());

      isLoading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<bool> updateImageHospital(File imageFile, String id) async {
    final String url = "${MainUrl.urlApi}hospital/photo-profile/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      log('masuuuk');
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('done Bro gagal');
      return false;
    }
  }

  Future<bool> updateDokumenIjinOperasi(File imageFile, String id) async {
    final String url = "${MainUrl.urlApi}hospital/document-license/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('done Bro gagal');
      return false;
    }
  }

  Future<bool> updateDokumenPendukung(File imageFile, String id) async {
    final String url = "${MainUrl.urlApi}hospital/document-support/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('done Bro gagal');
      return false;
    }
  }

  var fileDokumenIjinOperasional;
  pickerDokumenSuratIjinOperasinal() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    fileDokumenIjinOperasional = result.files.first;
    fileDokumenIjinOperasional = File(fileDokumenIjinOperasional.path);

    // openFile(fileDokumenIjinOperasional);
    dokumenSuratIjinOperasional.value =
        fileDokumenIjinOperasional.path.toString();
  }

  var fileDokumenPendukung;
  pickerDokumenPendukung() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    fileDokumenPendukung = result.files.first;
    fileDokumenPendukung = File(fileDokumenPendukung.path);

    // openFile(fileDokumenPendukung);
    dokumenPendukung.value = fileDokumenPendukung.path.toString();
  }
}
