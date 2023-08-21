import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:get/get.dart';


class PesananMasukPerawatController extends GetxController {
  RxInt start = 60.obs;
  RxBool stopTime = false.obs;

   
   
  startCountingAcceptOrder() {
    // ignore: unused_local_variable
    Timer timer;

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer)async {
        if (start.value == 0) {
          // Get.defaultDialog();
          // showPopUp(onTap: (){});
          timer.cancel();
         await acceptOrderNurse(statusRespone: 2);
          Get.back();
        } else if (stopTime.value == true) {
          timer.cancel();
        } else {
          start.value--;
          // ignore: avoid_print
          print('masuk nih ${start.value}');
        }
      },
    );
  }

  Future<dynamic> acceptOrderNurse({required int statusRespone}) async {
    final params = <String, dynamic>{"nurse_receive_status": statusRespone};

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/update/order/${Get.find<HomeController>().dataReminderNurse['id']}',
          Method.POST,
          params);
      final order = json.decode(result.toString());
      stopTime.value = true;

      log('zaee $order');

      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      // ignore: avoid_print
      print('zaee $e');
    }
  }

}
