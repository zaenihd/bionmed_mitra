import 'dart:convert';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class PaketLayananController extends GetxController {
   //-------------GET DATA SERVICE--------------
   RxBool isLoading = false.obs;
  RxList datService = [].obs;
  RxInt idService = 0.obs;
  RxString nameService = "".obs;
  RxInt sequenceId= 0.obs;
  Future<dynamic> getDataService() async {
    final params = <String, dynamic>{};
    // ${Get.find<LoginController>().idPengguna}

    try {
      isLoading(true);
      final result = await RestClient()
          .request('${MainUrl.urlApi}package/${Get.find<LoginController>().idLogin}', Method.GET, params);
      final service = json.decode(result.toString());
      // data.value = tiket['data'];
      datService.value = service['data'];

      isLoading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}