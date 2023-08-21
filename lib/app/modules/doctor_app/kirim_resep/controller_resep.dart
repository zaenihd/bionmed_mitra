

import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ControllerResep extends GetxController{

  RxBool isLoading = false.obs;
  Future<bool> uploadResep(File imageFile) async {

    // ignore: unused_local_variable ${Get.find<LayananHomeController>().idOrder.value}
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    isLoading(true);
    final String url = "${MainUrl.urlApi}order/upload/recipe/${Get.find<LayananHomeController>().idOrder.value}";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    // ignore: unused_local_variable
    final respStr = await res.stream.bytesToString();
    isLoading(false);
    log('cek masuk == '+ respStr.toString());
    log('cek masuk == '+ res.toString());

    if (res.statusCode == 200) {
      //  await Get.find<LayananHomeController>().updateStatusTimer(
      //                 statusPayment: Get.find<LayananHomeController>().statusPayment.value + 0,
      //                 statusOrder: Get.find<LayananHomeController>().statusOrderChat.value + 3);
      //         Get.to(SuksesKirimResep());
      
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // Get.defaultDialog(title: "Terjadi Kesalahan", middleText: "Gagal Mengirim Resep\nSilahkan Coba lagi");
      return false;
    }
  }
}