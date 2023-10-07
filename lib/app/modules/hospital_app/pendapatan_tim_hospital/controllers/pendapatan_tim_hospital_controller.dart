import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class PendapatanTimHospitalController extends GetxController {
  RxBool isloading = false.obs;
  RxInt incomeDay = 0.obs;
  RxInt incomeMonth = 0.obs;
  RxInt incomeYear = 0.obs;
  RxInt incomeTotal = 0.obs;
  RxInt dateIncome = 0.obs;
  RxList detailByDay = [].obs;
  RxList detailByMonth = [].obs;
  RxList detailByYear = [].obs;
  RxList totalDetail = [].obs;
  RxList detailIncomeFromDate = [].obs;

  Future<dynamic> pendapatanAmbulance() async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);
// Get.find<LoginController>().idLogin
    final params = <String, dynamic>{"ambulanceId": Get.find<LoginController>().idLogin
    };
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}ambulance/income', Method.POST, params);
      final dataPendapatan = json.decode(result.toString());
      incomeDay.value = dataPendapatan['incomeByDay'];
      incomeMonth.value = dataPendapatan['incomeByMonth'];
      incomeYear.value = dataPendapatan['incomeByYear'];
      // incomeTotal.value = dataPendapatan['totalIncome'];
      detailByDay.value = dataPendapatan['detailByDay'];
      detailByMonth.value = dataPendapatan['detailByMonth'];
      detailByYear.value = dataPendapatan['detailByYear'];
      // totalDetail.value = dataPendapatan['totalDetail'];
      log("ini ya zen${Get.find<LoginController>().idLogin}");
      // if (donors['code'] == 200)

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> pendapatanNurse() async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isloading(true);
    final params = <String, dynamic>{"nurseId": Get.find<LoginController>().idLogin
    };
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}nurse/income', Method.POST, params);
      final dataPendapatan = json.decode(result.toString());
      incomeDay.value = dataPendapatan['incomeByDay'];
      incomeMonth.value = dataPendapatan['incomeByMonth'];
      incomeYear.value = dataPendapatan['incomeByYear'];
      // incomeTotal.value = dataPendapatan['totalIncome'];
      detailByDay.value = dataPendapatan['detailByDay'];
      detailByMonth.value = dataPendapatan['detailByMonth'];
      detailByYear.value = dataPendapatan['detailByYear'];
      // totalDetail.value = dataPendapatan['totalDetail'];
      log(dataPendapatan.toString());
      // if (donors['code'] == 200)

      isloading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  void detailIncome() {
    if (dateIncome.value == 1) {
      detailIncomeFromDate.value = detailByDay;
    }
    if (dateIncome.value == 2) {
      detailIncomeFromDate.value = detailByMonth;
    }
    if (dateIncome.value == 3) {
      detailIncomeFromDate.value = detailByYear;
    }
    if (dateIncome.value == 4) {
      detailIncomeFromDate.value = totalDetail;
    }
  }
}
