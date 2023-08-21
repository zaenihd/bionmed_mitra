import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:get/get.dart';


class ListServiceNurseController extends GetxController {
  RxList listServiceNurseData = [].obs;
  RxBool isLoading = false.obs;
  RxBool serviceDone = false.obs;
  RxBool jadwalDone = false.obs;

  Future<dynamic> listServiceNurse() async {
    // isLoading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse-service', Method.GET, params);
      var serviceNurse = json.decode(result.toString());
      listServiceNurseData.value = serviceNurse['data'];
      log(listServiceNurseData.toString());

      // isLoading(false);
    } on Exception catch (e) {
      // isLoading(false);

      // ignore: avoid_print
      print("Cek error pesan haha $e");
    }
  }
}
