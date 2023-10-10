import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/disclamer.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/verifikasi_akun/ditolak.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/verifikasi_akun/menunggu_konfirmasi.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/buat_pin.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../widget/other/show_dialog.dart';
import '../../../hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../views/verifikasi_view.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerOtp = TextEditingController();

  RxBool isloading = false.obs;
  RxBool isloadingOtp = false.obs;
  RxBool isKodeAkses = false.obs;
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
  RxInt nurseServiceId = 0.obs;
  RxString nameHospital = ''.obs;
  RxString nameService = ''.obs;
  RxString imageService = ''.obs;
  RxString descriptionNurse = ''.obs;
  final box = GetStorage();

  // ignore: prefer_typing_uninitialized_variables
  var dataUser;
  final donors = [].obs;
  final cHome = Get.put(HomeController());

  var isToLoadMore = true;
  var page = 1;

  List docterIdI = [];

  

  //===================================FCM===================
  Future<dynamic> registerTokenFirebase(String token, String id) async {
    try {
      final payload = <String, String>{
        "deviceId": token,
      };
      String url = '${MainUrl.urlApi}user-device/$id';

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(payload));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
  //===================================OTP===================
  Future<dynamic> sendOtp() async {
    // isloading(true);
    final params = <String, dynamic>{
      "phoneNumber": isKodeAkses.isTrue ? Get.put(PendapatanSaldoController()).nomerPhoneCodeAksesC.text : phoneNumberUser.value,
      "type": role.value
    };
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}otp/get', Method.POST, params);
      // ignore: unused_local_variable
      var sendOtp = json.decode(result.toString());
      log(sendOtp.toString());

      // }
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

  Future<dynamic> verifyOtp() async {
    isloadingOtp(true);
    final params = <String, dynamic>{
      "phoneNumber": isKodeAkses.isTrue ? Get.put(PendapatanSaldoController()).nomerPhoneCodeAksesC.text : phoneNumberUser.value,
      "type": role.value,
      "otp": controllerOtp.text
    };
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}otp/verify', Method.POST, params);
      // ignore: unused_local_variable
      var verifi = json.decode(result.toString());
      if (verifi['verifyOtp'] == true) {
        if (isKodeAkses.isFalse) {
          box.write('phone', phoneNumberUser.value);
          // Get.toNamed(Routes.BOTTOM_NAVIGATION);
          Get.to(() => Disclamer());
          controllerOtp.clear();
          if (role.value == "hospital") {
            if (dataUser['hospital']['hospital_services'].toString() == "[]") {
              lengkapiProfil(Get.context!);
            }
          } else if (role.value == "nurse") {
            if (dataUser['nurse']['nurse_educations'].toString() == "[]" &&
                    dataUser['nurse']['verifiedStatus'] == 1 ||
                dataUser['nurse']['nurse_educations'].toString() == "[]" &&
                    dataUser['nurse']['verifiedStatus'] == 1) {
              lengkapiProfil(Get.context!);
            }
          } else if (role.value == "doctor") {
            if (isVerifi.value == false) {
              lengkapiProfil(Get.context!);
            }
          }
        } else {
          Get.to(() => BuatPinSaldo());
        }
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          content: const Text('Kode OTP salah'),
          backgroundColor: (Colors.red),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }

      // }
      isloadingOtp(false);
    } on Exception catch (e) {
      isloadingOtp(false);

      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

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
        balance.value = donors['data']['doctor']['balance'] ?? 0;
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
        String? tokens = await FirebaseMessaging.instance.getToken();
        registerTokenFirebase(tokens!, id.toString());


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
              // box.write('phone', phoneNumber);
              Get.toNamed(Routes.BOTTOM_NAVIGATION);
              if (isVerifi.value == false) {
                // lengkapiProfil(Get.context!);
              }
            }
          } else {
            if (donors['data']['doctor']['verifiedStatus'] == 0) {
              Get.to(() => MenungguKonfirmasi());
            } else if (donors['data']['doctor']['verifiedStatus'] == 1) {
              await sendOtp();
              Get.to(() => VerifikasiView());
              // box.write('phone', phoneNumber);

              // Get.to(() => Disclamer());

              if (isVerifi.value == false) {
                // Get.defaultDialog();
                // lengkapiProfil(Get.context!);
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
  RxString namePic = ''.obs;
  RxString imagePic = ''.obs;
  RxString inHospital = "dokter".obs;
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
        inHospital.value = "'dokter'";

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
        rating = dataNurse['data']['nurse']['rating'] ?? 0;
        inHospital.value =
            dataNurse['data']['nurse']['hospital'] == null ? "0" : '';
        nurseServiceId.value =
            dataNurse['data']['nurse']['nurse_services'][0]['serviceId'] ?? 0;
        nameService.value = dataNurse['data']['nurse']['nurse_services'][0]
                ['service']['name'] ??
            "";
        imageService.value = dataNurse['data']['nurse']['nurse_services'][0]
                ['service']['image'] ??
            "";
        nameHospital.value =
            dataNurse['data']['nurse']['hospital'].toString() == "null"
                ? ""
                : dataNurse['data']['nurse']['hospital']['name'];
        descriptionNurse.value =
            dataNurse['data']['nurse']['description'] ?? "";
        Get.put(JadwalSayaController()).profileImagePic.value =
            dataNurse['data']['nurse']['hospital'].toString() == "null"
                ? ""
                : dataNurse['data']['nurse']['hospital']['picImage'];
        Get.put(JadwalSayaController()).namePic.value =
            dataNurse['data']['nurse']['hospital'].toString() == "null"
                ? ""
                : dataNurse['data']['nurse']['hospital']['picName'] ?? "";
        log('nurse Hospital $inHospital');
        var setuju = await box.read('rememberme');
         String? tokens = await FirebaseMessaging.instance.getToken();
        registerTokenFirebase(tokens!, id.toString());

        if (setuju == true) {
          if (dataNurse['data']['nurse']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else {
            log('KOK MASUK SINI SIIH? $inHospital');
            // box.write('phone', phoneNumber);
            Get.toNamed(Routes.BOTTOM_NAVIGATION);
          }
        } else {
          if (dataNurse['data']['nurse']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else if (dataNurse['data']['nurse']['verifiedStatus'] == 1) {
            // box.write('phone', phoneNumber);
            // Get.to(() => Disclamer());
            await sendOtp();
            Get.to(() => VerifikasiView());
          } else {
            Get.to(() => Ditolak());
          }
        }
        if (inHospital.value != "0") {
        } else {
          if (dataNurse['data']['nurse']['nurse_educations'].toString() ==
                      "[]" &&
                  dataNurse['data']['nurse']['verifiedStatus'] == 1 ||
              dataNurse['data']['nurse']['nurse_educations'].toString() ==
                      "[]" &&
                  dataNurse['data']['nurse']['verifiedStatus'] == 1) {
            // lengkapiProfil(Get.context!);
          }
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
    Get.put(LengkapiDataHospitalController()).isFromProfile.value = false;

    final box = GetStorage();

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      log('${MainUrl.urlApi}login/nurse');

      var result = await RestClient()
          .request('${MainUrl.urlApi}login/hospital', Method.POST, params);
      final dataHospital = json.decode(result.toString());

      if (dataHospital['code'] == 200) {
        inHospital.value = "hospital";
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
         String? tokens = await FirebaseMessaging.instance.getToken();
        registerTokenFirebase(tokens!, id.toString());

        if (setuju == true) {
          if (dataHospital['data']['hospital']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else {
            // box.write('phone', phoneNumber);
            Get.toNamed(Routes.BOTTOM_NAVIGATION);
          }
        } else {
          if (dataHospital['data']['hospital']['verifiedStatus'] == 0) {
            Get.to(() => MenungguKonfirmasi());
          } else if (dataHospital['data']['hospital']['verifiedStatus'] == 1) {
            // box.write('phone', phoneNumber);
            // Get.to(() => Disclamer());
            await sendOtp();
            Get.to(() => VerifikasiView());
          } else {
            Get.to(() => Ditolak());
          }
        }
        if (dataHospital['data']['hospital']['hospital_services'].toString() ==
            "[]") {
          // lengkapiProfil(Get.context!);
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

  //------------------------------------------LOGIN APP HOSPITAL -------------------------------------------
  // RxInt isVerifikasiNurse = 0.obs;
  // RxList nurseEducation = [].obs;
  Future<dynamic> loginAmbulance(
      {required String phoneNumber, bool? isSplash}) async {
    final map = <String, dynamic>{};
    map['page'] = page;
    isloading(true);
    Get.put(LengkapiDataHospitalController()).isFromProfile.value = false;

    final box = GetStorage();

    final params = <String, dynamic>{"phoneNumber": phoneNumber};
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}login/ambulance', Method.POST, params);
      final dataAmbulance = json.decode(result.toString());

      if (dataAmbulance['code'] == 200) {
        Get.put(JadwalSayaController()).serviceId.value =
            dataAmbulance['data']['ambulance']['serviceId'];
        nurseServiceId.value = dataAmbulance['data']['ambulance']['serviceId'];
        // log('service ID ${Get.put(JadwalSayaController()).serviceId.value}');÷
        log('service ID ${Get.put(PaketLayananNurseController()).serviceIdNurse.value}');
        inHospital.value = "ambulance";
        id = dataAmbulance['data']['id'];
        cHome.dataUser = dataAmbulance['data'];
        dataUser = dataAmbulance['data'];
        name.value = dataAmbulance['data']['ambulance']['name'];
        role.value = dataAmbulance['data']['role'];
        idLogin = dataAmbulance['data']['ambulance']['id'];
        userIdLogin = dataAmbulance['data']['ambulance']['userId'];
        phoneNumberUser.value = dataAmbulance['data']['phoneNumber'];
        address.value = dataAmbulance['data']['ambulance']['address'];
        lat.value = dataAmbulance['data']['ambulance']['lat'].toString();
        long.value = dataAmbulance['data']['ambulance']['long'].toString();
        rating = dataAmbulance['data']['ambulance']['rating'];
        inHospital.value =
            dataAmbulance['data']['ambulance']['hospital'] == null ? "0" : '';
        var setuju = await box.read('rememberme');
         String? tokens = await FirebaseMessaging.instance.getToken();
        registerTokenFirebase(tokens!, id.toString());

        // if (setuju == true) {
        //   if (dataAmbulance['data']['ambulance']['verifiedStatus'] == 0) {
        //     Get.to(() => MenungguKonfirmasi());
        //   } else {
        //     Get.toNamed(Routes.BOTTOM_NAVIGATION);
        //   }
        // } else {
        //   if (dataAmbulance['data']['ambulance']['hospital']['verifiedStatus'] == 0) {
        //     Get.to(() => MenungguKonfirmasi());
        //   } else if (dataAmbulance['data']['ambulance']['hospital']['verifiedStatus'] == 1) {
        //     box.write('phone', phoneNumber);
        //     Get.to(() => Disclamer());
        //   } else {
        //     Get.to(() => Ditolak());
        //   }
        // }
        if (setuju != true) {
          await sendOtp();
          Get.to(() => VerifikasiView());
          // box.write('phone', phoneNumber);

          // Get.toNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          Get.toNamed(Routes.BOTTOM_NAVIGATION);
        }

        // if (dataAmbulance['data']['ambulance']['hospital_services'].toString() !=
        //     "[]") {
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
                              if (role.value == "hospital") {
                                Get.toNamed(Routes.LENGKAPI_DATA_HOSPITAL);
                              } else {
                                Get.toNamed(Routes.LENGKAPI_PROFIL);
                              }
                            },
                          )
                        ])
                  ]));
        });
  }
}
