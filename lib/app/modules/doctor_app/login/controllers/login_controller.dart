import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/disclamer.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/verifikasi_akun/ditolak.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/verifikasi_akun/menunggu_konfirmasi.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../widget/other/show_dialog.dart';
import '../../home/controllers/home_controller.dart';

class LoginController extends GetxController {
  final TextEditingController controllerPhone = TextEditingController();

  RxBool isloading = false.obs;
  RxString name = "".obs;
  RxString image = "".obs;
  RxString birthDay = "".obs;
  RxString experience = "".obs;
  RxString strNumber = "".obs;
  RxString spesialis = "".obs;
  RxString doctorIdImage = ''.obs;
  RxString phoneNumberUser = ''.obs;
  RxString address = ''.obs;
  RxBool rememberme = false.obs;
  int docterId = 0;
  int idLogin = 0;
  int userIdLogin = 0;
  int rating = 0;
  RxInt balance = 0.obs;
  RxBool isVerifi = false.obs;
  int id = 0;
  RxString jenisKelamin = "".obs;
  RxList dataDokter = [].obs;
  RxList dataService = [].obs;
  RxString lat = ''.obs;
  RxString long = ''.obs;
  RxString role = ''.obs;
  RxInt idAccount = 0.obs;
  // ignore: prefer_typing_uninitialized_variables
  var dataUser;
  final donors = [].obs;
  final cHome = Get.put(HomeController());

  var isToLoadMore = true;
  var page = 1;

  List docterIdI = [];

  //Login To API

