import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditProfileOwnerHospitalController extends GetxController {
  TextEditingController namaOwnerC = TextEditingController(
      text: Get.find<JadwalSayaController>().namePic.value);
  TextEditingController tanggalLahirC = TextEditingController(
      text: Get.find<JadwalSayaController>().tanggalLahirPicHospital.value);
  TextEditingController alamatOwnerC = TextEditingController(
      text: Get.find<JadwalSayaController>().addressPicHospital.value);
  var files;
  RxString selectedStatus = "".obs;
  RxString selectedGender = ''.obs;
  RxString dokumenKtp = ''.obs;
  RxString imageUrlStr = ''.obs;
  RxBool isLoading = false.obs;

  var fileDokumenKtp;
  pickerDokumenKtp() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    ///File file = File(platformFile.path);
    fileDokumenKtp = result.files.first;
    fileDokumenKtp = File(fileDokumenKtp.path);
    log(fileDokumenKtp.runtimeType.toString());
    // openFile(fileDokumenKtp);
    dokumenKtp.value = fileDokumenKtp.path.toString();
  }

  Future<dynamic> updateProfilePic() async {
    // isloading(true);
    final params = <String, dynamic>{
      "picName": namaOwnerC.text,
      "picStatus": selectedStatus.value,
      "picBrithday": tanggalLahirC.text,
      "picGender": selectedGender.value,
      "picAddress": alamatOwnerC.text,
      "picLat": Get.put(RegisterController()).lat.value.toString() == "0.0"
          ? Get.find<JadwalSayaController>().dataHospital['picLat'].toString()
          : Get.put(RegisterController()).lat.value.toString(),
      "picLong": Get.put(RegisterController()).long.value.toString() == "0.0"
          ? Get.find<JadwalSayaController>().dataHospital['picLong'].toString()
          : Get.put(RegisterController()).long.value.toString(),
      "picDistrict": Get.put(RegisterController()).kecamatan.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['picDistrict']
          : Get.put(RegisterController()).kecamatan.value,
      "picCity": Get.put(RegisterController()).city.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['picCity']
          : Get.put(RegisterController()).city.value,
      "picCountry": Get.put(RegisterController()).negara.value == ""
          ? Get.find<JadwalSayaController>().dataHospital['picCountry']
          : Get.put(RegisterController()).negara.value
    };

    try {
      isLoading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/profile/owner/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      final updateProfilePicCek = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$result");
      // ignore: avoid_print
      log('DAftar == $updateProfilePicCek');
      Get.back();
      if (fileDokumenKtp != null) {
        updateDokumenKtp(
            fileDokumenKtp, '${Get.find<JadwalSayaController>().dataHospital['userId']}');
      }
      if(files !=null){
        updateImagePic(files, '${Get.find<JadwalSayaController>().dataHospital['userId']}');
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

  Future<bool> updateImagePic(File imageFile, String id) async {
    final String url = "${MainUrl.urlApi}hospital/pic-profile/$id";
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

  Future<bool> updateDokumenKtp(File imageFile, String id) async {
    final String url = "${MainUrl.urlApi}hospital/pic-ktp/$id";
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
}
