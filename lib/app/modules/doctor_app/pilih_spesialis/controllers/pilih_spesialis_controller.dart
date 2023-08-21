import 'dart:convert';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class PilihSpesialisController extends GetxController {
  final registerC = Get.find<RegisterController>();
  final loginC = Get.find<LoginController>();
  final spesialis = [].obs;
  RxList spesialisData = [].obs;
  RxBool selected = false.obs;
  // Map<String, dynamic> spesialisSelected = {};
  RxList spesialisSelected = [].obs;
  int selectedInt = 0;
  RxInt? selectedView;
  RxBool isloading = false.obs;
  int itemCount = 7;
  RxInt spesialisId = 0.obs;

  //Get Spesialis
  Future<dynamic> spesialist() async {
    final params = <String, dynamic>{};

    isloading(true);
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}specialist', Method.GET, params);
      final spesialis = json.decode(result.toString());
      spesialisData.value = spesialis['data'];

      if (spesialis['code'] == 200) {
        // print("yu atu bisa atuuu ++++====" + sukum.toString());

      }
      isloading(false);
      //  final regis = json.decode(result.toString());
      // print("yu atu bisa" + spesialis.toString());
      // print("yu atu bisa atuuu" + spesialisData.toString());
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }


  // POST SPESIALIS

  final regis = [].obs;
  var isToLoadMore = true;
  var page = 1;

  Future<dynamic> addService({
    required int serviceId,
    // required Map doctor_services,
  }) async {
    isloading(true);
    final params = <String, dynamic>{
      "specialistId": serviceId,
      // 'specialist' : doctor_services
    };

    try {
      // ${registerC.registData}
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/specialist/${registerC.registDataUserId}',
          Method.POST,
          params);
      // ignore: unused_local_variable
      final regis = json.decode(result.toString());
      isloading(false);
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    // Jika Register belum selesai

    try {
      // ${registerC.registData}
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/add/specialist/${loginC.userIdLogin}',
          Method.POST,
          params);
      final regis = json.decode(result.toString());
      // ignore: avoid_print
      print("yu atu bisa masuk spesialis$regis");
      isloading(false);
      // }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

   RxBool isSelected = false.obs;
  RxInt selectedIndex = 20.obs;

  void toggle11(int index) => selectedIndex.value = index;

  toogle1() {
    isSelected = isSelected;
  }
}
