import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/string.dart';
import '../../../../constant/url.dart';

class LayananHomeController extends GetxController {
  final loginC = Get.put(LoginController());
  RxList order = [].obs;
  RxBool isloading = false.obs;
  RxBool isloadingResep = false.obs;
  RxInt statusTransaksi = 0.obs;
  RxInt statusOrderChat = 0.obs;
  RxInt startRingging = 0.obs;
  RxInt idOrder = 0.obs;
  String nameCostumer = "";
  RxInt ratingDoctor = 0.obs;
  bool stop = false;
  RxInt starRating = 0.obs;
  RxString deskripsiRating = ''.obs;
  String doctorId = '';
  String userName = '';
  bool timePeriodic = false;
  RxInt statusOrder = 0.obs;
  RxInt statusPayment = 0.obs;
  RxInt statusOrderDetail = 0.obs;
  RxInt orderId = 0.obs;

  stopTime() {
    stop = true;
  }

  startTime() {
    stop = false;
  }

  realtimeApi() {
    if (timePeriodic == false) {
      Timer.periodic(const Duration(seconds: 2), (timer) {
        addOrder();
        if (timePeriodic == true) {
          timer.cancel();
        }
      });
      // print('CEEEK ----------------------------------');
    }
  }

  stopTimePeriodic() {
    timePeriodic = true;
  }

  // List dataGetOrder = [];

  //  incrementStatus(){
  //   statusOrderChat++;
  // }

  //GET DATA ORDER
  RxBool isLoadingDetail = false.obs;

  Future<dynamic> getOrder() async {
    final params = <String, dynamic>{};

    // isLoadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      statusOrderChat.value = servis['data']['statusOrder'];
      startRingging.value = servis['data']['statusPayment'];
      nameCostumer = servis['data']['customer']['name'];
      starRating.value = servis['data']['rating'] ?? 0;
      deskripsiRating.value = servis['data']['description_rating'] ?? "";
      statusOrderDetail.value = servis['data']['status'];

      // dataGetOrder = servis['data'];
      // ignore: avoid_print
      print('Id Order hahah == $idOrder');

      if (servis['code'] == 200) {
        // print("cek data order get DariAPI =======" + name.toString());
        // isLoadingDetail(false);
      }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> getOrderDetail() async {
    final params = <String, dynamic>{};

    isLoadingDetail.value =true;
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
       dataDetail.value = servis;
      statusOrderChat.value = servis['data']['statusOrder'];
      startRingging.value = servis['data']['statusPayment'];
      nameCostumer = servis['data']['customer']['name'];
      starRating.value = servis['data']['rating'] ?? 0;
      deskripsiRating.value = servis['data']['description_rating'] ?? "";
      statusOrderDetail.value = servis['data']['status'];

      log('Id Order == $dataDetail');


      // dataGetOrder = servis['data'];
      // ignore: avoid_print
      print('Id Order == $idOrder');

      if (servis['code'] == 200) {
        // print("cek data order get DariAPI =======" + name.toString());
        isLoadingDetail(false);
      }
      isloading(false);
    } on Exception catch (e) {
      isloading(false);
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        content: const Text('Tidak Ada Koneksi Internet'),
        backgroundColor: (Colors.grey),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      // ignore: avoid_print
      print(e.toString());
    }
  }

