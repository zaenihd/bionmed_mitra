import 'dart:convert';
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


class RegisterHospitalController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController namaHospitalC = TextEditingController();
  TextEditingController emailHospitalC = TextEditingController();
  TextEditingController nomerHospitalC = TextEditingController(text: Get.find<LoginController>().controllerPhone.text);
  TextEditingController alamatHospitalC = TextEditingController();
  TextEditingController controlleragama = TextEditingController();
  TextEditingController informasiHospitalC= TextEditingController();
  RxString imageUrlStr = ''.obs;
  
  Future<dynamic> registerHospital(
      {required String name,
      required String email,
      required String phoneNumber,
      required String description,
      required String latit,
      required String longin,
      required String districts,
      required String city,
      required String country,
      required String address,
      required String deviceId,
      File? files,
      // required String image,
      }) async {
    // isloading(true);
    final params = <String, dynamic>{
      "name": name,
      "email": email,
      "description" : description,
      "phoneNumber": phoneNumber,
      "lat" :latit,
      "long" :longin,
      "districts" : districts,
      "city" :city,
      "country" :country,
      "address": address,
      "deviceId": deviceId,
      // "image" : image
    };
    
    try {
      isLoading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}register/hospital', Method.POST, params);
      final registerHospital = json.decode(result.toString());
      // ignore: avoid_print
      print("cekk1$result");
      updateImage(files!, registerHospital['data']['userId'].toString());
      // ignore: avoid_print
      print('DAftar == $registerHospital');
      popUpSelesai(Get.context!);
      // }
      isLoading(false);
    } on Exception catch (e) {
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText:e.toString() );

      isLoading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<bool> updateImage(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}hospital/photo-profile/$id";
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
