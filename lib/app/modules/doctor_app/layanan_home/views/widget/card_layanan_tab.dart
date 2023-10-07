import 'package:bionmed/app/modules/doctor_app/home/views/home_view.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/layanan_home_controller.dart';

// ignore: must_be_immutable
class CardService1 extends StatelessWidget {
  CardService1({
    Key? key,
    required this.myC,
    required this.statusList,
    required this.statusList1,
    this.statusList2,
  }) : super(key: key);

  final LayananHomeController myC;
  int statusList;
  int statusList1;
  int? statusList2;

  @override
  Widget build(BuildContext context) {
    return 
    Obx(
      () => myC.dataListOrder.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () {
                myC.addOrder();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: myC.dataListOrder.length,
                  itemBuilder: (context, index) {
                    var layanan = Get.find<LoginController>().role.value ==
                                            'nurse' ? "" : myC.dataListOrder[index]['order']
                        ['service_price']['name'];
                    var dataService = Get.find<LoginController>().role.value ==
                                            'nurse' ? "" :
                        myC.dataListOrder[index]['order']['service']['name'];
                    var dataLayanan = Get.find<LoginController>().role.value ==
                                            'nurse' ? "" :
                        myC.dataListOrder[index]['order']['status'];
                    return dataLayanan == statusList ||
                            dataLayanan == statusList1 ||
                            dataLayanan == statusList2
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 24),
                            child: HomeView().CardLayananOrder(layanan, index,
                                dataLayanan, dataService, context))
                        : const SizedBox(
                            width: 1.0,
                          );
                  }),
            )
          : const Center(child: Text("Belum ada pesanan")),
    );
  }
}

// ignore: must_be_immutable
class CardServiceNurse extends StatelessWidget {
  CardServiceNurse({
    Key? key,
    required this.myC,
    required this.statusList,
    required this.statusList1,
    this.statusList2,
    this.statusList3,
  }) : super(key: key);

  final LayananHomeController myC;
  int statusList;
  int statusList1;
  int? statusList2;
  int? statusList3;

  @override
  Widget build(BuildContext context) {
    return 
    Obx(
      () => myC.dataListOrder.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () {
                myC.listOrderNurse();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: myC.dataListOrder.length,
                  itemBuilder: (context, index) {
                     var dataLayanan =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : myC.dataListOrder[index]['order']
                                            ['status'];
                                var dataService =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : "";
                                        // myC.dataListOrder[index]['order']['service']
                                        //     ['name'];
                                var layanan =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : "";
                                        // myC.dataListOrder[index]['order']
                                        //     ['service_price_nurse']['name'];


                    // var layanan = myC.dataListOrder[index]['order']
                    //     ['service_price']['name'];
                    // var dataService =
                    //     myC.dataListOrder[index]['order']['service']['name'];
                    // var dataLayanan =
                    //     myC.dataListOrder[index]['order']['status'];
                    return dataLayanan == statusList ||
                            dataLayanan == statusList1 ||
                            dataLayanan == statusList2  ||
                            dataLayanan == statusList3
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 24),
                            child: HomeView().CardLayananNurseOrder(layanan, index,
                                dataLayanan, dataService, context))
                        : const SizedBox(
                            width: 1.0,
                          );
                  }),
            )
          : const Center(child: Text("Tidak ada data")),
    );
  }
}
