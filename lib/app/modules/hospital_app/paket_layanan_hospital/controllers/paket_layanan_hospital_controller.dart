import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class PaketLayananHospitalController extends GetxController {
  RxBool isActive = false.obs;
  RxInt seviceId = 0.obs;
  RxList detailByDay = [].obs;
  RxList detailByMonth = [].obs;
  RxList detailByYear = [].obs;
  RxList totalDetail = [].obs;
  RxList detailIncomeFromDate = [].obs;
  RxInt incomeDay = 0.obs;
  RxInt incomeMonth = 0.obs;
  RxInt incomeYear = 0.obs;
  RxInt incomeTotal = 0.obs;
  RxInt dateIncome = 0.obs;

  RxBool isLoading = false.obs;
  Future<dynamic> hospitalIncome() async {
    // ignore: unused_local_variable
    final map = <String, dynamic>{};
    isLoading(true);

    final params = <String, dynamic>{
      "hospitalId": Get.find<LoginController>().idLogin,
      "serviceId": seviceId.value
    };
    try {
      var result = await RestClient()
          .request('${MainUrl.urlApi}hospital/income', Method.POST, params);
      final incomeHospital = json.decode(result.toString());
      incomeDay.value = incomeHospital['incomeByDay'];
      incomeMonth.value = incomeHospital['incomeByMonth'];
      incomeYear.value = incomeHospital['incomeByYear'];
      incomeTotal.value = incomeHospital['totalIncome'];
      detailByDay.value = incomeHospital['detailByDay'];
      detailByMonth.value = incomeHospital['detailByMonth'];
      detailByYear.value = incomeHospital['detailByYear'];
      totalDetail.value = incomeHospital['totalDetail'];
      // if (donors['code'] == 200)
      log(incomeHospital.toString());

      isLoading(false);
      // ignore: unused_catch_clause
    } on Exception catch (e) {}
  }

  void detailIncome(){
    if(dateIncome.value == 1 ){
      detailIncomeFromDate.value = detailByDay;
    }
    if(dateIncome.value == 2 ){
      detailIncomeFromDate.value = detailByMonth;
    }
    if(dateIncome.value == 3 ){
      detailIncomeFromDate.value = detailByYear;
    }
    if(dateIncome.value == 4 ){
      detailIncomeFromDate.value = totalDetail;
    }
  }
}
