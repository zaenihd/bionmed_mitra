import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zego_zimkit/compnents/messages/widgets/pick_media_button.dart';
import 'package:open_file/open_file.dart';

class RegisterHospitalController extends GetxController {
  RxBool isLoading = false.obs;
  // Controller Hospital
  TextEditingController namaHopitalC = TextEditingController();
  TextEditingController emailHopitalC = TextEditingController();
  TextEditingController alamatHospitalC = TextEditingController();
  TextEditingController detailAlamatHospitalC = TextEditingController();
  TextEditingController deskripsiHospitalC = TextEditingController();
  TextEditingController nomerHospitalC = TextEditingController(
      text: Get.find<LoginController>().controllerPhone.text);
  TextEditingController tahunBerdiriHospitalC = TextEditingController();

//Controller PIC
  TextEditingController namaOwnerC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController alamatOwnerC = TextEditingController();
  // TextEditingController controllerNomerKTP = TextEditingController();

  RxString imageUrlStr = ''.obs;
  RxString imageUrlHospital = ''.obs;
  RxString selectedStatus = ''.obs;
  RxString selectedGender = ''.obs;
  RxString dokumenPendukung = ''.obs;
  RxString dokumenSuratIjinOperasional = ''.obs;
  RxString dokumenKtp = ''.obs;
  var files;

  Future<dynamic> registerHospital({
    required String latit,
    required String longin,
    required String districts,
    required String city,
    required String country,
    required String deviceId,
    required String picLat,
    required String picLong,
    required String picDistrict,
    required String picCity,
    required String picCountry,
    required File filesPhoto,
    required File filesPhotoHospital,
    required File filesPhotoKtp,
    required File filesPhotoDocumentLicence,
    required File filesPhotoDocumentSupport,
    // required String image,
  }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": namaHopitalC.text,
      "email": emailHopitalC.text,
      "description": deskripsiHospitalC.text,
      "phoneNumber": nomerHospitalC.text,
      "lat": latit,
      "long": longin,
      "districts": districts,
      "city": city,
      "country": country,
      "address": alamatHospitalC.text,
      "deviceId": deviceId,
      "since": tahunBerdiriHospitalC.text,
      "picName": namaOwnerC.text,
      "picStatus": selectedStatus.value,
      "picBrithday": tanggalLahirC.text,
      "picGender": selectedGender.value,
      "picAddress": alamatOwnerC.text,
      "picLat": picLat,
      "picLong": picLong,
      "picDistrict": picDistrict,
      "picCity": picCity,
      "picCountry": picCountry,
      // "image" : image
    };

    try {
      isLoading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}register/hospital', Method.POST, params);
      final registerHospital = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$result");
      updateImagePic(
          filesPhoto, registerHospital['data']['userId'].toString());
      updateDokumenKtp(
          filesPhotoKtp, registerHospital['data']['userId'].toString());
      updateDokumenIjinOperasi(filesPhotoDocumentLicence,
          registerHospital['data']['userId'].toString());
      updateDokumenIjinOperasi(filesPhotoDocumentSupport,
          registerHospital['data']['userId'].toString());
      updateImageHospital(filesPhotoHospital, registerHospital['data']['userId'].toString());
      // ignore: avoid_print
      print('DAftar == $registerHospital');
      popUpSelesai(Get.context!);
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

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  popUpSelesai(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 300,
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
                          Image.asset('assets/images/terkirim.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(
                            text: 'Berhasil Terkirim',
                            size: 16,
                            weight: bold,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Data anda sudah kami terima, dan saat ini masih dalam proses. waktu maksimal 3 Hari kerja akan kami konfirmasi kembali',
                            style: TextStyle(fontSize: 12, fontWeight: light),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Selesai",
                            onTap: () {
                              Get.back();
                              Get.offAllNamed(Routes.LOGIN);

                              //   loginC.controllerPhone.clear();
                            },
                          )
                        ])
                  ]));
        });
  }
}
