import 'dart:convert';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';
import '../../register/controllers/register_controller.dart';

class LayananController extends GetxController {
  final registerC = Get.put(RegisterController());
  final loginC = Get.put(LoginController());
  RxList<dynamic> dataCount = [].obs;
  RxBool load = false.obs;
  RxInt layananTerpilih = 0.obs;
  RxList choiceService = [].obs;
  RxList tampunganLayanan = [].obs;

  counter(indexs, surah) async {
    load(true);
    for (var i = 0; i < dataCount.length; i++) {
      choiceService.clear();
      if (dataCount[i]['index'] == indexs) {
        dataCount[i]['value'] = true.obs;
        choiceService.add(surah);
        layananTerpilih.value = layananTerpilih.value + choiceService.length;
        load(false);
      }
    }
  }

  counterMin(indexs, surah) async {
    load(true);
    for (var i = 0; i < dataCount.length; i++) {
      if (dataCount[i]['index'] == indexs) {
        dataCount[i]['value'] = false.obs;
        // choiceService.removeWhere((element) => element ['index'] );
        layananTerpilih.value = layananTerpilih.value - 1;
        // ignore: invalid_use_of_protected_member
        tampunganLayanan.value.remove(indexs);

        load(false);

      }
    }
  }

  final servis = [].obs;
  RxList services = [].obs;
  RxBool selected = false.obs;
  Map<String, dynamic> serviceSelected = {};
  RxBool isloading = false.obs;

  Future<dynamic> service() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}services', Method.GET, params);
      final servis = json.decode(result.toString());
      services.value = servis['data'];
      for (var i in services) {
        dataCount.add({"index": i['id'], "value": false});
      }
      // ignore: invalid_use_of_protected_member
      services.value = services.value.where((element) => element['sequence'] == 1 || element['sequence'] == 2 ).toList();

      if (servis['code'] == 200) {
        // ignore: prefer_interpolation_to_compose_strings, avoid_print, invalid_use_of_protected_member
        print('haz = ' + dataCount.value.toString() );
        isloading(false);
        // print("yu atu bisa atuuu ++++====" + sukum.toString());

      }

      //  final regis = json.decode(result.toString());
      // print("yu atu bisa" + servis.toString());
      // print("yu atu bisa atuuu" + servis.toString());
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  final layanan = [].obs;
  var isToLoadMore = true;
  var page = 1;

  Future<dynamic> addService({
    required List serviceId,
  }) async {
    final params = <String, dynamic>{
      "serviceId": serviceId,
    };

    try {
      isloading(true);
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/service/${registerC.registData}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final layanan = json.decode(result.toString());
      isloading(false);
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    // Jika Register belum selesai

    try {
      final resultLogin = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/service/${loginC.idLogin}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final layananLogin = json.decode(resultLogin.toString());

      // print("yu atu bisa masuk service" + result.toString());
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> checkLayanan() async {
    load(true);
    final result = await RestClient().request(
        '${MainUrl.urlApi}doctor/data/service/${loginC.idLogin}',
        Method.GET, {});
    final layanan = json.decode(result.toString());
    load(false);

    tampunganLayanan.value = layanan['data'];
    
    return layanan['data'];
  }

  @override
  void onInit() {
    service();
    super.onInit();
  }

  @override
  void onClose() {
    service();
    super.onClose();
  }
}