  Future<dynamic> loginV2({required String phoneNumber, bool? isSplash}) async {
    final map = <String, dynamic>{};
    map['page'] = page;
    isloading(true);

    final box = GetStorage();

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/doctor', Method.POST, params);
      final donors = json.decode(result.toString());

      // if (donors['code'] == 200)
      if (donors['data']['doctor'] != null) {
        // if (donors['code'] == 200) {
        id = donors['data']['id'];
        role.value = donors['data']['role'];
        cHome.dataUser = donors['data'];
        dataUser = donors['data'];
        name.value = donors['data']['doctor']['name'];
        birthDay.value = donors['data']['doctor']['brithdayDate'];
        experience.value = donors['data']['doctor']['experience'];
        strNumber.value = donors['data']['doctor']['strNumber'];
        rating = donors['data']['doctor']['rating'];
        image.value = donors['data']['doctor']['image'];
        idLogin = donors['data']['doctor']['id'];
        userIdLogin = donors['data']['doctor']['userId'];
        balance.value = donors['data']['doctor']['balance'];
        phoneNumberUser.value = donors['data']['phoneNumber'];
        isVerifi.value = donors['isVerification'];
        address.value = donors['data']['doctor']['address'];
        jenisKelamin.value = donors['data']['doctor']['gender'];
        dataDokter.value = donors['data']['doctor']['doctor_schedules'];
        lat.value = donors['data']['doctor']['lat'].toString();
        long.value = donors['data']['doctor']['long'].toString();
        dataService.value = donors['data']['doctor']['doctor_services'];

        // ignore: avoid_print, invalid_use_of_protected_member
        print('jauh${dataService.value}');

        // print("sasasasas" + idLogin.toString());

        if (donors['data']['doctor']['doctor_services'].toString() == "[]") {
          showPopUp(
              onTap: () {
                Get.back();
              },
              imageAction: 'assets/json/eror.json',
              description: "Data belum lengkap\n Lengkapi data anda",
              onPress: () {
                Get.toNamed(Routes.LAYANAN);
              });
          // Get.toNamed(Routes.LAYANAN);
        } else if (donors['data']['doctor']['specialist'] == null) {
          showPopUp(
              onTap: () {
                Get.back();
              },
              imageAction: 'assets/json/eror.json',
              description: "Data belum lengkap\n Lengkapi data anda",
              onPress: () {
                Get.toNamed(Routes.PILIH_SPESIALIS);
              });
        } else {
          spesialis.value = donors['data']['doctor']['specialist']['name'];
          var setuju = await box.read('rememberme');

          if (setuju == true) {
            if (donors['data']['doctor']['verifiedStatus'] == 0) {
              Get.to(() => MenungguKonfirmasi());
            } else {
              box.write('phone', phoneNumber);
              Get.toNamed(Routes.BOTTOM_NAVIGATION);
              if (isVerifi.value == false) {
                lengkapiProfil(Get.context!);
              }
            }
          } else {
            if (donors['data']['doctor']['verifiedStatus'] == 0) {
              Get.to(() => MenungguKonfirmasi());
            } else if (donors['data']['doctor']['verifiedStatus'] == 1) {
              box.write('phone', phoneNumber);
              Get.to(() => Disclamer());
              if (isVerifi.value == false) {
                // Get.defaultDialog();
                lengkapiProfil(Get.context!);
              }
            } else {
              Get.to(() => Ditolak());
            }
          }
        }

        if (donors['data']['doctor']['doctor_schedules'].toString() != '[]') {
          docterId =
              donors['data']['doctor']['doctor_schedules'][0]['doctorId'];
        }
      }

      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("JAJAJAJAJAJA$e");
      isloading(false);
      if (isSplash == true) {
        Get.offAllNamed(Routes.ACCOUNT);
      } else {
        showPopUp(
            onTap: () {
              Get.back();
            },
            imageAction: 'assets/json/eror.json',
            description: "Nomer tidak ditemukan\n Daftarkan nomer anda",
            onPress: () {
              if (idAccount.value == 1) {
                Get.toNamed(Routes.REGISTER);
              } else {
                Get.toNamed(Routes.REGISTER_PERAWAT);
              }
            });
      }
    }
  }

  //------------------------------------------LOGIN APP NURSE -------------------------------------------
  RxInt isVerifikasiNurse = 0.obs;
  RxList nurseEducation = [].obs;
  Future<dynamic> loginNurse(
      {required String phoneNumber, bool? isSplash}) async {
    final map = <String, dynamic>{};
    map['page'] = page;
    isloading(true);

    final box = GetStorage();

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      log('${MainUrl.urlApi}login/nurse');

      var result = await RestClient()
          .request('${MainUrl.urlApi}login/nurse', Method.POST, params);
      final dataNurse = json.decode(result.toString());

      if (dataNurse['code'] == 200) {
        id = dataNurse['data']['id'];
        cHome.dataUser = dataNurse['data'];
        dataUser = dataNurse['data'];
        name.value = dataNurse['data']['nurse']['name'];
        role.value = dataNurse['data']['role'];
        strNumber.value = dataNurse['data']['nurse']['register_number_nurse'];
        idLogin = dataNurse['data']['nurse']['id'];
        userIdLogin = dataNurse['data']['nurse']['userId'];
        phoneNumberUser.value = dataNurse['data']['phoneNumber'];
        address.value = dataNurse['data']['nurse']['address'];
        jenisKelamin.value = dataNurse['data']['nurse']['gender'];
        lat.value = dataNurse['data']['nurse']['lat'].toString();
        long.value = dataNurse['data']['nurse']['long'].toString();
        nurseEducation.value = dataNurse['data']['nurse']['nurse_educations'];
        rating = dataNurse['data']['nurse']['rating'];
        var setuju = await box.read('rememberme');

        if (setuju == true) {
          if (dataNurse['data']['nurse']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else {
            box.write('phone', phoneNumber);
            Get.toNamed(Routes.BOTTOM_NAVIGATION);
          }
        } else {
          if (dataNurse['data']['nurse']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else if (dataNurse['data']['nurse']['verifiedStatus'] == 1) {
            box.write('phone', phoneNumber);
            Get.to(() => Disclamer());
          } else {
            Get.to(() => Ditolak());
          }
        }
        if (dataNurse['data']['nurse']['nurse_educations'].toString() == "[]" &&
                dataNurse['data']['nurse']['verifiedStatus'] == 1 ||
            dataNurse['data']['nurse']['nurse_educations'] == null &&
                dataNurse['data']['nurse']['verifiedStatus'] == 1) {
          lengkapiProfil(Get.context!);
        }
      } else {}
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("JAJAJAJAJAJA$e");

      isloading(false);
      if (isSplash == true) {
        Get.offAllNamed(Routes.ACCOUNT);
      } else {
        showPopUp(
            onTap: () {
              Get.back();
            },
            imageAction: 'assets/json/eror.json',
            description: "Nomer tidak ditemukan\n Daftarkan nomer anda",
            onPress: () {
              if (idAccount.value == 1) {
                Get.toNamed(Routes.REGISTER);
              } else {
                Get.toNamed(Routes.REGISTER_PERAWAT);
              }
            });
      }
    }
  }

  //------------------------------------------LOGIN APP HOSPITAL -------------------------------------------
  // RxInt isVerifikasiNurse = 0.obs;
  // RxList nurseEducation = [].obs;
  Future<dynamic> loginHospital(
      {required String phoneNumber, bool? isSplash}) async {
    final map = <String, dynamic>{};
    map['page'] = page;
    isloading(true);

    final box = GetStorage();

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      log('${MainUrl.urlApi}login/nurse');

      var result = await RestClient()
          .request('${MainUrl.urlApi}login/hospital', Method.POST, params);
      final dataHospital = json.decode(result.toString());

      if (dataHospital['code'] == 200) {
        id = dataHospital['data']['id'];
        cHome.dataUser = dataHospital['data'];
        dataUser = dataHospital['data'];
        name.value = dataHospital['data']['hospital']['name'];
        role.value = dataHospital['data']['role'];
        idLogin = dataHospital['data']['hospital']['id'];
        userIdLogin = dataHospital['data']['hospital']['userId'];
        phoneNumberUser.value = dataHospital['data']['phoneNumber'];
        address.value = dataHospital['data']['hospital']['address'];
        lat.value = dataHospital['data']['hospital']['lat'].toString();
        long.value = dataHospital['data']['hospital']['long'].toString();
        rating = dataHospital['data']['hospital']['rating'];
        var setuju = await box.read('rememberme');

        if (setuju == true) {
          if (dataHospital['data']['hospital']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else {
            box.write('phone', phoneNumber);
            Get.toNamed(Routes.BOTTOM_NAVIGATION);
          }
        } else {
          if (dataHospital['data']['hospital']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else if (dataHospital['data']['hospital']['verifiedStatus'] == 1) {
            box.write('phone', phoneNumber);
            Get.to(() => Disclamer());
          } else {
            Get.to(() => Ditolak());
          }
        }
        // if (dataHospital['data']['hospital']['hospital_educations'].toString() == "[]" &&
        //         dataHospital['data']['hospital']['verifiedStatus'] == 1 ||
        //     dataHospital['data']['hospital']['hospital_educations'] == null &&
        //         dataHospital['data']['hospital']['verifiedStatus'] == 1) {
        //   lengkapiProfil(Get.context!);
        // }
      } else {}
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("JAJAJAJAJAJA$e");

      isloading(false);
      if (isSplash == true) {
        Get.offAllNamed(Routes.ACCOUNT);
      } else {
        showPopUp(
            onTap: () {
              Get.back();
            },
            imageAction: 'assets/json/eror.json',
            description: "Nomer tidak ditemukan\n Daftarkan nomer anda",
            onPress: () {
              Get.toNamed(Routes.REGISTER_HOSPITAL);
              // if (idAccount.value == 1) {
              //   Get.toNamed(Routes.REGISTER);
              // } else {
              //   Get.toNamed(Routes.REGISTER_PERAWAT);
              // }
            });
      }
    }
  }

  Future<dynamic> lengkapiProfil(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 380,
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
                          Image.asset('assets/icon/icon_lengkapi_profil.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Lengkapi Data',
                            style: blackTextStyle.copyWith(
                                fontWeight: bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Lengkapi data anda untuk menginformasikan\njadwal praktek',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Lengkapi Sekarang",
                            onTap: () {
                              Get.toNamed(Routes.LENGKAPI_PROFIL);
                            },
                          )
                        ])
                  ]));
        });
  }
}
