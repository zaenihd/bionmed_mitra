import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/paket_layanan_controller.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';

class ProfilePaketLayananController extends GetxController {
  TextEditingController minute = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController diskon = TextEditingController();
  //--------------------DOCTOR ON CALL-------------------

  // text: price.value.toString()
  // text: diskonHomeValue.value.toString()
  RxList listPaket = [].obs;
  RxList listTotalHarga = [].obs;

  RxDouble totalHarga = 0.0.obs;
  RxDouble totalHargaHome = 0.0.obs;
  RxDouble totalHargaAfterDiscount = 0.0.obs;
  RxInt hargaPaket = 0.obs;
  RxInt price = 0.obs;
  RxInt diskonHomeValue = 0.obs;
  RxBool buatDiskon = false.obs;
  RxBool buatPaket = false.obs;
  RxBool isLoading = false.obs;
  RxString hargaCurrens = "".obs;

  TextEditingController hargaHome = TextEditingController();
  TextEditingController diskonHome = TextEditingController();

  //-------------GET DATA DETAIL SERVICE--------------
  RxList dataDetailService = [].obs;
  RxInt code = 0.obs;
  Future<dynamic> getDetailService() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}package/${Get.find<PaketLayananController>().idService}/${Get.find<LoginController>().idLogin}',
          Method.GET,
          params);
      final serviceDetail = json.decode(result.toString());
      // data.value = tiket['data'];
      dataDetailService.value = serviceDetail['data'];
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //---------------------------TAMBAHKAN PAKET LAYANAN--------------------
  RxList listPaketLayanan = [].obs;

  Future<dynamic> postEditLayanan({
    required List listPaketLayanan,
  }) async {
    final params = <String, dynamic>{
      "request": listPaketLayanan,
    };

    try {
      isLoading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}package/${Get.find<PaketLayananController>().idService}/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      final layanan = json.decode(result.toString());
      // ignore: avoid_print
      print('aze$layanan');
      Get.back();
      Get.back();
      // if (layanan['code'] == 200) {
      //   // ignore: avoid_print
      //   // Get.defaultDialog();
      //   Get.back();
      //   Get.back();
      // } else {}
      isLoading(false);
      return layanan;
      // }
    } on Exception catch (e) {
      log('ERROR NIH == $e');
      showPopUp(
          onTap: () {
            Get.back();
          },
          imageAction: 'assets/json/eror.json',
          description:
              "Tidak bisa merubah paket yang sudah di pesan oleh pasien!",
          onPress: () {
            Get.back();
            // Get.toNamed(Routes.LAYANAN);
          });
      isLoading(false);

      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  void onInit() async {
    await getDetailService();

    listPaketLayanan.value = dataDetailService;
    // price.value = dataDetailService[0]['price'];
    // diskonHomeValue.value = dataDetailService[0]['discount'];
    totalHargaHome.value = dataDetailService[0]['price'] -
        (dataDetailService[0]['price'] *
            dataDetailService[0]['discount'] /
            100);

    hargaHome.text = dataDetailService.isEmpty
        ? "0"
        : dataDetailService[0]['price'].toString();
    diskonHome.text = dataDetailService.isEmpty
        ? "0"
        : dataDetailService[0]['discount'].toString();

    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    hargaHome.dispose();
    diskonHome.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }
}