  RxInt orderIdNurse = 0.obs;
  RxList packageNurseSops = [].obs;
  RxMap dataDetail = {}.obs;
  Future<dynamic> getOrderDetailNurse() async {
    final params = <String, dynamic>{};

    isLoadingDetail(true);
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/order/detail/$idOrder', Method.GET, params);
      final servis = json.decode(result.toString());
      dataDetail.value = servis;
      if(loginC.role.value == "nurse"){
      statusOrderChat.value = servis['data']['status_order'];
      startRingging.value = servis['data']['status_payment'];
      nameCostumer = servis['data']['customer']['name'];
      starRating.value = servis['data']['rating'] ?? 0;
      deskripsiRating.value = servis['data']['description_rating'] ?? "";
      statusOrderDetail.value = servis['data']['status'];
      orderIdNurse.value = servis['data']['id'];
      packageNurseSops.value = servis['data']['service_price_nurse']['package_nurse_sops'];
      }else{
      statusOrderChat.value = servis['data']['status_order'];
      startRingging.value = servis['data']['status_payment'];
      nameCostumer = servis['data']['customer']['name'];
      starRating.value = servis['data']['rating'] ?? 0;
      deskripsiRating.value = servis['data']['description_rating'] ?? "";
      statusOrderDetail.value = servis['data']['status'];
      orderIdNurse.value = servis['data']['id'];
      packageNurseSops.value = servis['data']['service_price_nurse']['package_nurse_sops'];

      }
      

      // dataGetOrder = servis['data'];
      // ignore: avoid_print
      log('Id Order == $dataDetail');

      if (servis['code'] == 200) {
        // ignore: avoid_print
        log('zaza $packageNurseSops' );
        // print("cek data order get DariAPI =======" + name.toString());
        isLoadingDetail(false);
      }
      isloading(false);
    } on Exception catch (e) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        content: const Text('Tidak Ada Koneksi Internet'),
        backgroundColor: (Colors.grey),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      // ignore: avoid_print
      print(e.toString());
    }
  }

  //UPDATE STATUS TIMER CHAT
  Future<dynamic> updateStatusTimer(
      {required int statusOrder, required int statusPayment}) async {
    final params = <String, dynamic>{
      "statusOrder": statusOrder.toInt(),
      'statusPayment': statusPayment.toInt()
    };
    isloadingResep(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/update/data/$idOrder', Method.POST, params);
      // ignore: unused_local_variable
      final statusChat = json.decode(result.toString());

      isloadingResep(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }

  // POST DATA ORDER
  final layanan = [].obs;
  var isToLoadMore = true;
  var page = 1;
  RxString dataCostumer = ''.obs;
  RxList dataListOrder = [].obs;
  RxList dataListOrderToday = [].obs;
  RxDouble rating = 0.0.obs;

  Future<dynamic> addOrder() async {
    final params = <String, dynamic>{
      "filter": [
        {
          "doctorId":
              // 15
              loginC.docterId
        }
      ]
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}order/status', Method.POST, params);
      final order = json.decode(result.toString());
      if (order['code'] == 200) {
        dataListOrder.value = order['data'];


        // statusOrder.value = order['data']['order']['statusOrder'];

      } else {
        // dataListOrder.clear();
      }

      // ignore: avoid_print, invalid_use_of_protected_member
      print("List Order == ${dataListOrder.value}");
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> listOrderNurse() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}nurse/order?nurseId=${loginC.idLogin}', Method.GET, params);
      final order = json.decode(result.toString());
      if (order['code'] == 200) {
        dataListOrder.value = order['data'];
        // ignore: invalid_use_of_protected_member
        log('object ${dataListOrder.value}' );
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }

      // ignore: avoid_print, invalid_use_of_protected_member
      print("List Order == ${dataListOrder.value}");
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> orderListToday() async {
    final params = <String, dynamic>{
      "filter": [
        {
          "doctorId":
              // 15
              loginC.docterId
        }
      ],
      "today": true
      // "serviceId": serviceId,
    };
    isloading(true);

    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}order/status', Method.POST, params);
      final order = json.decode(result.toString());
      if (order['code'] == 200) {
        dataListOrderToday.value = order['data'];

        // statusOrder.value = order['data']['order']['statusOrder'];

      } else {
        // dataListOrder.clear();
      }
      // ignore: avoid_print
      print("UWUW HAHA$dataListOrderToday");
      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<dynamic> updateStatus(
      {required int status, required int orderId}) async {
    final params = <String, dynamic>{"status": status};
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}order/update/status/$orderId', Method.POST, params);
      final status = json.decode(result.toString());
      ratingDoctor.value = status['data']['rating'];

      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }

  Future<dynamic> updateStatusNurse(
      {required int status, required int orderId}) async {
    final params = <String, dynamic>{"status": status};
    isloading(true);

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/update/order/$orderId', Method.POST, params);
      final status = json.decode(result.toString());
      ratingDoctor.value = status['data']['rating'];

      // }
      isloading(false);
    } on Exception catch (e) {
      // ignore: avoid_print
      print("Cek error =-=-=$e");
    }
  }

  //+++++++++=========================

}
