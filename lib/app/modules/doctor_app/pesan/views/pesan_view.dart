import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/chat/views/chat_dokter.dart';
import 'package:bionmed/app/modules/doctor_app/connection/views/call/voice_screen.dart';
import 'package:bionmed/app/modules/doctor_app/detail/controllers/detail_controller.dart';
import 'package:bionmed/app/modules/doctor_app/detail/views/detail_view.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/kirim_resep/kirim_resep.dart';
import 'package:bionmed/app/modules/doctor_app/layanan/views/layanan_view.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/button/button_costum.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:zego_zimkit/services/services.dart';

import '../../connection/views/videocall_screen.dart';
import '../../layanan_home/controllers/layanan_home_controller.dart';
import '../controllers/pesan_controller.dart';

// ignore: must_be_immutable
class PesanView extends GetView<PesanController> {
  PesanView({Key? key}) : super(key: key);

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final myC = Get.put(PesanController());
  final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    if (Get.find<LoginController>().role.value == "nurse") {
      myC.notificationNurse();
    } else if (Get.find<LoginController>().role.value == "hospital") {
    } else if (Get.find<LoginController>().role.value == "ambulance") {
      myC.notificationAmbulance();
    } else {
      myC.notification();
    }
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(
            height: 1.0,
          ),
          title: const Text("Pesan anda"),
          elevation: 0.0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          ),
        ),
        body: Obx(() => controller.isloading.isTrue
            ? loadingIndicator()
            : controller.dataPesan.isEmpty
                ? const Center(
                    child: Text('Tidak ada pesan masuk'),
                  )
                : ListView.builder(
                    itemCount: controller.dataPesan.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          // log('xxxx');
                          // controller.orderCode.value =
                          //     controller.dataPesan[index]['order']['code'];
                          // controller.jamMulai.value = controller
                          //     .dataPesan[index]['order']['startDateDoctor'];
                          // controller.jamSelesai.value = controller
                          //     .dataPesan[index]['order']['endDateDoctor'];
                          // controller.tanggalPesan.value =
                          //     controller.dataPesan[index]['order']['date'];
                          // await Get.find<LayananHomeController>().addOrder();
                          controller.inboxId.value =
                              controller.dataPesan[index]['id'];
                          if (Get.find<LoginController>().role.value ==
                              "nurse") {
                            homeC.lat.value = double.parse(controller
                                .dataPesan[index]['nurse_order']['lat']
                                .toString());
                            homeC.long.value = double.parse(controller
                                .dataPesan[index]['nurse_order']['long']
                                .toString());
                            homeC.address.value = controller.dataPesan[index]
                                ['nurse_order']['address'];
                            Get.put(DetailController()).paymentName.value =
                                controller.dataPesan[index]['nurse_order']
                                            ["payment"] ==
                                        null
                                    ? ""
                                    : controller.dataPesan[index]['nurse_order']
                                        ["payment"]['credit_to_bank'];
                            // homeC.statusOrderDetail.value = controller
                            //     .dataPesan[index]['nurse_order']['statusOrder'];
                            controller.orderCode.value = controller
                                .dataPesan[index]['nurse_order']['code'];
                            controller.jamMulai.value =
                                controller.dataPesan[index]['nurse_order']
                                    ['startDateNurse'];
                            controller.jamSelesai.value =
                                controller.dataPesan[index]['nurse_order']
                                    ['endDateNurse'];
                            controller.orderCode.value = controller
                                .dataPesan[index]['nurse_order']['code'];
                            controller.tanggalPesan.value = controller
                                .dataPesan[index]['nurse_order']['date'];
                            Get.find<LayananHomeController>().idOrder.value =
                                controller.dataPesan[index]['nurseOrderId'];
                            controller.statusLayanan.value = controller
                                .dataPesan[index]['nurse_order']['status'];
                            controller.nameLayanan.value =
                                controller.dataPesan[index]['nurse_order']
                                    ['service']['sequence'];
                            controller.readPesanNurse();
                            controller.notificationNurse();
                          } else if (Get.find<LoginController>().role.value ==
                              "ambulance") {
                            homeC.lat.value = double.parse(controller
                                .dataPesan[index]['ambulance_order']
                                    ['start_lat']
                                .toString());
                            homeC.long.value = double.parse(controller
                                .dataPesan[index]['ambulance_order']
                                    ['start_long']
                                .toString());
                            homeC.address.value = controller.dataPesan[index]
                                ['ambulance_order']['start_address'];
                            Get.put(DetailController()).paymentName.value =
                                controller.dataPesan[index]['ambulance_order']
                                            ["payment"] ==
                                        null
                                    ? ""
                                    : controller.dataPesan[index]
                                            ['ambulance_order']["payment"]
                                        ['credit_to_bank'];
                            // homeC.statusOrderDetail.value = controller
                            //     .dataPesan[index]['ambulance_order']['statusOrder'];
                            controller.orderCode.value = controller
                                .dataPesan[index]['ambulance_order']['code'];
                            controller.jamMulai.value =
                                controller.dataPesan[index]['ambulance_order']
                                    ['startDateAmbulance'];
                            controller.jamSelesai.value =
                                controller.dataPesan[index]['ambulance_order']
                                    ['endDateAmbulance'];
                            controller.orderCode.value = controller
                                .dataPesan[index]['ambulance_order']['code'];
                            controller.tanggalPesan.value = controller
                                .dataPesan[index]['ambulance_order']['date'];
                            Get.find<LayananHomeController>().idOrder.value =
                                controller.dataPesan[index]['ambulanceOrderId'];
                            controller.statusLayanan.value = controller
                                .dataPesan[index]['ambulance_order']['status'];
                            controller.nameLayanan.value =
                                controller.dataPesan[index]['ambulance_order']
                                    ['service']['sequence'];
                            controller.readPesanAmbulance();
                            controller.notificationAmbulance();
                          } else {
                            homeC.lat.value = double.parse(controller
                                .dataPesan[index]['order']['lat']
                                .toString());
                            homeC.long.value = double.parse(controller
                                .dataPesan[index]['order']['long']
                                .toString());
                            homeC.address.value = controller.dataPesan[index]
                                    ['order']['address'] ??
                                "";
                            Get.put(DetailController()).paymentName.value =
                                controller.dataPesan[index]['order']
                                            ["payment"] ==
                                        null
                                    ? ""
                                    : controller.dataPesan[index]['order']
                                        ["payment"]['credit_to_bank'];
                            controller.orderCode.value =
                                controller.dataPesan[index]['order']['code'];
                            controller.jamMulai.value = controller
                                .dataPesan[index]['order']['startDateDoctor'];
                            controller.jamSelesai.value = controller
                                .dataPesan[index]['order']['endDateDoctor'];
                            controller.orderCode.value =
                                controller.dataPesan[index]['order']['code'];
                            controller.tanggalPesan.value =
                                controller.dataPesan[index]['order']['date'];
                            Get.find<LayananHomeController>().idOrder.value =
                                controller.dataPesan[index]['orderId'];
                            controller.statusLayanan.value =
                                controller.dataPesan[index]['order']['status'];
                            controller.nameLayanan.value =
                                controller.dataPesan[index]['order']['service']
                                    ['sequence'];

                            homeC.statusOrderDetail.value = controller
                                .dataPesan[index]['order']['statusOrder'];
                            // myC.timePeriodic.value = false;
                            // myC.realtimeApiGet.value = false;
                            // if (myC.realtimeApiGet.isFalse) {
                            //  await myC.realtimeApi();
                            // }
                            Get.put(DetailController()).stop = false;
                            final detailC = Get.put(DetailController());
                            detailC.bankName.value = controller.dataPesan[index]
                                        ['order']["payment"] ==
                                    null
                                ? ""
                                : controller.dataPesan[index]['order']
                                    ["payment"]['product_code'];
                            detailC.imageRecipe.value =
                                controller.dataPesan[index]["order"]
                                        ['image_recipe'] ??
                                    "";
                            await Get.find<LayananHomeController>().startTime();
                            homeC.orderMinute.value =
                                controller.dataPesan[index]['order']
                                    ['service_price']['minute'];
                            controller.readPesan();
                            controller.notification();
                          }
                          if (Get.find<LoginController>().role.value ==
                              "nurse") {
                            Get.find<LayananHomeController>()
                                .getOrderDetailNurse();
                          } else if (Get.find<LoginController>().role.value ==
                              "ambulance") {
                            Get.find<LayananHomeController>()
                                .getOrderDetailAmbulance();
                          } else {
                            Get.find<LayananHomeController>().getOrderDetail();
                          }
                          log('status ${controller.statusLayanan.value}nama ${controller.nameLayanan.value}');

                          // controller.orderIdInbox.value = pesan['data'][0]['order']['id'];
                          if (controller.dataPesan[index]['title'] ==
                              "Pembayaran Berhasil") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                      dataPesan: controller.dataPesan[index],
                                      orderId: controller.dataPesan[index]["id"]
                                          .toString(),
                                      rating: const SizedBox(),
                                      imageUrl: 'assets/icon/icon_pesan1.png',
                                      title: 'Pembayaran Berhasil',
                                      subtitle:
                                          'Terima kasih Anda telah melakukan pembayaran ',
                                      time: DateFormat(
                                              'dd MMMM yyyy, HH:mm', 'id_ID')
                                          .format(
                                        DateTime.parse(
                                          controller.dataPesan[index]['date'],
                                        ),
                                      ),
                                      button: ButtonCostum(
                                        title: "Hapus",
                                        onPressed: () async {
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            await controller.hapusPesanNurse();
                                            controller.notificationNurse();
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            await controller
                                                .hapusPesanAmbulance();
                                            controller.notificationAmbulance();
                                          } else {
                                            await controller.hapusPesan();
                                            controller.notification();
                                          }
                                          Get.back();
                                        },
                                        color: Colors.red,
                                      ));
                                });
                          } else if (controller.dataPesan[index]['status'] ==
                              99) {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                      dataPesan: controller.dataPesan[index],
                                      orderId: controller.dataPesan[index]["id"]
                                          .toString(),
                                      rating: const SizedBox(),
                                      imageUrl: 'assets/icon/icon_pesanpng',
                                      title: 'Pembayaran Gagal',
                                      subtitle:
                                          'Mohon maaf pembayaran Anda belum berhasil,\nsilakan coba ulang proses pembayaran.',
                                      time: DateFormat(
                                              'dd MMMM yyyy, HH:mm', 'id_ID')
                                          .format(
                                        DateTime.parse(
                                          controller.dataPesan[index]['date'],
                                        ),
                                      ),
                                      button: ButtonCostum(
                                        title: "Hapus",
                                        onPressed: () async {
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            await controller.hapusPesanNurse();
                                            controller.notificationNurse();
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            await controller
                                                .hapusPesanAmbulance();
                                            controller.notificationAmbulance();
                                          } else {
                                            await controller.hapusPesan();
                                            controller.notification();
                                          }
                                          Get.back();
                                        },
                                        color: Colors.red,
                                      ));
                                });
                          } else if (controller.dataPesan[index]['title'] ==
                                  "Terjadwalkan" ||
                              controller.dataPesan[index]['title'] ==
                                  "Layanan anda Akan dimulai") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: 'assets/icon/icon_pesan2.png',
                                    title: 'Terjadwalkan',
                                    subtitle: 'Pesanan Anda sudah terjadwalkan',
                                    time:
                                        "${controller.dataPesan[index]['date']}",
                                    // DateFormat(
                                    //         'dd MMMM yyyy, HH:mm', 'id_ID')
                                    //     .format(
                                    //   DateTime.parse(
                                    //     controller.dataPesan[index]['date'],
                                    //   ),
                                    // ),
                                    button: ButtomGradient(
                                        label: "Lihat Pesanan Detail",
                                        onTap: () async {
                                          // await Get.find<
                                          //         LayananHomeController>()
                                          //     .getOrder();
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            Get.to(() =>
                                                navigationDetailOrderNurseFromInboxFromInbox(
                                                    controller
                                                        .statusLayanan.value,
                                                    controller
                                                        .nameLayanan.value,
                                                    context,
                                                    layanan));
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));

                                            // Get.to(
                                            //   () => navigationDetailOrder(
                                            //       controller
                                            //           .statusLayanan.value,
                                            //       controller.nameLayanan.value,
                                            //       index,
                                            //       context,
                                            //       layanan),
                                            // );
                                          }
                                        }),
                                  );
                                });
                            // Get.defaultDialog(title: "Pemayaran Berhasil");
                          } else if (controller.dataPesan[index]['title'] ==
                              "Pesanan Diterima") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: 'assets/icon/icon_pesan1.png',
                                    title: 'Pesanan Diterima',
                                    subtitle: '',
                                    time:
                                        "${controller.dataPesan[index]['date']}",
                                    // DateFormat(
                                    //         'dd MMMM yyyy, HH:mm', 'id_ID')
                                    //     .format(
                                    //   DateTime.parse(
                                    //     controller.dataPesan[index]['date'],
                                    //   ),
                                    // ),
                                    button: ButtomGradient(
                                        label: controller.dataPesan[index]
                                                    ['title'] ==
                                                "Pesanan Diterima"
                                            ? "Kembali"
                                            : "Lihat Pesanan Detail",
                                        onTap: () async {
                                          log('zezen h');

                                          // await Get.find<
                                          //         LayananHomeController>()
                                          //     .getOrder();
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            if (controller.dataPesan[index]
                                                    ['title'] ==
                                                "Pesanan Diterima") {
                                              Get.back();
                                            } else {
                                              Get.to(() =>
                                                  navigationDetailOrderNurseFromInboxFromInbox(
                                                      controller
                                                          .statusLayanan.value,
                                                      controller
                                                          .nameLayanan.value,
                                                      context,
                                                      layanan));
                                            }
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));

                                            // Get.to(
                                            //   () => navigationDetailOrder(
                                            //       controller
                                            //           .statusLayanan.value,
                                            //       controller.nameLayanan.value,
                                            //       index,
                                            //       context,
                                            //       layanan),
                                            // );
                                          }
                                        }),
                                  );
                                });
                            // Get.defaultDialog(title: "Pemayaran Berhasil");
                          } else if (controller.dataPesan[index]['title'] ==
                                  "Mulai Sekarang" ||
                              controller.dataPesan[index]['title'] ==
                                  "Pesanan pasien akan dimulai") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: 'assets/icon/icon_pesan3.png',
                                    title: 'Mulai Sekarang',
                                    subtitle: 'Pesanan Anda sudah siap',
                                    time: DateFormat(
                                            'dd MMMM yyyy, HH:mm', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                        controller.dataPesan[index]['date'],
                                      ),
                                    ),
                                    button: ButtomGradient(
                                        label: "Mulai sekarang",
                                        onTap: () {
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          // Get.to(
                                          //   () => navigationDetailOrder(
                                          //       controller
                                          //           .statusLayanan.value,
                                          //       controller
                                          //           .nameLayanan.value,
                                          //       index,
                                          //       context,
                                          //       layanan),
                                          // );

                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            Get.to(() =>
                                                navigationDetailOrderNurseFromInboxFromInbox(
                                                    controller
                                                        .statusLayanan.value,
                                                    controller
                                                        .nameLayanan.value,
                                                    context,
                                                    layanan));
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));
                                          }
                                        }),
                                  );
                                });
                          } else if (controller.dataPesan[index]['title'] ==
                              "Layanan Berlangsung") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: 'assets/icon/icon_pesan4.png',
                                    title: 'Layanan Berlangsung',
                                    subtitle: 'Pesanan Anda sudah siap',
                                    time: DateFormat(
                                            'dd MMMM yyyy, HH:mm', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                        controller.dataPesan[index]['date'],
                                      ),
                                    ),
                                    button: ButtomGradient(
                                        label: "Lihat Pesanan",
                                        onTap: () {
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          // Get.to(
                                          //   () => navigationDetailOrder(
                                          //       controller
                                          //           .statusLayanan.value,
                                          //       controller
                                          //           .nameLayanan.value,
                                          //       index,
                                          //       context,
                                          //       layanan),
                                          // );

                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            Get.to(() =>
                                                navigationDetailOrderNurseFromInboxFromInbox(
                                                    controller
                                                        .statusLayanan.value,
                                                    controller
                                                        .nameLayanan.value,
                                                    context,
                                                    layanan));
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));
                                          }
                                        }),
                                  );
                                });
                          } else if (controller.dataPesan[index]['title'] ==
                              "Konfirmasi Selesai") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: 'assets/icon/icon_pesan5.png',
                                    title: 'Konfirmasi Selesai',
                                    subtitle:
                                        'Layanan telah selesai, beri resep untuk pasien',
                                    time: DateFormat(
                                            'dd MMMM yyyy, HH:mm', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                        controller.dataPesan[index]['date'],
                                      ),
                                    ),
                                    button: ButtomGradient(
                                        label: "Lihat Pesanan Detail",
                                        onTap: () async {
                                          log('zezen hgajsajksdk');

                                          // await Get.find<
                                          //         LayananHomeController>()
                                          //     .getOrder();
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          // Get.to(
                                          //   () => navigationDetailOrder(
                                          //       controller
                                          //           .statusLayanan.value,
                                          //       controller
                                          //           .nameLayanan.value,
                                          //       index,
                                          //       context,
                                          //       layanan),
                                          // );
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            Get.to(() =>
                                                navigationDetailOrderNurseFromInboxFromInbox(
                                                    controller
                                                        .statusLayanan.value,
                                                    controller
                                                        .nameLayanan.value,
                                                    context,
                                                    layanan));
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));
                                          }
                                        }),
                                  );
                                });
                            // Get.defaultDialog(title: "Pemayaran selesai");
                          } else if (controller.dataPesan[index]['title'] ==
                                  "Berlangsung" ||
                              controller.dataPesan[index]['title'] ==
                                  "Waktu layanan dimulai") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: const SizedBox(),
                                    imageUrl: controller.dataPesan[index]
                                                ['title'] ==
                                            "Waktu layanan dimulai"
                                        ? "assets/icon/icon_pesan4.png"
                                        : 'assets/icon/icon_pesan4.png',
                                    title: controller.dataPesan[index]
                                                ['title'] !=
                                            "Waktu layanan dimulai"
                                        ? 'Berlangsung'
                                        : "Waktu layanan Dimulai",
                                    subtitle:
                                        'Pesanan sedang berlangsung masuk untuk\nmemberikan pelayanan terhadap pasien',
                                    time: DateFormat(
                                            'dd MMMM yyyy, HH:mm', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                        controller.dataPesan[index]['date'],
                                      ),
                                    ),
                                    button: ButtomGradient(
                                        label: "Lihat Pesanan Detail",
                                        onTap: () async {
                                          // await Get.find<
                                          //         LayananHomeController>()
                                          //     .getOrder();
                                          // Get.put(DetailController())
                                          //     .paymentName
                                          //     .value = Get.find<
                                          //             LayananHomeController>()
                                          //         .dataListOrder[index]
                                          //     ["payment"]['product_code'];
                                          // Get.to(
                                          //   () => navigationDetailOrder(
                                          //       controller
                                          //           .statusLayanan.value,
                                          //       controller
                                          //           .nameLayanan.value,
                                          //       index,
                                          //       context,
                                          //       layanan),
                                          // );
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            Get.to(() =>
                                                navigationDetailOrderNurseFromInboxFromInbox(
                                                    controller
                                                        .statusLayanan.value,
                                                    controller
                                                        .nameLayanan.value,
                                                    context,
                                                    layanan));
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            // Get.defaultDialog();
                                            Get.to(() =>
                                                navigationDetailOrderAmbulance(
                                                  controller
                                                      .statusLayanan.value,
                                                  controller.nameLayanan.value,
                                                  index,
                                                  context,
                                                ));
                                          } else {
                                            Get.to(() => navigationDetailOrder(
                                                controller.statusLayanan.value,
                                                controller.nameLayanan.value,
                                                index,
                                                context,
                                                layanan));
                                          }
                                        }),
                                  );
                                });
                            // Get.defaultDialog(title: "Pemayaran selesai");
                          } else if (controller.dataPesan[index]['title'] ==
                              "Selesai") {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return DetailPesan(
                                    dataPesan: controller.dataPesan[index],
                                    // imageNetwork: Get.find<LoginController>()
                                    //             .role
                                    //             .value !=
                                    //         "nurse"
                                    //     ? controller.dataPesan[index]['order']
                                    //             ['customer']['image'] :controller.dataPesan[index]
                                    //             ['nurse_order']['patient_image'],
                                    status: 5,
                                    orderId: controller.dataPesan[index]["id"]
                                        .toString(),
                                    rating: Center(
                                      child: RatingBar.builder(
                                        itemSize: 30,
                                        ignoreGestures: true,
                                        initialRating: double.parse(
                                            Get.find<LoginController>()
                                                        .role
                                                        .value !=
                                                    "nurse"
                                                ? controller.dataPesan[index]
                                                        ['order']['rating']
                                                    .toString()
                                                : controller.dataPesan[index]
                                                        ['nurse_order']
                                                        ['rating']
                                                    .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ),
                                    imageUrl: "assets/icon/icon_pesan5.png",
                                    // Get.find<LoginController>()
                                    //             .role
                                    //             .value !=
                                    //         "nurse"
                                    //     ? controller.dataPesan[index]['order']
                                    //             ['customer']['image'] ??
                                    //         'assets/icon/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector (1).jpg'
                                    //     : controller.dataPesan[index]
                                    //             ['nurse_order']['patient_image'] ??
                                    //         'assets/icon/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector (1).jpg',
                                    title: "Selesai"
                                    // Get.find<LoginController>()
                                    //             .role
                                    //             .value !=
                                    //         "nurse" ?
                                    //     '${controller.dataPesan[index]['order']['customer']['name']}' :
                                    //     '${controller.dataPesan[index]['nurse_order']['name']}'

                                    ,
                                    subtitle: Get.find<LayananHomeController>()
                                        .deskripsiRating
                                        .value,
                                    time: DateFormat(
                                            'dd MMMM yyyy, HH:mm', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                        controller.dataPesan[index]['date'],
                                      ),
                                    ),
                                    button: controller.statusLayanan.value != 5
                                        ? ButtonCostum(
                                            title: "Hapus",
                                            onPressed: () async {
                                              if (Get.find<LoginController>()
                                                      .role
                                                      .value ==
                                                  "nurse") {
                                                await controller
                                                    .hapusPesanNurse();
                                                controller.notificationNurse();
                                              } else if (Get.find<
                                                          LoginController>()
                                                      .role
                                                      .value ==
                                                  "ambulance") {
                                                await controller
                                                    .hapusPesanAmbulance();
                                                controller
                                                    .notificationAmbulance();
                                              } else {
                                                await controller.hapusPesan();
                                                controller.notification();
                                              }
                                              Get.back();
                                            },
                                            color: Colors.red,
                                          )
                                        : ButtomGradient(
                                            label: "Lihat Pesanan Detail",
                                            onTap: () async {
                                              if (Get.find<LoginController>()
                                                      .role
                                                      .value ==
                                                  "nurse") {
                                                Get.to(() =>
                                                    navigationDetailOrderNurseFromInboxFromInbox(
                                                        controller.statusLayanan
                                                            .value,
                                                        controller
                                                            .nameLayanan.value,
                                                        context,
                                                        layanan));
                                              } else if (Get.find<
                                                          LoginController>()
                                                      .role
                                                      .value ==
                                                  "ambulance") {
                                                // Get.defaultDialog();
                                                Get.to(() =>
                                                    navigationDetailOrderAmbulance(
                                                      controller
                                                          .statusLayanan.value,
                                                      controller
                                                          .nameLayanan.value,
                                                      index,
                                                      context,
                                                    ));
                                              } else {
                                                Get.to(() =>
                                                    navigationDetailOrder(
                                                        controller.statusLayanan
                                                            .value,
                                                        controller
                                                            .nameLayanan.value,
                                                        index,
                                                        context,
                                                        layanan));
                                              }
                                            }),
                                  );
                                });
                            // Get.defaultDialog(title: "Pemayaran selesai");
                          }
                          // print(statusPesan[index]['number'].toString());
                        },
                        leading: Image.asset(
                          controller.dataPesan[index]['title'] ==
                                      "Terjadwalkan" ||
                                  controller.dataPesan[index]['title'] ==
                                      "Pesanan pasien akan dimulai"
                              ? 'assets/icon/icon_pesan2.png'
                              : controller.dataPesan[index]['title'] ==
                                          "Berlangsung" ||
                                      controller.dataPesan[index]['title'] ==
                                          "Layanan Berlangsung"
                                  ? 'assets/icon/icon_pesan4.png'
                                  : controller.dataPesan[index]['title'] ==
                                              "Mulai Sekarang" ||
                                          controller.dataPesan[index]
                                                  ['title'] ==
                                              "Waktu layanan dimulai"
                                      ? 'assets/icon/icon_pesan3.png'
                                      : controller.dataPesan[index]['title'] ==
                                              "Pesanan Diterima"
                                          ? 'assets/icon/icon_pesan1.png'
                                          : controller.dataPesan[index]
                                                      ['title'] ==
                                                  "Pesanan Dibatalkan"
                                              ? 'assets/icon/icon_pesan98.png'
                                              : controller.dataPesan[index]
                                                              ['title'] ==
                                                          "Selesai" ||
                                                      controller.dataPesan[index]
                                                              ['title'] ==
                                                          "Konfirmasi Selesai"
                                                  ? 'assets/icon/icon_pesan5.png'
                                                  : 'assets/icon/icon_pesan99.png',
                          width: 62,
                          height: 62,
                        ),
                        title: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Get.width / 2.4,
                                child: AutoSizeText(
                                  controller.dataPesan[index]['title'],
                                  style: blackTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 16),
                                ),
                              ),
                              controller.dataPesan[index]['status'] == 1
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        color: Colors.red,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 1.0,
                                    ),
                            ],
                          ),
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                            onPressed: () async {
                              await Get.find<LayananHomeController>()
                                  .addOrder();
                              controller.inboxId.value =
                                  controller.dataPesan[index]['id'];
                              Get.defaultDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Kembali')),
                                    Obx(() => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () async {
                                          if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "nurse") {
                                            await controller.hapusPesanNurse();
                                            controller.notificationNurse();
                                          } else if (Get.find<LoginController>()
                                                  .role
                                                  .value ==
                                              "ambulance") {
                                            await controller
                                                .hapusPesanAmbulance();
                                            controller.notificationAmbulance();
                                          } else {
                                            await controller.hapusPesan();
                                            controller.notification();
                                          }
                                          // await controller.hapusPesan();
                                          // await controller.notification();
                                          Get.back();
                                        },
                                        child: controller.isloading.isTrue
                                            ? const Text("Loading...")
                                            : const Text('Hapus')))
                                  ],
                                  title: "Hapus Pesan",
                                  middleText:
                                      "Apakah Anda yakin\nMenghapus Pesan ini?");
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.dataPesan[index]['description'],
                              // "Lihat detail pemberitahuan",
                              style: subtitleTextStyle.copyWith(
                                  fontSize: 12, fontWeight: light),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(
                                DateTime.parse(
                                  controller.dataPesan[index]['date'],
                                ),
                              ),
                              style: subtitleTextStyle.copyWith(
                                  fontSize: 12, fontWeight: light),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));
  }

  DetailView navigationDetailOrder(
      dataLayanan, dataService, int index, BuildContext context, layanan) {
    final controller = Get.put(PesanController());
    final layananHomeC = Get.put(LayananHomeController());
    final myC = Get.put(HomeController());
    return DetailView(
      dataDetail: layananHomeC.dataDetail['data'],
      iconPembayaran: Obx(
        () => controller.statusLayanan.value == 0
            ? const Icon(Icons.cancel)
            : Icon(
                Icons.check_circle,
                color: greenColor,
              ),
      ),
      statusPembayaran: Obx(() => controller.statusLayanan.value == 0
          ? Txt(text: 'Belum melakukan pembayaran', size: 11, weight: medium)
          : Txt(text: "Ter-verifikasi sudah bayar", size: 11, weight: medium)),
      statusOrderImage: Obx(
        () => controller.statusLayanan.value == 0
            ? StatusImage(
                onTap: () {},
                imageUrl: '0',
                title: 'Pasien belum bayar',
                subtitle:
                    "Pasien belum melakukan pembayaran untuk \nlayanan yang dipilih")
            : controller.statusLayanan.value == 2 ||
                    controller.statusLayanan.value == 3 ||
                    controller.statusLayanan.value == 4 ||
                    controller.statusLayanan.value == 1
                ? StatusImage(
                    onTap: () {},
                    imageUrl: '34',
                    title: 'Konsultasi berlangsung',
                    subtitle: "Tekan lihat konsultasi / lanjutkan")
                : controller.statusLayanan.value == 6 ||
                        controller.statusLayanan.value == 5
                    ? StatusImage(
                        onTap: () {},
                        imageUrl: '56',
                        title: 'Konsultasi Selesai',
                        subtitle: "Sesi konsultasi telah selesai")
                    : dataService == 1 &&
                                controller.statusLayanan.value == 99 ||
                            dataService == "Dokter on Call" &&
                                controller.statusLayanan.value == 99
                        ? StatusImage(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 340,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 18, top: 14),
                                            width: Get.width / 1.9,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xffEDEDED)),
                                          ),
                                          Text(
                                            'Pasien sudah mengganti jadwal baru',
                                            style: subtitleTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            height: 70,
                                            child: ListOrder(
                                              heightC: 50,
                                              widthC: 50,
                                              colorText:
                                                  const Color(0xff6C6C6C),
                                              imageUrl:
                                                  'assets/icon/icon_calender.png',
                                              title: 'Tanggal & Waktu',
                                              subtitle:
                                                  'Senin, 14 Januari 2022\n08.20 PM',
                                              widht: 0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 23,
                                          ),
                                          ButtomGradient(
                                            label: "Konfirmasi Jadwal",
                                            onTap: () {
                                              Get.back();
                                            },
                                          ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                          ButtonPrimary(
                                              title:
                                                  "Tidak Bisa, Coba atur ulang",
                                              onPressed: () {})
                                        ],
                                      ),
                                    );
                                  });
                            },
                            imageUrl: '99',
                            title: 'Konsultasi Gagal',
                            subtitle: "Konsultasi anda bermasalah / Gagal")
                        : dataService == "Dokter on Call" && dataLayanan == 1 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 2 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 3
                            ? StatusImage(
                                onTap: () {},
                                imageUrl: '33',
                                title: 'Mulai Sesi Konsultasi',
                                subtitle: "Silakan menunggu jadwal anda")
                            : dataService == "Dokter on Call" &&
                                    dataLayanan == 4
                                ? StatusImage(
                                    onTap: () {},
                                    imageUrl: '44',
                                    title: 'Konsultasi Berlangsung',
                                    subtitle: "Sesi konsultasi telah selesai")
                                : dataService == "Dokter on Call" &&
                                        dataLayanan == 6
                                    ? StatusImage(
                                        onTap: () {},
                                        imageUrl: '55',
                                        title: 'Konfirmasi Konsultasi',
                                        subtitle: "Lekas membaik !")
                                    : dataService == "Dokter on Call" &&
                                            dataLayanan == 5
                                        ? StatusImage(
                                            onTap: () {},
                                            imageUrl: '66',
                                            title: 'Kepuasan Pasien',
                                            subtitle:
                                                "Penilaian dari pasien untuk anda")
                                        : StatusImage(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30))),
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 340,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 18,
                                                                    top: 14),
                                                            width:
                                                                Get.width / 1.9,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xffEDEDED)),
                                                          ),
                                                          Text(
                                                            'Pasien sudah mengganti jadwal baru',
                                                            style:
                                                                subtitleTextStyle,
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          SizedBox(
                                                            width: 250,
                                                            height: 70,
                                                            child: ListOrder(
                                                              heightC: 50,
                                                              widthC: 50,
                                                              colorText:
                                                                  const Color(
                                                                      0xff6C6C6C),
                                                              imageUrl:
                                                                  'assets/icon/icon_calender.png',
                                                              title:
                                                                  'Tanggal & Waktu',
                                                              subtitle:
                                                                  'Senin, 14 Januari 2022\n08.20 PM',
                                                              widht: 0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 23,
                                                          ),
                                                          ButtomGradient(
                                                            label:
                                                                "Konfirmasi Jadwal",
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          ButtonPrimary(
                                                              title:
                                                                  "Tidak Bisa, Coba atur ulang",
                                                              onPressed: () {})
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            imageUrl: '999',
                                            title: 'Konsultasi Gagal',
                                            subtitle:
                                                "Konsultasi anda bermasalah / Gagal"),
      ),
      statusOrder: Obx(
        () => controller.statusLayanan.value == 0
            ? InfoOrder(onTap: () {}, status: '0')
            : controller.statusLayanan.value == 2
                ? InfoOrder(onTap: () {}, status: '22')
                : controller.statusLayanan.value == 1
                    ? InfoOrder(onTap: () {}, status: '22')
                    : controller.statusLayanan.value == 3
                        ? InfoOrder(onTap: () {}, status: '3')
                        : controller.statusLayanan.value == 4
                            ? InfoOrder(onTap: () {}, status: '4')
                            : controller.statusLayanan.value == 6
                                ? InfoOrder(onTap: () {}, status: '6')
                                : controller.statusLayanan.value == 5
                                    ? InfoOrder(onTap: () {}, status: '5')
                                    : controller.statusLayanan.value == 99
                                        ? InfoOrder(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30))),
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 340,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 18,
                                                                    top: 14),
                                                            width:
                                                                Get.width / 1.9,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xffEDEDED)),
                                                          ),
                                                          Text(
                                                            'Pasien sudah mengganti jadwal baru',
                                                            style:
                                                                subtitleTextStyle,
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          SizedBox(
                                                            width: 250,
                                                            height: 70,
                                                            child: ListOrder(
                                                              heightC: 50,
                                                              widthC: 50,
                                                              colorText:
                                                                  const Color(
                                                                      0xff6C6C6C),
                                                              imageUrl:
                                                                  'assets/icon/icon_calender.png',
                                                              title:
                                                                  'Tanggal & Waktu',
                                                              subtitle:
                                                                  'Senin, 14 Januari 2022\n08.20 PM',
                                                              widht: 0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 23,
                                                          ),
                                                          ButtomGradient(
                                                            label:
                                                                "Konfirmasi Jadwal",
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          ButtonPrimary(
                                                              title:
                                                                  "Tidak Bisa, Coba atur ulang",
                                                              onPressed: () {})
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            status: '99')
                                        : const SizedBox(
                                            height: 1.0,
                                          ),
      ),
      // discount: layananHomeC.dataDetail['data']['discount'],
      iconService: layananHomeC.dataDetail['data']['service']['image'],
      service: layananHomeC.dataDetail['data']['service']['name'],
      // time: layananHomeC.dataListOrder[index]
      //     ['order']['date'],
      buttonGradientfinish: dataLayanan == 6
          ? const SizedBox(
              height: 1.0,
            )
          // ButtomGradient(
          //     label: 'Beri Resep Obat',
          //     onTap: () {
          //       Get.to(() => CatatanDocter());
          //     })
          : const SizedBox(),
      rating: Obx(
        () => controller.statusLayanan.value == 5
            ? Rating(
                rating: double.parse(
                    layananHomeC.dataDetail['data']['rating'].toString()),
              )
            : const SizedBox(),
      ),
      buttonGradient: Obx(
        () => controller.statusLayanan.value == 3 ||
                dataService == 1 && controller.statusLayanan.value == 4 ||
                controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 5 &&
                    controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 7 ||
                // Get.find<DetailController>().imageRecipe.value == "" &&
                //     myC.statusOrderDetail.value != 5 ||
                // myC.statusOrderDetail.value != 7 || myC.statusOrderDetail.value != 5 ||
                dataService == 2 ||
                dataService == 4 ||
                dataService == 5 ||
                dataService == 6 && controller.statusLayanan.value == 2 ||
                controller.statusLayanan.value == 4 && dataService == 2 ||
                dataService == 4 ||
                dataService == 5 ||
                dataService == 6 // 'Dokter on Call'
            ? Obx(() => myC.loading.value == true
                ? loadingIndicator()
                : Column(
                    children: [
                      controller.statusLayanan.value == 4 && dataService == 2 ||
                              dataService == 4 ||
                              dataService == 5 ||
                              dataService == 6 ||
                              controller.statusLayanan.value == 3 &&
                                  dataService == 2 ||
                              dataService == 4 ||
                              dataService == 5 ||
                              dataService == 6 ||
                              controller.statusLayanan.value == 2 &&
                                  dataService == 2 ||
                              dataService == 4 ||
                              dataService == 5 ||
                              dataService == 6
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ButtomGradient(
                                  label: "Lihat Lokasi Pasien",
                                  onTap: () async {
                                    await MapsLauncher.launchCoordinates(
                                        myC.lat.value,
                                        myC.long.value,
                                        Get.find<HomeController>()
                                            .address
                                            .value);
                                  }),
                            )
                          : const SizedBox(
                              height: 1.0,
                            ),
                      controller.statusLayanan.value == 4 && dataService == 2
                          ? ButtomGradient(
                              label: "Akhiri Pesanan",
                              // layanan == 'Layanan Chat' && dataLayanan == 3
                              //     ? 'Mulai Chat Sekarang'
                              //     : layanan == 'Layanan Video Call' && dataLayanan == 3
                              //         ? 'Mulai Video Call Sekarang'
                              //         : 'Mulai Sekarang',
                              onTap: () async {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 270,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 18, top: 14),
                                            width: Get.width / 1.9,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xffEDEDED)),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'Apakah Anda yakin\nMengakhiri Pesanan?',
                                            style: blackTextStyle.copyWith(
                                                fontWeight: medium),
                                          ),
                                          const SizedBox(
                                            height: 36.0,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: 312,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () async {
                                                  await layananHomeC
                                                      .updateStatus(
                                                          orderId: layananHomeC
                                                                  .dataDetail[
                                                              'data']['id'],
                                                          status: 6);
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: const Text(
                                                    "Akhiri Pesanan")),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: 312,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                    backgroundColor:
                                                        buttonColor),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Batal")),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              })
                          : controller.statusLayanan.value == 5 &&
                                  dataService == 2
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : controller.statusLayanan.value == 6 && dataService == 2 ||
                                      controller.statusLayanan.value == 99 &&
                                          dataService == 2
                                  ? const SizedBox(
                                      height: 1.0,
                                    )
                                  : ButtomGradient(
                                      label: dataService == 1 &&
                                              controller.statusLayanan.value ==
                                                  4
                                          ? 'Sedang Berlangsung'
                                          : dataService == 1 &&
                                                      layananHomeC
                                                              .statusOrderDetail
                                                              .value ==
                                                          5 ||
                                                  controller.statusLayanan.value ==
                                                      6
                                              ? 'Kirim Resep'
                                              : dataService == "Dokter on Call" &&
                                                      layananHomeC
                                                              .statusOrderDetail
                                                              .value ==
                                                          4
                                                  ? "Selesai"
                                                  : dataService == "Dokter on Call" &&
                                                          layananHomeC
                                                                  .statusOrderDetail
                                                                  .value ==
                                                              6
                                                      ? "Beri Resep Dokter"
                                                      : dataService == 1 &&
                                                              layananHomeC
                                                                      .statusOrderDetail
                                                                      .value ==
                                                                  6
                                                          ? "Beri Resep Dokter"
                                                          : "Mulai Sekarang",
                                      // layanan == 'Layanan Chat' && dataLayanan == 3
                                      //     ? 'Mulai Chat Sekarang'
                                      //     : layanan == 'Layanan Video Call' && dataLayanan == 3
                                      //         ? 'Mulai Video Call Sekarang'
                                      //         : 'Mulai Sekarang',
                                      onTap: () async {
                                        if (myC.loading.value == false) {
                                          if (dataService == 1 &&
                                                  layananHomeC.statusOrderDetail
                                                          .value ==
                                                      6 ||
                                              // dataService == 2 ||
                                              dataService == 4 ||
                                              dataService == 5 ||
                                              dataService == 6 &&
                                                  layananHomeC.statusOrderDetail
                                                          .value ==
                                                      6) {
                                            Get.to(() => const KirimResep());
                                          } else {
                                            layananHomeC.doctorId = layananHomeC
                                                .dataDetail['data']['doctor']
                                                    ['userId']
                                                .toString();
                                            layananHomeC.userName =
                                                layananHomeC.dataDetail['data']
                                                    ['doctor']['name'];
                                            // if (dataService == "Dokter on Call" && dataLayanan == 4) {
                                            //   layananHomeC.updateStatus(
                                            //       orderId: layananHomeC.dataDetail['data']['id'],
                                            //       status: 6);
                                            //   print('Ubah Statusss==========-=-=-=-=0-=0');
                                            // }
                                            await ZIMKit().connectUser(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              id: layananHomeC
                                                  .dataDetail['data']['doctor']
                                                      ['userId']
                                                  .toString(),
                                            );
                                            var layanan =
                                                layananHomeC.dataDetail['data']
                                                    ['service_price']['name'];
                                            if (layanan == 'Layanan Chat') {
                                              //     controller.loading.value = true;
                                              // print('CWK' + controller.loading.value.toString()  );
                                              // controller.startTimer();
                                              Get.find<LayananHomeController>()
                                                      .idOrder
                                                      .value =
                                                  layananHomeC
                                                      .dataDetail['data']['id'];
                                              await layananHomeC.getOrder();
                                              // ignore: use_build_context_synchronously
                                              ZIMKit()
                                                  .showDefaultNewPeerChatDialogChat(
                                                context,
                                                layananHomeC.dataDetail['data']
                                                        ['customer']['userId']
                                                    .toString(),
                                              );
                                              layananHomeC.orderId.value =
                                                  layananHomeC
                                                      .dataDetail['data']['id'];
                                            } else if (layanan ==
                                                'Layanan Video Call') {
                                              layananHomeC.startTime();
                                              await layananHomeC.getOrder();
                                              Get.find<LayananHomeController>()
                                                      .idOrder
                                                      .value =
                                                  layananHomeC
                                                      .dataDetail['data']['id'];
                                              // layananHomeC.updateStatusTimer(
                                              //     statusPayment:
                                              //         layananHomeC.statusPayment.value + 2,
                                              //     statusOrder:
                                              //         layananHomeC.statusOrderChat.value + 1);
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  status: 4);
                                              Get.to(VideoCallService(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  userid: layananHomeC
                                                      .dataDetail['data']
                                                          ['doctor']['userId']
                                                      .toString(),
                                                  userName: layananHomeC
                                                          .dataDetail['data']
                                                      ['doctor']['name'],
                                                  callId: layananHomeC
                                                      .dataDetail['data']['id']
                                                      .toString()));
                                            } else if (dataService ==
                                                    "Dokter on Call" &&
                                                dataLayanan == 4) {
                                              Get.back();
                                              layananHomeC.addOrder();
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  status: 5);
                                            } else if (layanan ==
                                                'Layanan Telephone') {
                                              layananHomeC.startTime();
                                              await layananHomeC.getOrder();
                                              Get.find<LayananHomeController>()
                                                      .idOrder
                                                      .value =
                                                  layananHomeC
                                                      .dataDetail['data']['id'];
                                              // layananHomeC.updateStatusTimer(
                                              //     statusPayment:
                                              //         layananHomeC.statusPayment.value + 2,
                                              //     statusOrder:
                                              //         layananHomeC.statusOrderChat.value + 1);
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  status: 4);
                                              Get.to(VoiceScreen(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  userid: layananHomeC
                                                      .dataDetail['data']
                                                          ['doctor']['userId']
                                                      .toString(),
                                                  userName: layananHomeC
                                                          .dataDetail['data']
                                                      ['doctor']['name'],
                                                  callId: layananHomeC
                                                      .dataDetail['data']['id']
                                                      .toString()));
                                            } else if (dataService == 2 ||
                                                dataService == 4 ||
                                                dataService == 5 ||
                                                dataService == 6 &&
                                                    dataLayanan == 2 ||
                                                dataLayanan == 3) {
                                              Get.back();
                                              layananHomeC.addOrder();
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                      .dataDetail['data']['id'],
                                                  status: 4);
                                              // controller.startTimer();
                                            }
                                            myC.loading.value = false;
                                          }
                                        }
                                      }),
                    ],
                  ))
            : const SizedBox(),
      ),
      // bottomHcontainer: controller.statusLayanan.value == 6 ||
      //         layananHomeC.statusOrderDetail.value == 3 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 2 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 4
      //     ? 210
      //     : layananHomeC.statusOrderDetail.value == 3 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 2 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 4 &&
      //                 dataService == 2
      //         ? 220
      //         : 210,
      // data: dataLayanan == 0,
      // pasienTitle: dataLayanan == 99 ? 'Pasien melewatkan jadwal ordernya' : "",
      // pasienSubtitle: dataLayanan == 99
      //     ? 'Tunggu pasien untuk mengatur jadwal order selanjutnya'
      //     : "",
      // terlewatkan: dataLayanan == 99 ? 'Terlewatkan' : "",
      // statusVerifikasi: dataLayanan == 0
      //     ? layananHomeC.dataDetail['data']['statusPayment'] == 0
      //         ? "Pasien belum melakukan pembayaran"
      //         : 'Ter-verifikasi sudah bayar'
      //     : layananHomeC.dataDetail['data']['statusPayment'] == 1
      //         ? 'Ter-verifikasi sudah bayar'
      //         : "Ter-verifikasi sudah bayar",
      imageUrl: layananHomeC.dataDetail['data']['customer']['image'] ??
          "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg",
      name: layananHomeC.dataDetail['data']['customer']['name'].toString(),
      totalPrice: layananHomeC.dataDetail['data']['totalPrice'],
      //  -
      //     layananHomeC.dataDetail['data']['discount'],
      tanggal: layananHomeC.dataDetail['data']['date'],
      codeOrder: layananHomeC.dataDetail['data']['code'],
      jamMulai: layananHomeC.dataDetail['data']['startDateDoctor'],
      jamSelesai: layananHomeC.dataDetail['data']['endDateDoctor'],

      // layanan: layananHomeC.dataDetail['data']['service_price']['name'].toString()
    );
  }

  DetailView navigationDetailOrderNurseFromInboxFromInbox(
      dataLayanan, dataService, BuildContext context, layanan) {
    final controller = Get.put(PesanController());
    final layananHomeC = Get.put(LayananHomeController());
    final myC = Get.put(HomeController());
    return DetailView(
      dataDetail: layananHomeC.dataDetail['data'],
      iconPembayaran: Obx(
        () => controller.statusLayanan.value == 0
            ? const Icon(Icons.cancel)
            : Icon(
                Icons.check_circle,
                color: greenColor,
              ),
      ),
      statusPembayaran: Obx(() => controller.statusLayanan.value == 0
          ? Txt(text: 'Belum melakukan pembayaran', size: 11, weight: medium)
          : Txt(text: "Ter-verifikasi sudah bayar", size: 11, weight: medium)),
      statusOrderImage: Obx(
        () => controller.statusLayanan.value == 0
            ? StatusImage(
                onTap: () {},
                imageUrl: '0',
                title: 'Pasien belum bayar',
                subtitle:
                    "Pasien belum melakukan pembayaran untuk \nlayanan yang dipilih")
            : controller.statusLayanan.value == 2 ||
                    controller.statusLayanan.value == 3 ||
                    controller.statusLayanan.value == 4 ||
                    controller.statusLayanan.value == 1
                ? StatusImage(
                    onTap: () {},
                    imageUrl: '34',
                    title: 'Konsultasi berlangsung',
                    subtitle: "Tekan lihat konsultasi / lanjutkan")
                : controller.statusLayanan.value == 6 ||
                        controller.statusLayanan.value == 5
                    ? StatusImage(
                        onTap: () {},
                        imageUrl: '56',
                        title: 'Konsultasi Selesai',
                        subtitle: "Sesi konsultasi telah selesai")
                    : dataService == 1 &&
                                controller.statusLayanan.value == 99 ||
                            dataService == "Dokter on Call" &&
                                controller.statusLayanan.value == 99
                        ? StatusImage(
                            onTap: () {},
                            imageUrl: '99',
                            title: 'Konsultasi Gagal',
                            subtitle: "Konsultasi anda bermasalah / Gagal")
                        : dataService == "Dokter on Call" && dataLayanan == 1 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 2 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 3
                            ? StatusImage(
                                onTap: () {},
                                imageUrl: '33',
                                title: 'Mulai Sesi Konsultasi',
                                subtitle: "Silakan menunggu jadwal anda")
                            : dataService == "Dokter on Call" &&
                                    dataLayanan == 4
                                ? StatusImage(
                                    onTap: () {},
                                    imageUrl: '44',
                                    title: 'Konsultasi Berlangsung',
                                    subtitle: "Sesi konsultasi telah selesai")
                                : dataService == "Dokter on Call" &&
                                        dataLayanan == 6
                                    ? StatusImage(
                                        onTap: () {},
                                        imageUrl: '55',
                                        title: 'Konfirmasi Konsultasi',
                                        subtitle: "Lekas membaik !")
                                    : dataService == "Dokter on Call" &&
                                            dataLayanan == 5
                                        ? StatusImage(
                                            onTap: () {},
                                            imageUrl: '66',
                                            title: 'Kepuasan Pasien',
                                            subtitle:
                                                "Penilaian dari pasien untuk anda")
                                        : StatusImage(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30))),
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 340,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 18,
                                                                    top: 14),
                                                            width:
                                                                Get.width / 1.9,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xffEDEDED)),
                                                          ),
                                                          Text(
                                                            'Pasien sudah mengganti jadwal baru',
                                                            style:
                                                                subtitleTextStyle,
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          SizedBox(
                                                            width: 250,
                                                            height: 70,
                                                            child: ListOrder(
                                                              heightC: 50,
                                                              widthC: 50,
                                                              colorText:
                                                                  const Color(
                                                                      0xff6C6C6C),
                                                              imageUrl:
                                                                  'assets/icon/icon_calender.png',
                                                              title:
                                                                  'Tanggal & Waktu',
                                                              subtitle:
                                                                  'Senin, 14 Januari 2022\n08.20 PM',
                                                              widht: 0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 23,
                                                          ),
                                                          ButtomGradient(
                                                            label:
                                                                "Konfirmasi Jadwal",
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          ButtonPrimary(
                                                              title:
                                                                  "Tidak Bisa, Coba atur ulang",
                                                              onPressed: () {})
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            imageUrl: '999',
                                            title: 'Konsultasi Gagal',
                                            subtitle:
                                                "Konsultasi anda bermasalah / Gagal"),
      ),
      statusOrder: Obx(
        () => controller.statusLayanan.value == 0
            ? InfoOrder(onTap: () {}, status: '0')
            : controller.statusLayanan.value == 2
                ? InfoOrder(onTap: () {}, status: '2N')
                : controller.statusLayanan.value == 1
                    ? InfoOrder(onTap: () {}, status: '2N')
                    : controller.statusLayanan.value == 3
                        ? InfoOrder(onTap: () {}, status: '3N')
                        : controller.statusLayanan.value == 4
                            ? InfoOrder(onTap: () {}, status: '4N')
                            : controller.statusLayanan.value == 6
                                ? InfoOrder(onTap: () {}, status: '5N')
                                : controller.statusLayanan.value == 5
                                    ? InfoOrder(onTap: () {}, status: '6N')
                                    : controller.statusLayanan.value == 98
                                        ? InfoOrder(onTap: () {}, status: '98N')
                                        : controller.statusLayanan.value == 99
                                            ? InfoOrder(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                      context: context,
                                                      builder: (context) {
                                                        return SizedBox(
                                                          height: 340,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            18,
                                                                        top:
                                                                            14),
                                                                width:
                                                                    Get.width /
                                                                        1.9,
                                                                height: 10,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                        0xffEDEDED)),
                                                              ),
                                                              Text(
                                                                'Pasien sudah mengganti jadwal baru',
                                                                style:
                                                                    subtitleTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 17,
                                                              ),
                                                              SizedBox(
                                                                width: 250,
                                                                height: 70,
                                                                child:
                                                                    ListOrder(
                                                                  heightC: 50,
                                                                  widthC: 50,
                                                                  colorText:
                                                                      const Color(
                                                                          0xff6C6C6C),
                                                                  imageUrl:
                                                                      'assets/icon/icon_calender.png',
                                                                  title:
                                                                      'Tanggal & Waktu',
                                                                  subtitle:
                                                                      'Senin, 14 Januari 2022\n08.20 PM',
                                                                  widht: 0,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 23,
                                                              ),
                                                              ButtomGradient(
                                                                label:
                                                                    "Konfirmasi Jadwal",
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                height: 17,
                                                              ),
                                                              ButtonPrimary(
                                                                  title:
                                                                      "Tidak Bisa, Coba atur ulang",
                                                                  onPressed:
                                                                      () {})
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                status: '99')
                                            : const SizedBox(
                                                height: 1.0,
                                              ),
      ),
      // discount: layananHomeC.dataDetail['order']['discount'],
      iconService: layananHomeC.dataDetail['data']['service']['image'],
      service: layananHomeC.dataDetail['data']['service']['name'],
      // time: layananHomeC.dataDetail
      //     ['order']['date'],
      buttonGradientfinish: dataLayanan == 6
          ? const SizedBox(
              height: 1.0,
            )
          : const SizedBox(),
      rating: Obx(
        () => controller.statusLayanan.value == 5
            ? Rating(
                rating: double.parse(
                    layananHomeC.dataDetail['data']['rating'].toString()),
              )
            : const SizedBox(),
      ),
      buttonGradient: Obx(
        () => controller.statusLayanan.value == 3 ||
                dataService == 1 && controller.statusLayanan.value == 4 ||
                controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 5 &&
                    controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 7 ||
                dataService == 2 ||
                dataService == 4 ||
                dataService == 5 ||
                dataService == 6 && controller.statusLayanan.value == 2 ||
                controller.statusLayanan.value == 4 && dataService == 2 ||
                dataService == 4 ||
                dataService == 5 ||
                dataService == 6 // 'Dokter on Call'
            ? Obx(() => myC.loading.value == true
                ? loadingIndicator()
                : controller.statusLayanan.value == 0 ||
                        controller.statusLayanan.value == 5
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : controller.statusLayanan.value == 1 ||
                            controller.statusLayanan.value == 6
                        ? const SizedBox(
                            height: 1.0,
                          )
                        : ButtomGradient(
                            margin: 25,
                            label: controller.statusLayanan.value == 4
                                ? 'Pesanan selesai'
                                : controller.statusLayanan.value == 5 ||
                                        controller.statusLayanan.value == 6
                                    ? 'Kirim Resep'
                                    : controller.statusLayanan.value == 4
                                        ? "Selesai"
                                        : controller.statusLayanan.value == 6
                                            ? "Beri Resep Dokter"
                                            : controller.statusLayanan.value ==
                                                    6
                                                ? "Beri Resep Dokter"
                                                : "Berangkat & Mulai Sekarang",
                            // layanan == 'Layanan Chat' && dataLayanan == 3
                            //     ? 'Mulai Chat Sekarang'
                            //     : layanan == 'Layanan Video Call' && dataLayanan == 3
                            //         ? 'Mulai Video Call Sekarang'
                            //         : 'Mulai Sekarang',
                            onTap: () async {
                              if (myC.loading.value == false) {
                                if (controller.statusLayanan.value == 4) {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 270,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 18, top: 14),
                                              width: Get.width / 1.9,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xffEDEDED)),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Apakah Anda yakin?',
                                              style: blackTextStyle.copyWith(
                                                  fontWeight: medium),
                                            ),
                                            const SizedBox(
                                              height: 36.0,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: 312,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                      backgroundColor:
                                                          Colors.red),
                                                  onPressed: () async {
                                                    await layananHomeC
                                                        .updateStatusNurse(
                                                            status: 6,
                                                            orderId: layananHomeC
                                                                .orderIdNurse
                                                                .value);
                                                    Get.back();
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                      "Pemesanan selesai")),
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: 312,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                      backgroundColor:
                                                          buttonColor),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Batal")),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 270,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 18, top: 14),
                                              width: Get.width / 1.9,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xffEDEDED)),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Apakah anda yakin ?',
                                              style: blackTextStyle.copyWith(
                                                  fontWeight: medium),
                                            ),
                                            const SizedBox(
                                              height: 36.0,
                                            ),
                                            ButtomGradient(
                                                label:
                                                    'Berangkat & Mulai Sekarang',
                                                onTap: () async {
                                                  await layananHomeC
                                                      .updateStatusNurse(
                                                          status: 4,
                                                          orderId: layananHomeC
                                                              .orderIdNurse
                                                              .value);
                                                  Get.back();
                                                  Get.back();
                                                }),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            ButtonPrimary(
                                                title: 'Batal',
                                                onPressed: () {
                                                  Get.back();
                                                })
                                            // SizedBox(
                                            //   height: 45,
                                            //   width: Get.width,
                                            //   child: ElevatedButton(
                                            //       style: ElevatedButton.styleFrom(
                                            //           shape: RoundedRectangleBorder(
                                            //               borderRadius:
                                            //                   BorderRadius
                                            //                       .circular(
                                            //                           6)),
                                            //           backgroundColor:
                                            //               buttonColor),
                                            //       onPressed: () {
                                            //         Get.back();
                                            //       },
                                            //       child: const Text(
                                            //           "Batal")),
                                            // ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  // await layananHomeC.updateStatusNurse(
                                  //     status: 4,
                                  //     orderId: layananHomeC
                                  //         .orderIdNurse.value);
                                  // Get.back();
                                }
                                // layananHomeC.listOrderNurse();
                                // log('ahahhaha');
                              }
                            }))
            : const SizedBox(),
      ),
      // bottomHcontainer: layananHomeC.statusOrderDetail.value == 6 ||
      //         layananHomeC.statusOrderDetail.value == 3 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 2 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 4
      //     ? 210
      //     : layananHomeC.statusOrderDetail.value == 3 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 2 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 4 &&
      //                 dataService == 2
      //         ? 220
      //         : 210,
      // data: dataLayanan == 0,
      // pasienTitle: dataLayanan == 99 ? 'Pasien melewatkan jadwal ordernya' : "",
      // pasienSubtitle: dataLayanan == 99
      //     ? 'Tunggu pasien untuk mengatur jadwal order selanjutnya'
      //     : "",
      // terlewatkan: dataLayanan == 99 ? 'Terlewatkan' : "",
      // statusVerifikasi: dataLayanan == 0
      //     ? layananHomeC.dataDetail['order']['status'] == 0
      //         ? "Pasien belum melakukan pembayaran"
      //         : 'Ter-verifikasi sudah bayar'
      //     : layananHomeC.dataDetail['order']['status'] == 1
      //         ? 'Ter-verifikasi sudah bayar'
      //         : "Ter-verifikasi sudah bayar",
      imageUrl: layananHomeC.dataDetail['data']['customer']['image'] ??
          "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg",
      name: layananHomeC.dataDetail['data']['customer']['name'].toString(),
      totalPrice: 0,
      // layananHomeC.dataDetail['data']['totalPrice'],
      //  -
      //     layananHomeC.dataDetail['data']['discount'],
      tanggal: layananHomeC.dataDetail['data']['date'],
      codeOrder: layananHomeC.dataDetail['data']['code'],
      jamMulai: layananHomeC.dataDetail['data']['startDateNurse'],
      jamSelesai: layananHomeC.dataDetail['data']['endDateNurse'],

      // layanan: layananHomeC.dataDetail['order']['service_price']['name'].toString()
    );
  }

  DetailView navigationDetailOrderAmbulance(
    dataLayanan,
    dataService,
    int index,
    BuildContext context,
  ) {
    final controller = Get.put(PesanController());
    final layananHomeC = Get.put(LayananHomeController());
    final myC = Get.put(HomeController());
    return DetailView(
      dataDetail: layananHomeC.dataDetail['data'],
      iconPembayaran: Obx(
        () => controller.statusLayanan.value == 0
            ? const Icon(Icons.cancel)
            : Icon(
                Icons.check_circle,
                color: greenColor,
              ),
      ),
      statusPembayaran: Obx(() => controller.statusLayanan.value == 0
          ? Txt(text: 'Belum melakukan pembayaran', size: 11, weight: medium)
          : Txt(text: "Ter-verifikasi sudah bayar", size: 11, weight: medium)),
      statusOrderImage: Obx(
        () => controller.statusLayanan.value == 0
            ? StatusImage(
                onTap: () {},
                imageUrl: '0',
                title: 'Pasien belum bayar',
                subtitle:
                    "Pasien belum melakukan pembayaran untuk \nlayanan yang dipilih")
            : controller.statusLayanan.value == 2 ||
                    controller.statusLayanan.value == 3 ||
                    controller.statusLayanan.value == 4 ||
                    controller.statusLayanan.value == 1
                ? StatusImage(
                    onTap: () {},
                    imageUrl: '34',
                    title: 'Konsultasi berlangsung',
                    subtitle: "Tekan lihat konsultasi / lanjutkan")
                : controller.statusLayanan.value == 6 ||
                        controller.statusLayanan.value == 5
                    ? StatusImage(
                        onTap: () {},
                        imageUrl: '56',
                        title: 'Konsultasi Selesai',
                        subtitle: "Sesi konsultasi telah selesai")
                    : dataService == 1 &&
                                controller.statusLayanan.value == 99 ||
                            dataService == "Dokter on Call" &&
                                controller.statusLayanan.value == 99
                        ? StatusImage(
                            onTap: () {},
                            imageUrl: '99',
                            title: 'Konsultasi Gagal',
                            subtitle: "Konsultasi anda bermasalah / Gagal")
                        : dataService == "Dokter on Call" && dataLayanan == 1 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 2 ||
                                dataService == "Dokter on Call" &&
                                    dataLayanan == 3
                            ? StatusImage(
                                onTap: () {},
                                imageUrl: '33',
                                title: 'Mulai Sesi Konsultasi',
                                subtitle: "Silakan menunggu jadwal anda")
                            : dataService == "Dokter on Call" &&
                                    dataLayanan == 4
                                ? StatusImage(
                                    onTap: () {},
                                    imageUrl: '44',
                                    title: 'Konsultasi Berlangsung',
                                    subtitle: "Sesi konsultasi telah selesai")
                                : dataService == "Dokter on Call" &&
                                        dataLayanan == 6
                                    ? StatusImage(
                                        onTap: () {},
                                        imageUrl: '55',
                                        title: 'Konfirmasi Konsultasi',
                                        subtitle: "Lekas membaik !")
                                    : dataService == "Dokter on Call" &&
                                            dataLayanan == 5
                                        ? StatusImage(
                                            onTap: () {},
                                            imageUrl: '66',
                                            title: 'Kepuasan Pasien',
                                            subtitle:
                                                "Penilaian dari pasien untuk anda")
                                        : StatusImage(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30))),
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 340,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 18,
                                                                    top: 14),
                                                            width:
                                                                Get.width / 1.9,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xffEDEDED)),
                                                          ),
                                                          Text(
                                                            'Pasien sudah mengganti jadwal baru',
                                                            style:
                                                                subtitleTextStyle,
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          SizedBox(
                                                            width: 250,
                                                            height: 70,
                                                            child: ListOrder(
                                                              heightC: 50,
                                                              widthC: 50,
                                                              colorText:
                                                                  const Color(
                                                                      0xff6C6C6C),
                                                              imageUrl:
                                                                  'assets/icon/icon_calender.png',
                                                              title:
                                                                  'Tanggal & Waktu',
                                                              subtitle:
                                                                  'Senin, 14 Januari 2022\n08.20 PM',
                                                              widht: 0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 23,
                                                          ),
                                                          ButtomGradient(
                                                            label:
                                                                "Konfirmasi Jadwal",
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            height: 17,
                                                          ),
                                                          ButtonPrimary(
                                                              title:
                                                                  "Tidak Bisa, Coba atur ulang",
                                                              onPressed: () {})
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            imageUrl: '999',
                                            title: 'Konsultasi Gagal',
                                            subtitle:
                                                "Konsultasi anda bermasalah / Gagal"),
      ),
      statusOrder: Obx(
        () => controller.statusLayanan.value == 0
            ? InfoOrder(onTap: () {}, status: '0')
            : controller.statusLayanan.value == 2
                ? InfoOrder(onTap: () {}, status: '2Am')
                : controller.statusLayanan.value == 1
                    ? InfoOrder(onTap: () {}, status: '2Am')
                    : controller.statusLayanan.value == 3
                        ? InfoOrder(onTap: () {}, status: '4Am')
                        : controller.statusLayanan.value == 4
                            ? InfoOrder(onTap: () {}, status: '4Am')
                            : controller.statusLayanan.value == 6
                                ? InfoOrder(onTap: () {}, status: '6Am')
                                : controller.statusLayanan.value == 5
                                    ? InfoOrder(onTap: () {}, status: '5Am')
                                    : controller.statusLayanan.value == 98
                                        ? InfoOrder(
                                            onTap: () {}, status: '99Am')
                                        : layananHomeC
                                                    .statusOrderDetail.value ==
                                                99
                                            ? InfoOrder(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                      context: context,
                                                      builder: (context) {
                                                        return SizedBox(
                                                          height: 340,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            18,
                                                                        top:
                                                                            14),
                                                                width:
                                                                    Get.width /
                                                                        1.9,
                                                                height: 10,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                        0xffEDEDED)),
                                                              ),
                                                              Text(
                                                                'Pasien sudah mengganti jadwal baru',
                                                                style:
                                                                    subtitleTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 17,
                                                              ),
                                                              SizedBox(
                                                                width: 250,
                                                                height: 70,
                                                                child:
                                                                    ListOrder(
                                                                  heightC: 50,
                                                                  widthC: 50,
                                                                  colorText:
                                                                      const Color(
                                                                          0xff6C6C6C),
                                                                  imageUrl:
                                                                      'assets/icon/icon_calender.png',
                                                                  title:
                                                                      'Tanggal & Waktu',
                                                                  subtitle:
                                                                      'Senin, 14 Januari 2022\n08.20 PM',
                                                                  widht: 0,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 23,
                                                              ),
                                                              ButtomGradient(
                                                                label:
                                                                    "Konfirmasi Jadwal",
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                height: 17,
                                                              ),
                                                              ButtonPrimary(
                                                                  title:
                                                                      "Tidak Bisa, Coba atur ulang",
                                                                  onPressed:
                                                                      () {})
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                status: '99Am')
                                            : const SizedBox(
                                                height: 1.0,
                                              ),
      ),
      // discount: myC.listOrderHospital[index]['order']['discount'],
      iconService: layananHomeC.dataListOrder[index]['order']['service']
          ['image'],
      service: layananHomeC.dataListOrder[index]['order']['service']['name'],
      // time: layananHomeC.dataListOrder[index]
      //     ['order']['date'],
      buttonGradientfinish: dataLayanan == 6
          ? const SizedBox(
              height: 1.0,
            )
          : const SizedBox(),
      rating: Obx(
        () => controller.statusLayanan.value == 5
            ? Rating(
                rating: double.parse(layananHomeC.dataListOrder[index]['order']
                        ['rating']
                    .toString()),
              )
            : const SizedBox(),
      ),
      buttonGradient: Obx(
        () => controller.statusLayanan.value == 3 ||
                dataService == 1 && controller.statusLayanan.value == 4 ||
                controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 5 &&
                    controller.statusLayanan.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 7 ||
                dataService == 2 ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" &&
                    controller.statusLayanan.value == 2 ||
                controller.statusLayanan.value == 4 && dataService == 2 ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" // 'Dokter on Call'
            ?
            // Obx(() => controller.loading.value == true
            //     ? loadingIndicator()
            //     :
            controller.statusLayanan.value == 0 ||
                    controller.statusLayanan.value == 5
                ? const SizedBox(
                    height: 1.0,
                  )
                : controller.statusLayanan.value == 1 ||
                        controller.statusLayanan.value == 6
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : ButtomGradient(
                        margin: 25,
                        label: controller.statusLayanan.value == 4
                            ? 'Pesanan selesai'
                            : controller.statusLayanan.value == 5 ||
                                    controller.statusLayanan.value == 6
                                ? 'Kirim Resep'
                                : controller.statusLayanan.value == 4
                                    ? "Selesai"
                                    : layananHomeC.statusOrderDetail.value == 6
                                        ? "Beri Resep Dokter"
                                        : layananHomeC
                                                    .statusOrderDetail.value ==
                                                6
                                            ? "Beri Resep Dokter"
                                            : "Berangkat & Mulai Sekarang",
                        // layanan == 'Layanan Chat' && dataLayanan == 3
                        //     ? 'Mulai Chat Sekarang'
                        //     : layanan == 'Layanan Video Call' && dataLayanan == 3
                        //         ? 'Mulai Video Call Sekarang'
                        //         : 'Mulai Sekarang',
                        onTap: () async {
                          // if (controller.loading.value == false) {
                          if (controller.statusLayanan.value == 4) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 270,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 18, top: 14),
                                        width: Get.width / 1.9,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffEDEDED)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Apakah Anda yakin?',
                                        style: blackTextStyle.copyWith(
                                            fontWeight: medium),
                                      ),
                                      const SizedBox(
                                        height: 36.0,
                                      ),
                                      SizedBox(
                                        height: 45,
                                        width: 312,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                backgroundColor: Colors.red),
                                            onPressed: () async {
                                              await layananHomeC
                                                  .updateStatusNurse(
                                                      status: 6,
                                                      orderId: layananHomeC
                                                          .orderIdNurse.value);
                                              Get.back();
                                              Get.back();
                                            },
                                            child: const Text(
                                                "Pemesanan selesai")),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      SizedBox(
                                        height: 45,
                                        width: 312,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                backgroundColor: buttonColor),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("Batal")),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 270,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 18, top: 14),
                                        width: Get.width / 1.9,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffEDEDED)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Apakah anda yakin ?',
                                        style: blackTextStyle.copyWith(
                                            fontWeight: medium),
                                      ),
                                      const SizedBox(
                                        height: 36.0,
                                      ),
                                      ButtomGradient(
                                          label: 'Berangkat & Mulai Sekarang',
                                          onTap: () async {
                                            await layananHomeC
                                                .updateStatusNurse(
                                                    status: 4,
                                                    orderId: layananHomeC
                                                        .orderIdNurse.value);
                                            Get.back();
                                            Get.back();
                                          }),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      ButtonPrimary(
                                          title: 'Batal',
                                          onPressed: () {
                                            Get.back();
                                          })
                                      // SizedBox(
                                      //   height: 45,
                                      //   width: Get.width,
                                      //   child: ElevatedButton(
                                      //       style: ElevatedButton.styleFrom(
                                      //           shape: RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius
                                      //                       .circular(
                                      //                           6)),
                                      //           backgroundColor:
                                      //               buttonColor),
                                      //       onPressed: () {
                                      //         Get.back();
                                      //       },
                                      //       child: const Text(
                                      //           "Batal")),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            );
                            // await layananHomeC.updateStatusNurse(
                            //     status: 4,
                            //     orderId: layananHomeC
                            //         .orderIdNurse.value);
                            // Get.back();
                          }
                          // layananHomeC.listOrderNurse();
                          // log('ahahhaha');
                        })
            : const SizedBox(),
      ),
      // bottomHcontainer: layananHomeC.statusOrderDetail.value == 6 ||
      //         layananHomeC.statusOrderDetail.value == 3 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 2 &&
      //             dataService == 'Telemedicine' ||
      //         layananHomeC.statusOrderDetail.value == 4
      //     ? 210
      //     : layananHomeC.statusOrderDetail.value == 3 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 2 &&
      //                 dataService == 2 ||
      //             layananHomeC.statusOrderDetail.value == 4 &&
      //                 dataService == 2
      //         ? 220
      //         : 210,
      // data: dataLayanan == 0,
      // pasienTitle: dataLayanan == 99 ? 'Pasien melewatkan jadwal ordernya' : "",
      // pasienSubtitle: dataLayanan == 99
      //     ? 'Tunggu pasien untuk mengatur jadwal order selanjutnya'
      //     : "",
      // terlewatkan: dataLayanan == 99 ? 'Terlewatkan' : "",
      // statusVerifikasi: dataLayanan == 0
      //     ? myC.listOrderHospital[index]['order']['status'] == 0
      //         ? "Pasien belum melakukan pembayaran"
      //         : 'Ter-verifikasi sudah bayar'
      //     : myC.listOrderHospital[index]['order']['status'] == 1
      //         ? 'Ter-verifikasi sudah bayar'
      //         : "Ter-verifikasi sudah bayar",
      imageUrl: layananHomeC.dataListOrder[index]['order']['customer']
              ['image'] ??
          "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg",
      name: layananHomeC.dataListOrder[index]['order']['customer']['name']
          .toString(),
      totalPrice: layananHomeC.dataListOrder[index]['order']['totalPrice'],
      //  -
      //     layananHomeC.dataListOrder[index]['order']['discount'],
      tanggal: layananHomeC.dataListOrder[index]['order']['date'],
      codeOrder: layananHomeC.dataListOrder[index]['order']['code'],
      jamMulai: layananHomeC.dataListOrder[index]['order']
          ['startDateAmbulance'],
      jamSelesai: layananHomeC.dataListOrder[index]['order']
          ['endDateAmbulance'],

      // layanan: layananHomeC.dataListOrder[index]['order']['service_price']['name'].toString()
    );
  }
}

