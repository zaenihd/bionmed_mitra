import 'dart:convert';

import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';
import '../../../doctor_app/login/controllers/login_controller.dart';

class PesanHospitalController extends GetxController {
  RxList listInboxHospital = [].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingHapus = false.obs;
  RxString pesanSaldo = "Penarikan Saldo".obs;
  Future<dynamic> fetchInboxHospital() async {
    final params = <String, dynamic>{
      "hospitalId": Get.find<LoginController>().idLogin,
    };
    isLoading(true);
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/hospital', Method.POST, params);

      final inboxHospital = json.decode(result.toString());
      if (inboxHospital['code'] == 200) {
        listInboxHospital.value = inboxHospital['data'];
        //  Get.to(()=>BuatPinSaldo());
      }

      // ignore: avoid_print
      // log("nanana update $listOrderHospital");
      isLoading(false);

      return inboxHospital;
      // }
    } on Exception catch (e) {
      // isLoading(false);
      // ignore: avoid_print
      print(e.toString());
    }
  }

   Future<dynamic> hapusPesanHospital(int inboxId
  ) async {
    isLoadingHapus(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/hospital/delete/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      // isloading(false);
    isLoadingHapus(false);

    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }

   Future<dynamic> bacaPesanHospital(int inboxId
  ) async {
    // isloading(true);
    final params = <String, dynamic>{};
    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}inbox/hospital/read/$inboxId)', Method.POST, params);
      // ignore: unused_local_variable
      var hapus = json.decode(result.toString());

      // }
      // isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error pesan$e");
    }
  }
}
