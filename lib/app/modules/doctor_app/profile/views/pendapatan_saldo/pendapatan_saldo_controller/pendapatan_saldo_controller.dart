import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_doctor_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_nurse_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/buat_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PendapatanSaldoController extends GetxController {
  //BUAT PIN
  RxString kodePinView = ''.obs;
  RxList kodePin = [].obs;
  RxBool isHiddenPin = true.obs;
  TextEditingController kodePinC = TextEditingController();
  //BUAT PIN AKSES
  RxString kodePinViewAkses = ''.obs;
  RxList kodePinAkses = [].obs;
  RxBool isHiddenPinAksesCheck = true.obs;
  TextEditingController kodePinAksesC = TextEditingController();

  //KONFIRMASI PIN
  RxString kodePinViewKonfirmasi = ''.obs;
  RxList kodePinKonfirmasi = [].obs;
  RxBool isHiddenPinKonfirmasi = true.obs;
  TextEditingController kodePinKonformasiC = TextEditingController();
  //
  RxBool isHiddenPinAkses = true.obs;
  RxBool isLoading = false.obs;
  RxBool isWithDraw = false.obs;
  TextEditingController nomerPhoneCodeAksesC = TextEditingController(
      text: Get.find<LoginController>().phoneNumberUser.value);
  TextEditingController kodePinEditC = TextEditingController();
  TextEditingController kodePinKonfirmasiEditC = TextEditingController();
      //======
  final controllerNurse = Get.find<SaldoDanRekeningNurseController>();
  final controllerDoctor = Get.find<SaldoDanRekeningDoctorController>();
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  var now = DateTime.now();

  Future<dynamic> buatPin() async {
    final params = <String, dynamic>{
      "hospitalId": Get.find<LoginController>().idLogin,
      "codeAccess": kodePinViewKonfirmasi.value
    };
    isLoading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/codeaccess/update', Method.POST, params);

      final updateKodePin = json.decode(result.toString());
      // ignore: avoid_print
      log("cek update $updateKodePin");
      isLoading(false);

      return updateKodePin;
      // }
    } on Exception catch (e) {
      isLoading(false);
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: e.toString());
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> checkPin() async {
    final params = <String, dynamic>{
      "hospitalId": Get.find<LoginController>().idLogin,
      "phoneNumber": Get.find<LoginController>().phoneNumberUser.value,
      "codeAccess": kodePinView.value
    };
    isLoading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/codeaccess/check', Method.POST, params);

      final checkKodePin = json.decode(result.toString());
      if (checkKodePin['code'] == 200) {
        await controllerNurse.sendWithDrawHospital(
            date: formatter.format(now.toLocal()).toString(),
            nurseBankId: controllerDoctor.bankId.value,
            amount: controllerDoctor.saldoTarikCurren.value);
        // ignore: prefer_interpolation_to_compose_strings
        log('====> ZEZEN ' +
            controllerDoctor.bankId.value.toString() +
            "saldooo " +
            controllerDoctor.saldoTarikCurren.value.toString());
        controllerDoctor.nominalSaldoTarikController.clear();
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          content: const Text('Berhasil Mengirim Permintaan Penarikan Saldo'),
          backgroundColor: (Colors.green),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        Get.back();
        Get.back();
        isWithDraw.value = false;
      }

      // ignore: avoid_print
      log("cek update $checkKodePin");
      isLoading(false);

      return checkKodePin;
      // }
    } on Exception catch (e) {
      isLoading(false);
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: "Code Not Same!");
      // ignore: avoid_print
      print(e.toString());
    }
  }
  Future<dynamic> checkPinEditPin() async {
    final params = <String, dynamic>{
      "hospitalId": Get.find<LoginController>().idLogin,
      "phoneNumber": Get.find<LoginController>().phoneNumberUser.value,
      "codeAccess": kodePinView.value
    };
    isLoading(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}hospital/codeaccess/check', Method.POST, params);

      final checkKodePin = json.decode(result.toString());
      if (checkKodePin['code'] == 200) {
     Get.to(()=>BuatPinSaldo());
      }

      // ignore: avoid_print
      log("cek update $checkKodePin");
      isLoading(false);

      return checkKodePin;
      // }
    } on Exception catch (e) {
      isLoading(false);
      Get.defaultDialog(title: "Terjadi Kesalahan", middleText: "Code Not Same!");
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