// ignore: must_be_immutable
class DetailPesan extends StatelessWidget {
  DetailPesan(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.time,
      required this.button,
      required this.orderId,
      this.status,
      this.imageNetwork,
      required this.dataPesan,
      required this.rating})
      : super(key: key);

  String imageUrl;
  String? imageNetwork;
  int? status;
  String title;
  String subtitle;
  String time;
  String orderId;
  Widget button;
  Widget rating;
  // ignore: prefer_typing_uninitialized_variables
  var dataPesan;

  // final controller = Get.put(PesanController());
  // final layananHomeC = Get.put(LayananHomeController());
  // final myC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 18, top: 14),
            width: Get.width / 1.9,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffEDEDED)),
          ),
          // status == 5 ? Image.network(imageNetwork ?? "https://picsum.photos/seed/picsum/200/300", width: 110,) :
          Image.asset(
            imageUrl,
            width: 55,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            Get.find<PesanController>().tanggalPesan.value,
            // DateFormat('d MMMM y, kk:mm', "id_ID").format(
            //     DateTime.parse(
            //         Get.find<PesanController>().tanggalPesan.value)),
            style: blackTextStyle.copyWith(
                fontWeight: normal, color: const Color(0xff555555)),
          ),
          const SizedBox(
            height: 10.0,
          ),
          // rating,
          const SizedBox(
            height: 8,
          ),
          // rating!,
          // SizedBox(
          //   width: Get.width,
          //   child: AutoSizeText(
          //     subtitle,
          //     style: subtitleTextStyle,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Cntr(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            radius: BorderRadius.circular(10),
            color: const Color(0xffEFEFEF),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Code Order',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Txt(text: Get.find<PesanController>().orderCode.value)
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          cardPerawat(
              'Pasien :',
              dataPesan['order'] == null && dataPesan['ambulance_order'] == null
                  ? dataPesan['nurse_order']['customer']['name'] ?? "null"
                  : dataPesan['ambulance_order'] != null
                      ? dataPesan['ambulance_order']['customer']['name']
                      : dataPesan['order']['customer']['name'] ?? "null",
              dataPesan['order'] == null && dataPesan['ambulance_order'] == null
                  ? dataPesan['nurse_order']['customer']['image'] ?? "null"
                  : dataPesan['ambulance_order'] != null
                      ? dataPesan['ambulance_order']['customer']['image']
                      : dataPesan['order']['customer']['image'] ?? "null"),
          const SizedBox(
            height: 20.0,
          ),
          cardPerawat(
              'Layanan :',
              dataPesan['order'] == null && dataPesan['ambulance_order'] == null
                  ? dataPesan['nurse_order']['service']['name'] ?? "null"
                  : dataPesan['ambulance_order'] != null
                      ? dataPesan['ambulance_order']['service']['name'] ??
                          "null"
                      : dataPesan['order']['service']['name'] ?? "null",
              dataPesan['order'] == null && dataPesan['ambulance_order'] == null
                  ? dataPesan['nurse_order']['service']['image'] ?? "null"
                  : dataPesan['ambulance_order'] != null
                      ? dataPesan['ambulance_order']['service']['image'] ??
                          "null"
                      : dataPesan['order']['service']['image'] ?? "null"),
          const SizedBox(
            height: 20.0,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: Visibility(
          //     // visible:
          dataPesan['order'] == null && dataPesan['ambulance_order'] == null
              ?
              // child:
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: detailPasienNurse(dataPesan['nurse_order']),
                )
              : dataPesan['ambulance_order'] != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Cntr(
                            margin: const EdgeInsets.only(bottom: 15),
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            width: Get.width,
                            border: Border.all(color: Colors.grey[400]!),
                            radius: BorderRadius.circular(10),
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Image.asset('assets/icon/maps.png'),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Txt(text: 'Lokasi Penjemputan'),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Txt(
                                      text:
                                          "${dataPesan['ambulance_order']['start_districts']},${dataPesan['ambulance_order']['start_city']} ${dataPesan['ambulance_order']['start_province']}\n ${dataPesan['ambulance_order']['start_address']}"),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await MapsLauncher.launchCoordinates(
                                        dataPesan['ambulance_order']
                                            ['start_lat'],
                                        dataPesan['ambulance_order']
                                            ['start_long'],
                                        "${dataPesan['ambulance_order']['start_districts']},${dataPesan['ambulance_order']['start_city']} ${dataPesan['ambulance_order']['start_province']}\n ${dataPesan['ambulance_order']['start_address']}");
                                  },
                                  child: Cntr(
                                    radius: BorderRadius.circular(10),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    height: 30,
                                    width: Get.width,
                                    color: Colors.blue,
                                    child: Txt(
                                      text: 'Lihat Lokasi Maps',
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Cntr(
                            margin: const EdgeInsets.only(bottom: 15),
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            width: Get.width,
                            border: Border.all(color: Colors.grey[400]!),
                            radius: BorderRadius.circular(10),
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Image.asset('assets/icon/maps.png'),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Txt(text: 'Lokasi Tujuan'),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Txt(
                                      text:
                                          "${dataPesan['ambulance_order']['end_districts']},${dataPesan['ambulance_order']['end_city']} ${dataPesan['ambulance_order']['end_province']}\n ${dataPesan['ambulance_order']['end_address']}"),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await MapsLauncher.launchCoordinates(
                                        dataPesan['ambulance_order']['end_lat'],
                                        dataPesan['ambulance_order']
                                            ['end_long'],
                                        "${dataPesan['ambulance_order']['end_districts']},${dataPesan['ambulance_order']['end_city']} ${dataPesan['ambulance_order']['end_province']}\n ${dataPesan['ambulance_order']['end_address']}");
                                  },
                                  child: Cntr(
                                    radius: BorderRadius.circular(10),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    height: 30,
                                    width: Get.width,
                                    color: Colors.blue,
                                    child: Txt(
                                      text: 'Lihat Lokasi Maps',
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : dataPesan['order']['service']['sequence'] == 2
                      ? Column(
                          children: [
                            detailPasienHomeVisit(dataPesan),
                            detailPesananPasien(dataPesan),
                          ],
                        )
                      : detailPesananPasien(dataPesan),
          // ),

          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   width: Get.width,
          //   decoration: BoxDecoration(
          //     color: Colors.grey[300],
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(10.0),
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Code Order',
          //             style: greyTextStyle,
          //           ),
          //           Text(
          //             Get.find<PesanController>().orderCode.value,
          //             style: blackTextStyle.copyWith(),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10.0,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Tanggal Pemesanan',
          //             style: greyTextStyle.copyWith(
          //                 fontWeight: normal, fontSize: 12),
          //           ),
          //           Text(
          //             Get.find<PesanController>().tanggalPesan.value,
          //             // DateFormat('d MMMM y, kk:mm', "id_ID").format(
          //             //     DateTime.parse(
          //             //         Get.find<PesanController>().tanggalPesan.value)),
          //             style: blackTextStyle.copyWith(
          //                 fontWeight: bold, color: const Color(0xff555555)),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 6.0,
          //       ),
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'Mulai Order',
          //                   style: greyTextStyle.copyWith(
          //                       fontWeight: normal, fontSize: 12),
          //                 ),
          //                 const SizedBox(
          //                   height: 6.0,
          //                 ),
          //                 Text(
          //                   'Selesai Order',
          //                   style: greyTextStyle.copyWith(
          //                       fontWeight: normal, fontSize: 12),
          //                 ),
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 Text(
          //                   // "${Get.find<PesanController>()
          //                   //         .jamMulai
          //                   //         .value}",
          //                   DateFormat('d MMMM y,kk:mm:ss', "id_ID").format(
          //                       DateTime.parse(Get.find<PesanController>()
          //                           .jamMulai
          //                           .value)),
          //                   // CurrencyFormat.convertToIdr(discount, 0),
          //                   style: blackTextStyle.copyWith(
          //                       fontWeight: bold,
          //                       color: const Color(0xff555555)),
          //                 ),
          //                 const SizedBox(
          //                   height: 6.0,
          //                 ),
          //                 Text(
          //                   // "${Get.find<PesanController>()
          //                   //         .jamSelesai
          //                   //         .value}",
          //                   DateFormat('d MMMM y,kk:mm:ss', "id_ID").format(
          //                       DateTime.parse(Get.find<PesanController>()
          //                           .jamSelesai
          //                           .value)),
          //                   // CurrencyFormat.convertToIdr(discount, 0),
          //                   style: blackTextStyle.copyWith(
          //                       fontWeight: bold,
          //                       color: const Color(0xff555555)),
          //                 ),
          //               ],
          //             ),
          //           ])
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15.0,
          ),
          // Text(
          //   time,
          //   style: subtitleTextStyle,
          //   textAlign: TextAlign.center,
          // ),
          const SizedBox(
            height: 24,
          ),
          button,
          const SizedBox(
            height: 24,
          ),

          // InputText(label: 'label'),
        ],
      ),
    );
  }

  Padding detailPasienHomeVisit(dataPesanHomeVisit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Cntr(
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.centerLeft,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            width: Get.width,
            border: Border.all(color: const Color(0xffE2E2E2)),
            radius: BorderRadius.circular(10),
            child: ExpansionTile(
              title: Row(
                children: [
                  Image.asset('assets/icon/maps.png'),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Txt(text: 'Detail Rumah Pasien'),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Txt(text: dataPesanHomeVisit['order']['address']),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    await MapsLauncher.launchCoordinates(
                        dataPesanHomeVisit['order']['lat'],
                        dataPesanHomeVisit['order']['long'],
                        dataPesanHomeVisit['order']['address']);
                  },
                  child: Cntr(
                    radius: BorderRadius.circular(10),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    height: 30,
                    width: Get.width,
                    color: Colors.blue,
                    child: Txt(
                      text: 'Lihat Lokasi Maps',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Cntr(
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.centerLeft,
            width: Get.width,
            border: Border.all(color: const Color(0xffE2E2E2)),
            radius: BorderRadius.circular(10),
            child: ExpansionTile(
              title: Row(
                children: [
                  Image.asset('assets/icon/pasien1.png'),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Txt(text: 'Detail Pasien'),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // Cntr(
                      //   height: 200,
                      //   width: 200,
                      //   child: CachedNetworkImage(
                      //     imageUrl: dataPesanHomeVisit['image'],
                      //     placeholder: (context, url) => Center(
                      //         child: Transform.scale(
                      //       scale: 0.5,
                      //       child: const CircularProgressIndicator(),
                      //     )),
                      //     errorWidget: (context, url, error) =>
                      //         const Icon(Icons.error),
                      //   ),
                      // ),
                      // Image.network(
                      //     homeC.dataReminderNurse['patient_image']),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 100, child: Txt(text: 'Nama Pasien')),
                          Txt(text: ':   '),
                          SizedBox(
                              width: 150,
                              child: Txt(
                                text: dataPesanHomeVisit['order']['customer']
                                    ['name'],
                                weight: bold,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              log(dataPesanHomeVisit['order'].toString());
                            },
                            child: SizedBox(
                                width: 100, child: Txt(text: 'Jenis Kelamin')),
                          ),
                          Txt(text: ':   '),
                          SizedBox(
                              width: 150,
                              child: Txt(
                                text: dataPesanHomeVisit['order']['gender'] ??
                                    "null",
                                weight: bold,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 100, child: Txt(text: 'Umur')),
                          Txt(text: ':   '),
                          SizedBox(
                              width: 150,
                              child: Txt(
                                text: dataPesanHomeVisit['order']['age'] ??
                                    "null",
                                weight: bold,
                              )),
                        ],
                      ),
                      Cntr(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        radius: BorderRadius.circular(10),
                        height: 120,
                        width: Get.width,
                        color: Colors.grey[200],
                        child: Txt(
                            text: dataPesanHomeVisit['order']['description']),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column detailPasienNurse(var dataPesan) {
    return Column(
      children: [
        Cntr(
          margin: const EdgeInsets.only(bottom: 15),
          alignment: Alignment.centerLeft,
          // padding: EdgeInsets.symmetric(horizontal: 20),
          width: Get.width,
          border: Border.all(color: const Color(0xffE2E2E2)),
          radius: BorderRadius.circular(10),
          child: ExpansionTile(
            title: Row(
              children: [
                Image.asset('assets/icon/maps.png'),
                const SizedBox(
                  width: 10.0,
                ),
                Txt(text: 'Detail Rumah Pasien'),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Txt(text: dataPesan['address']),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () async {
                  await MapsLauncher.launchCoordinates(dataPesan['lat'],
                      dataPesan['long'], dataPesan['address']);
                },
                child: Cntr(
                  radius: BorderRadius.circular(10),
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 30,
                  width: Get.width,
                  color: Colors.blue,
                  child: Txt(
                    text: 'Lihat Lokasi Maps',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Cntr(
          margin: const EdgeInsets.only(bottom: 15),
          alignment: Alignment.centerLeft,
          width: Get.width,
          border: Border.all(color: const Color(0xffE2E2E2)),
          radius: BorderRadius.circular(10),
          child: ExpansionTile(
            title: Row(
              children: [
                Image.asset('assets/icon/pasien1.png'),
                const SizedBox(
                  width: 10.0,
                ),
                Txt(text: 'Detail Pasien'),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Cntr(
                      height: 200,
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl: dataPesan['patient_image'],
                        placeholder: (context, url) => Center(
                            child: Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(),
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    // Image.network(
                    //     homeC.dataReminderNurse['patient_image']),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 100, child: Txt(text: 'Nama Pasien')),
                        Txt(text: ':   '),
                        SizedBox(
                            width: 150,
                            child: Txt(
                              text: dataPesan['name'],
                              weight: bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 100, child: Txt(text: 'Jenis Kelamin')),
                        Txt(text: ':   '),
                        SizedBox(
                            width: 150,
                            child: Txt(
                              text: dataPesan['gender'],
                              weight: bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 100, child: Txt(text: 'Umur')),
                        Txt(text: ':   '),
                        SizedBox(
                            width: 150,
                            child: Txt(
                              text: dataPesan['old'].toString(),
                              weight: bold,
                            )),
                      ],
                    ),
                    Cntr(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      radius: BorderRadius.circular(10),
                      height: 120,
                      width: Get.width,
                      color: Colors.grey[200],
                      child: Txt(text: dataPesan['description']),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Cntr(
          margin: const EdgeInsets.only(bottom: 15),
          alignment: Alignment.centerLeft,
          width: Get.width,
          border: Border.all(color: const Color(0xffE2E2E2)),
          radius: BorderRadius.circular(10),
          child: ExpansionTile(
            title: Row(
              children: [
                Image.asset('assets/icon/kebutuhan.png'),
                const SizedBox(
                  width: 10.0,
                ),
                Txt(text: 'Kebutuhan Pasien'),
              ],
            ),
            children: [
              Cntr(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 50.0 *
                      Get.find<LayananHomeController>().packageNurseSops.length,
                  child: ListView.builder(
                    itemCount: Get.find<LayananHomeController>()
                        .packageNurseSops
                        .length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        log(dataPesan.toString());
                      },
                      child: ListTile(
                        leading: Cntr(
                          height: 50,
                          width: 50,
                          child: Image.asset('assets/icon/kebutuhan.png'),
                        ),
                        title: Text(Get.find<LayananHomeController>()
                                .packageNurseSops[index]['nurse_work_scope']
                            ['name']),
                        // leading: Cntr(
                        //   height: 50,
                        //   width: 50,
                        //   image: const DecorationImage(
                        //       image:
                        //           AssetImage('assets/images/banner1.png'),
                        //       fit: BoxFit.cover),
                        // ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Cntr cardPerawat(String title, String subtitle, String image) {
    return Cntr(
      border: Border.all(color: const Color(0xffE2E2E2)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      radius: BorderRadius.circular(10),
      child: Row(
        children: [
          Cntr(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            height: 45,
            width: 45,
            color: Colors.grey,
            radius: BorderRadius.circular(100),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                text: title,
                size: 12,
              ),
              Txt(
                text: subtitle,
                size: 16,
                weight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }

  Row detailPesanList({required String title, required String detail}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 2.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                text: title,
                color: Colors.grey,
              ),
              Txt(
                text: ':',
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Txt(
          text: detail,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Cntr detailPesananPasien(var detailPesan) {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      border: Border.all(color: const Color(0xffE2E2E2)),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Row(
            children: [
              Image.asset('assets/icon/icon_pesan.png'),
              const SizedBox(
                width: 15.0,
              ),
              Txt(
                text: 'Detail Pesanan',
                weight: FontWeight.bold,
              ),
            ],
          ),
          children: [
            Cntr(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  // Get.find<ControllerLogin>().dataNotif[index]['order'] == null
                  //     ? detailPesan(
                  //         title: 'Paket',
                  //         detail: Get.find<ControllerLogin>()
                  //             .dataNotif[index]['nurse_order']['package_name']
                  //             .toString(),
                  //         index: index)
                  //     :
                  const SizedBox(
                    height: 1.0,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesanList(
                      title: 'Harga',
                      detail: detailPesan['order'] == null
                          ? CurrencyFormat.convertToIdr(
                              detailPesan['nurse_order']['totalPrice'], 0)
                          : CurrencyFormat.convertToIdr(
                              detailPesan['order']['totalPrice'], 0)),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesanList(
                      title: 'Diskon',
                      detail: detailPesan['order'] == null
                          ? "${detailPesan['nurse_order']['discount']} %"
                          : "${detailPesan['order']['discount']} %"),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesanList(
                      title: 'Metope pembayaran',
                      detail: Get.put(DetailController()).bankName.value),
                  const SizedBox(
                    height: 12.0,
                  ),
                  detailPesanList(
                    title: 'Total pembayaran',
                    detail: detailPesan['order'] == null
                        ? CurrencyFormat.convertToIdr(
                            detailPesan['nurse_order']['subtotal'], 0)
                        : CurrencyFormat.convertToIdr(
                            detailPesan['order']['subtotal'], 0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 14,
                      ),
                      Txt(
                        text: 'Terverifikasi bayar',
                        color: Colors.green,
                        size: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
