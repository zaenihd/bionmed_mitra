// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/views/riwayat_pesanan.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/views/widget/card_layanan_tab.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../home/views/home_view.dart';

class LayananHomeView extends StatefulWidget {
  final bool test;
  const LayananHomeView({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  State<LayananHomeView> createState() => _LayananHomeViewState();
}

class _LayananHomeViewState extends State<LayananHomeView>
    with SingleTickerProviderStateMixin {
  final myC = Get.put(LayananHomeController());
  final loginC = Get.put(LayananHomeController());
  String title = "Pesanan anda";
  String callId = "TestCallId";

  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Hari Ini",
    ),
    const Tab(
      text: "Terjadwalkan",
    ),
    // const Tab(
    //   text: "Sudah Bayar",
    // ),
    // const Tab(
    //   text: "Belum bayar",
    // ),
    // const Tab(
    //   text: "Transaksi Gagal",
    // ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // myC.getOrder();
    // myC.addOrder();
    // myC.updateStatusTimer();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(title),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => RiwayatPesanan());
              log(myC.dataListOrder.toString());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.history,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Riwayat',
                  )
                ],
              ),
            ),
          ),
        ],
        // titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        automaticallyImplyLeading: widget.test,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 60,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColor.weak2Color,
              borderRadius: BorderRadius.circular(
                4.0,
              ),
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                gradient: AppColor.gradient1,
                borderRadius: BorderRadius.circular(
                  4.0,
                ),
              ),
              labelColor: AppColor.whiteColor,
              unselectedLabelColor: AppColor.bodyColor.shade700,
              tabs: myTabs,
              onTap: (val) {
                if (val == 0 || val == 1 || val == 2 || val == 3 || val == 4) {
                  if (Get.find<LoginController>().role.value == 'nurse') {
                    myC.listOrderNurse();
                  } else {
                    myC.addOrder();
                  }
                }
              },
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? 
                Obx(
                  () => myC.dataListOrder.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () {
                            myC.orderListToday();
                            return Future.delayed(const Duration(seconds: 1));
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              // reverse : Get.find<LoginController>().role.value == 'nurse' ? true : false,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: myC.dataListOrderToday.length,
                              itemBuilder: (context, index) {
                                var layanan = Get.find<LoginController>().role.value ==
                                            'nurse'
                                        ? "" : myC.dataListOrderToday[index]
                                    ['order']['service_price']['name'];
                                var dataService = Get.find<LoginController>().role.value ==
                                            'nurse'
                                        ? "" :myC.dataListOrderToday[index]
                                    ['order']['service']['name'];
                                var dataLayanan = Get.find<LoginController>().role.value ==
                                            'nurse'
                                        ? "" :myC.dataListOrderToday[index]
                                    ['order']['status'];

                                    //LAYANAN NURSE
                                var statusOrderNurse =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : myC.dataListOrder[index]['order']
                                            ['status_order'];
                                // ignore: unused_local_variable
                                var serviceName =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : myC.dataListOrder[index]['order']['service']
                                            ['name'];
                                // ignore: unused_local_variable
                                var servicePriceName =
                                    Get.find<LoginController>().role.value !=
                                            'nurse'
                                        ? ""
                                        : myC.dataListOrder[index]
                                            ['service_price_nurse']['order']['name'];
                                return Get.find<LoginController>().role.value !=
                                            'nurse' 
                                            ? 
                                        dataLayanan == 2 ||
                                        dataLayanan == 3 ||
                                        dataLayanan == 4 ||
                                        dataLayanan == 1 
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 24),
                                        child: 
                                        HomeView().CardLayananOrder(
                                            layanan,
                                            index,
                                            dataLayanan,
                                            dataService,
                                            context)
                                            )
                                    : const SizedBox(
                                    height: 1.0,
                                    ) : statusOrderNurse == 2 ||
                                        statusOrderNurse == 3 ||
                                        statusOrderNurse == 4 ||
                                        statusOrderNurse == 1 
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 24),
                                        child: HomeView().CardLayananNurseOrder(
                                            layanan,
                                            index,
                                            dataLayanan,
                                            dataService,
                                            context))
                                    : const SizedBox(
                                        width: 1.0,
                                      ) ;
                              }),
                        )
                      : const Center(child: Text("Belum ada pesanan")),
                ) : CardServiceNurse(
                  myC: myC,
                  statusList: 3,
                  statusList1: 4,
                  statusList2: 2,
                  statusList3: 6,
                ),

                //TAB TERJADWALKAN 

                Get.find<LoginController>().role.value !=
                                            'nurse' ?
                CardService1(
                  myC: myC,
                  statusList: 2,
                  statusList1: 2,
                )
                : CardServiceNurse(
                  myC: myC,
                  statusList: 2,
                  statusList1: 2,
                )
                // CardService1(
                //   myC: myC,
                //   statusList: 1,
                //   statusList1: 1,
                // ),
                // CardService1(
                //   myC: myC,
                //   statusList: 0,
                //   statusList1: 0,
                // ),
                // CardService1(
                //   myC: myC,
                //   statusList: 99,
                //   statusList1: 99,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Obx cardLayananAll() {
    return Obx(
      () => myC.dataListOrder.isEmpty
          ? const Center(child: Text('Belum ada pesanan'))
          : myC.dataListOrder.isNotEmpty
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
                        var layanan = myC.dataListOrder[index]['order']
                            ['service_price']['name'];
                        var dataService = myC.dataListOrder[index]['order']
                            ['service']['name'];
                        var dataLayanan =
                            myC.dataListOrder[index]['order']['status'];
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 24),
                            child: HomeView().CardLayananOrder(layanan, index,
                                dataLayanan, dataService, context));
                      }),
                )
              : const Center(
                  child: Text('Belum ada pesanan'),
                ),
    );
  }
}

// ignore: must_be_immutable

