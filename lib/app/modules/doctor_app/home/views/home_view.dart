import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bionmed/app/modules/doctor_app/chat/views/chat_dokter.dart';
import 'package:bionmed/app/modules/doctor_app/detail/controllers/detail_controller.dart';
import 'package:bionmed/app/modules/doctor_app/kirim_resep/kirim_resep.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../../../theme.dart';
import '../../../../widget/button/button_gradien.dart';
import '../../../../widget/button/button_primary_withtext.dart';
import '../../../../widget/card/card_layanan.dart';
import '../../../../widget/card/carousel_banner.dart';
import '../../connection/views/call/voice_screen.dart';
import '../../connection/views/videocall_screen.dart';
import '../../detail/views/detail_view.dart';
import '../../profile/views/pendapatan_view.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  final myC = Get.put(HomeController());
  final loginC = Get.find<LoginController>();
  final layananHomeC = Get.put(LayananHomeController());
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  final _ctrl = ScrollController(initialScrollOffset: 5000000 * 100.0);
  notif() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            bigPicture: "assets/icon/logo-doctor.png",
            id: 10,
            channelKey: 'basic_channel',
            title: 'BionMed',
            body: 'Layanan Akan Segera Mulai',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var reverselist = layananHomeC.dataListOrder.reversed.toList();
    layananHomeC.addOrder();
    // layananHomeC.realtimeApi();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    width: Get.width,
                    child: Image.asset(
                      'assets/icon/Ellipse 179.png',
                    )),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 24, right: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              loginC.name.isEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Txt(
                                          text:
                                              'Login/Daftar untuk menggunakan layanan kami',
                                          color: whiteColor,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.ACCOUNT);
                                          },
                                          child: Cntr(
                                            padding: EdgeInsets.all(15),
                                            radius: BorderRadius.circular(6),
                                            color: Color(0XffFFBC26),
                                            child: Txt(
                                              text: 'Login/Daftar',
                                              color: whiteColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // controller.getDetailNurse();
                                            // Get.find<LayananHomeController>()
                                            //     .addOrder();
                                            // Get.toNamed(Routes.ACCOUNT);
                                            // controller.reminderOrderNurse();
                                            // Get.put(PesananMasukPerawatController()).startCountingAcceptOrder();
                                            // print('zezen' + controller.willPopUp.value.toString());
                                            // print('zezen' + controller.statusCode.value.toString());
                                            // controller.getDetailDoctor(); //
                                            // notif();
                                          },
                                          child: Text(
                                            'Selamat Siang',
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: normal),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: Get.width / 1.4,
                                          child: Text(
                                            '${loginC.name}',
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 20, fontWeight: bold),
                                          ),
                                        )
                                      ],
                                    ),
                              // Column(
                              //   children: [
                              //     Image.asset('assets/icon/icon_star.png'),
                              //     const SizedBox(
                              //       height: 8,
                              //     ),
                              //     Text(
                              //       '${loginC.rating}',
                              //       style: whiteTextStyle.copyWith(
                              //           fontSize: 20, fontWeight: bold),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Container(
                            width: Get.width,
                            // height: 62,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 20,
                                      offset: Offset(0, 5),
                                      color: Colors.grey)
                                ],
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //     'assets/icon/icon_wallet.png'),
                                      Cntr(
                                        height: 65,
                                        width: 65,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/icon/icon_wallet.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      Text(
                                        'Pendapatan :',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => PendapatanView());
                                  },
                                  child: SizedBox(
                                      width: 120,
                                      child: Obx(
                                        () => AutoSizeText(
                                          maxLines: 1,
                                          CurrencyFormat.convertToIdr(
                                              controller.pendapatan.value, 0),
                                          style: greenTextStyle.copyWith(
                                              fontWeight: bold, fontSize: 24),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => CarouselSlider(
                          items: controller.dataBanner
                              .map((element) => Container(
                                    width: 312,
                                    height: 128,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        color: Colors.grey[300],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${element['image']}'),
                                            fit: BoxFit.cover)),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayInterval:
                                const Duration(milliseconds: 3200),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            pauseAutoPlayOnTouch: true,
                            height: 128,
                            pageSnapping: false,
                            aspectRatio: 16 / 9,
                          )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Layanan Masuk',
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.LAYANAN_HOME);
                                },
                                child: Text(
                                  'Lihat Semua',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                      color: blueColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 400,
                            child: Obx(
                                () => layananHomeC.dataListOrder.isNotEmpty
                                    ? ListView.builder(
                                        controller: loginC.role.value == 'nurse'
                                            ? _ctrl
                                            : null,
                                        reverse: loginC.role.value == 'nurse'
                                            ? layananHomeC
                                                        .dataListOrder.length ==
                                                    1
                                                ? false
                                                : true
                                            : false,
                                        shrinkWrap: false,
                                        // physics:
                                        //     const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            layananHomeC.dataListOrder.length,
                                        itemBuilder: (context, index) {
                                          var layanan = loginC.role.value ==
                                                  'nurse'
                                              ? ""
                                              : layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['service_price']
                                                  ['name'];
                                          var dataService = loginC.role.value ==
                                                  'nurse'
                                              ? ""
                                              : layananHomeC
                                                      .dataListOrder[index]
                                                  ['order']['service']['name'];
                                          var dataLayanan =
                                              loginC.role.value == 'nurse'
                                                  ? ""
                                                  : layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['status'];

                                          //LAYANAN NURSE
                                          var statusOrderNurse =
                                              loginC.role.value != 'nurse'
                                                  ? ""
                                                  : layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['status'];
                                          var serviceName = loginC.role.value !=
                                                  'nurse'
                                              ? ""
                                              : layananHomeC
                                                      .dataListOrder[index]
                                                  ['order']['service']['name'];
                                          var servicePriceName = loginC
                                                      .role.value !=
                                                  'nurse'
                                              ? ""
                                              : layananHomeC.dataListOrder[
                                                          index]['order']
                                                      ['service_price_nurse']
                                                  ['name'];

                                          return dataLayanan != 0
                                              ? loginC.role.value == 'nurse' &&
                                                      statusOrderNurse != 0
                                                  ? CardLayananNurseOrder(
                                                      servicePriceName,
                                                      index,
                                                      statusOrderNurse,
                                                      serviceName,
                                                      context)
                                                  // CardServiceNurse(
                                                  //     myC: layananHomeC,
                                                  //     statusList: 3,
                                                  //     statusList1: 4,
                                                  //     statusList2: 2,
                                                  //     statusList3: 6,
                                                  //   )
                                                  : loginC.role.value == 'nurse'
                                                      ? const SizedBox(
                                                          height: 1.0,
                                                        )
                                                      : CardLayananOrder(
                                                          layanan,
                                                          index,
                                                          dataLayanan,
                                                          dataService,
                                                          context)
                                              : const SizedBox(
                                                  height: 1.0,
                                                );
                                        })
                                    : const Center(
                                        child: Text("Belum ada pesanan"))
                                //  Center(child: Text('Tidak ada data'))
                                ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  CardLayanan CardLayananOrder(
      layanan, int index, dataLayanan, dataService, BuildContext context) {
    return CardLayanan(
        iconlayanan: layanan == 'Layanan Video Call'
            ? 'assets/icon/icon_vcall.png'
            : layanan == 'Layanan Chat'
                ? 'assets/icon/icon_chat.png'
                : layanan == 'Home Visit'
                    ? 'assets/icon/icon_homevisit.png'
                    : 'assets/icon/icon_call.png',
        service1: layananHomeC.dataListOrder[index]['order']['service_price']
            ['name'],
        iconService: layananHomeC.dataListOrder[index]['order']['service']
            ['image'],
        // iconlayanan: layananHomeC.dataListOrder[index]['order']['service']['image'],
        tanggal: DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(
          DateTime.parse(
            layananHomeC.dataListOrder[index]['order']['startDateDoctor'],
          ),
        ),
        service: layananHomeC.dataListOrder[index]['order']['service']['name'],
        color: dataLayanan == 4
            ? blueColor!
            : dataLayanan == 6 || dataLayanan == 5
                ? greenColor!
                : dataLayanan == 0
                    ? buttonColor!
                    : dataLayanan == 3
                        // ||
                        //         dataService ==
                        //             'Telemedicine'
                        ? blueColor!
                        : dataLayanan == 1
                            ? greenColor!
                            : dataLayanan == 2
                                ? Colors.amber
                                : Colors.red,
        label: dataLayanan == 4
            ? 'Sedang berlangsung'
            : dataLayanan == 6
                ? "Konfirmasi selesai"
                : dataLayanan == 5
                    ? 'Selesai'
                    : dataLayanan == 0
                        ? "Belum bayar"
                        : dataLayanan == 3
                            //  ||
                            // dataService == 'Telemedicine'
                            ? 'Mulai sekarang'
                            : dataLayanan == 2
                                // ||
                                // dataService == 'Dokter on Call'
                                ? "Terjadwalkan"
                                : dataLayanan == 99
                                    ? "Terlewatkan"
                                    : dataLayanan == 1
                                        ? "Sudah bayar"
                                        : '',
        // '${dataLayanan} ',
        imageUrl: layananHomeC.dataListOrder[index]['order']['customer']
                ['image'] ??
            "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg",
        name: layananHomeC.dataListOrder[index]['order']['customer']['name'] !=
                null
            ? "${layananHomeC.dataListOrder[index]['order']['customer']['name']}"
            : "Tidak Ditemukan",
        onTap: () async {
          Get.find<HomeController>().imageCostomer.value =
              layananHomeC.dataListOrder[index]['order']['customer']['image'] ??
                  "https://picsum.photos/200/300/?blur";
          Get.find<LayananHomeController>().idOrder.value =
              layananHomeC.dataListOrder[index]['order']['id'];
          myC.lat.value = double.parse(
              layananHomeC.dataListOrder[index]['order']['lat'].toString());
          myC.long.value = double.parse(
              layananHomeC.dataListOrder[index]['order']['long'].toString());
          if (layanan == 'Home Visit') {
            myC.address.value =
                layananHomeC.dataListOrder[index]['order']['address'];
          }
          
          myC.statusOrderDetail.value = Get.find<LayananHomeController>()
              .dataListOrder[index]['order']['statusOrder'];
          // myC.timePeriodic.value = false;
          // myC.realtimeApiGet.value = false;
          // if (myC.realtimeApiGet.isFalse) {
          //  await myC.realtimeApi();
          // }
          Get.put(DetailController()).stop = false;
          final detailC = Get.put(DetailController());
          detailC.paymentName.value =
              layananHomeC.dataListOrder[index]["payment"]['debit_from_bank'];
          detailC.bankName.value =
              layananHomeC.dataListOrder[index]["payment"]['product_code'];
          detailC.imageRecipe.value =
              layananHomeC.dataListOrder[index]["order"]['image_recipe'] ?? "";
          await layananHomeC.startTime();
          Get.find<LayananHomeController>().idOrder.value =
              layananHomeC.dataListOrder[index]['order']['id'];
          myC.orderMinute.value = layananHomeC.dataListOrder[index]['order']
              ['service_price']['minute'];
          //  await layananHomeC.getOrder();

          // Get.toNamed(Routes.DETAIL);

          Get.to(
            () => navigationDetailOrder(
                dataLayanan, dataService, index, context, layanan),
          );
        },
        price: layananHomeC.dataListOrder[index]['order']['totalPrice']);
  }

  //NURSE
  // ignore: non_constant_identifier_names
  CardLayanan CardLayananNurseOrder(
      layanan, int index, dataLayanan, dataService, BuildContext context) {
    return CardLayanan(
        iconlayanan: 'assets/icon/icon2.png',
        service1: layananHomeC.dataListOrder[index]['order']['service']['name'],
        iconService: layananHomeC.dataListOrder[index]['order']['service']
            ['image'],
        // iconlayanan: layananHomeC.dataListOrder[index]['order']['service']['image'],
        tanggal: DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(
          DateTime.parse(
            layananHomeC.dataListOrder[index]['order']['startDateNurse'],
          ),
        ),
        service: layananHomeC.dataListOrder[index]['order']['service']['name'],
        color: dataLayanan == 4
            ? blueColor!
            : dataLayanan == 6 || dataLayanan == 5
                ? greenColor!
                : dataLayanan == 0
                    ? buttonColor!
                    : dataLayanan == 3
                        // ||
                        //         dataService ==
                        //             'Telemedicine'
                        ? blueColor!
                        : dataLayanan == 1
                            ? greenColor!
                            : dataLayanan == 2
                                ? Colors.amber
                                : Colors.red,
        label: dataLayanan == 4
            ? 'Sedang berlangsung'
            : dataLayanan == 6
                ? "Konfirmasi selesai"
                : dataLayanan == 5
                    ? 'Selesai'
                    : dataLayanan == 0
                        ? "Belum bayar"
                        : dataLayanan == 3
                            //  ||
                            // dataService == 'Telemedicine'
                            ? 'Mulai sekarang'
                            : dataLayanan == 2
                                // ||
                                // dataService == 'Dokter on Call'
                                ? "Terjadwalkan"
                                : dataLayanan == 99
                                    ? "Terlewatkan"
                                    : dataLayanan == 1
                                        ? "Sudah bayar"
                                        : 'Dibatalkan',
        // '${dataLayanan} ',
        imageUrl: layananHomeC.dataListOrder[index]['order']['customer']
                ['image'] ??
            "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg",
        name: layananHomeC.dataListOrder[index]['order']['name'] != null
            ? "${layananHomeC.dataListOrder[index]['order']['customer']['name']}"
            : "Tidak Ditemukan",
        onTap: () async {
          if (layananHomeC.dataListOrder[index]["payment"] != null) {
            Get.put(DetailController()).paymentName.value =
                layananHomeC.dataListOrder[index]["payment"]['debit_from_bank'];
            Get.put(DetailController()).bankName.value =
                layananHomeC.dataListOrder[index]["payment"]['product_code'];
          } else {}
          Get.find<LayananHomeController>().idOrder.value =
              layananHomeC.dataListOrder[index]['order']['id'];

          // Get.find<LayananHomeController>().idOrder.value =
          //     layananHomeC.dataListOrder[index]['order']['id'];
          // myC.lat.value = layananHomeC.dataListOrder[index]['order']['lat'];
          // myC.long.value = layananHomeC.dataListOrder[index]['order']['long'];
          // if (layanan == 'Home Visit') {
          //   myC.address.value =
          //       layananHomeC.dataListOrder[index]['order']['address'];
          // }
          // myC.statusOrderDetail.value = Get.find<LayananHomeController>()
          //     .dataListOrder[index]['order']['statusOrder'];
          // // myC.timePeriodic.value = false;
          // // myC.realtimeApiGet.value = false;
          // // if (myC.realtimeApiGet.isFalse) {
          // //  await myC.realtimeApi();
          // // }
          // Get.put(DetailController()).stop = false;
          // final detailC = Get.put(DetailController());
          // detailC.paymentName.value =
          //     layananHomeC.dataListOrder[index]["payment"]['product_code'];
          // detailC.imageRecipe.value =
          //     layananHomeC.dataListOrder[index]["order"]['image_recipe'] ?? "";
          // await layananHomeC.startTime();
          // Get.find<LayananHomeController>().idOrder.value =
          //     layananHomeC.dataListOrder[index]['order']['id'];
          // myC.orderMinute.value = layananHomeC.dataListOrder[index]['order']
          // ['service_price']['minute'];
          //  await layananHomeC.getOrder();
          myC.lat.value = layananHomeC.dataListOrder[index]['order']['lat'];
          myC.long.value = layananHomeC.dataListOrder[index]['order']['long'];
          myC.address.value =
              layananHomeC.dataListOrder[index]['order']['address'];
          // layananHomeC.statusOrderDetail.value = 5;

          // Get.toNamed(Routes.DETAIL);
          // print('zaza ' + layananHomeC.dataListOrder[index]['id'].toString());
          log(layananHomeC.dataListOrder.toString());
          Get.to(
            () => navigationDetailOrderNurse(
                dataLayanan, dataService, index, context, layanan),
          );
        },
        price: layananHomeC.dataListOrder[index]['order']['totalPrice']);
  }

  DetailView navigationDetailOrder(
      dataLayanan, dataService, int index, BuildContext context, layanan) {
    return DetailView(
      iconPembayaran: Obx(
        () => layananHomeC.statusOrderDetail.value == 0
            ? const Icon(Icons.cancel)
            : Icon(
                Icons.check_circle,
                color: greenColor,
              ),
      ),
      statusPembayaran: Obx(() => layananHomeC.statusOrderDetail.value == 0
          ? Txt(text: 'Belum melakukan pembayaran', size: 11, weight: medium)
          : Txt(text: "Ter-verifikasi sudah bayar", size: 11, weight: medium)),
      statusOrderImage: Obx(
        () => layananHomeC.statusOrderDetail.value == 0
            ? StatusImage(
                onTap: () {},
                imageUrl: '0',
                title: 'Pasien belum bayar',
                subtitle:
                    "Pasien belum melakukan pembayaran untuk \nlayanan yang dipilih")
            : layananHomeC.statusOrderDetail.value == 2 ||
                    layananHomeC.statusOrderDetail.value == 3 ||
                    layananHomeC.statusOrderDetail.value == 4 ||
                    layananHomeC.statusOrderDetail.value == 1
                ? StatusImage(
                    onTap: () {},
                    imageUrl: '34',
                    title: 'Konsultasi berlangsung',
                    subtitle: "Tekan lihat konsultasi / lanjutkan")
                : layananHomeC.statusOrderDetail.value == 6 ||
                        layananHomeC.statusOrderDetail.value == 5
                    ? StatusImage(
                        onTap: () {},
                        imageUrl: '56',
                        title: 'Konsultasi Selesai',
                        subtitle: "Sesi konsultasi telah selesai")
                    : dataService == "Telemedicine" &&
                                layananHomeC.statusOrderDetail.value == 99 ||
                            dataService == "Dokter on Call" &&
                                layananHomeC.statusOrderDetail.value == 99
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
        () => layananHomeC.statusOrderDetail.value == 0
            ? InfoOrder(onTap: () {}, status: '0')
            : layananHomeC.statusOrderDetail.value == 2
                ? InfoOrder(onTap: () {}, status: '22')
                : layananHomeC.statusOrderDetail.value == 1
                    ? InfoOrder(onTap: () {}, status: '22')
                    : layananHomeC.statusOrderDetail.value == 3
                        ? InfoOrder(onTap: () {}, status: '3')
                        : layananHomeC.statusOrderDetail.value == 4
                            ? InfoOrder(onTap: () {}, status: '4')
                            : layananHomeC.statusOrderDetail.value == 6
                                ? InfoOrder(onTap: () {}, status: '6')
                                : layananHomeC.statusOrderDetail.value == 5
                                    ? InfoOrder(onTap: () {}, status: '5')
                                    : layananHomeC.statusOrderDetail.value == 99
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
      // discount: layananHomeC.dataListOrder[index]['order']['discount'],
      iconService: layananHomeC.dataListOrder[index]['order']['service']
          ['image'],
      service: layananHomeC.dataListOrder[index]['order']['service']['name'],
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
        () => layananHomeC.statusOrderDetail.value == 5
            ? Rating(
                rating: double.parse(layananHomeC.dataListOrder[index]['order']
                        ['rating']
                    .toString()),
              )
            : const SizedBox(),
      ),
      buttonGradient: Obx(
        () => layananHomeC.statusOrderDetail.value == 3 ||
                dataService == "Telemedicine" &&
                    layananHomeC.statusOrderDetail.value == 4 ||
                layananHomeC.statusOrderDetail.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 5 &&
                    layananHomeC.statusOrderDetail.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 7 ||
                // Get.find<DetailController>().imageRecipe.value == "" &&
                //     myC.statusOrderDetail.value != 5 ||
                // myC.statusOrderDetail.value != 7 || myC.statusOrderDetail.value != 5 ||
                dataService == "Home Visit Doctor" ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" &&
                    layananHomeC.statusOrderDetail.value == 2 ||
                layananHomeC.statusOrderDetail.value == 4 &&
                    dataService == "Home Visit Doctor" ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" // 'Dokter on Call'
            ? Obx(() => controller.loading.value == true
                ? loadingIndicator()
                : Column(
                    children: [
                      layananHomeC.statusOrderDetail.value == 4 &&
                                  dataService == "Home Visit Doctor" ||
                              dataService == "Nursing Home" ||
                              dataService == "Mother Care" ||
                              dataService == "Baby Care" ||
                              layananHomeC.statusOrderDetail.value == 3 &&
                                  dataService == "Home Visit Doctor" ||
                              dataService == "Nursing Home" ||
                              dataService == "Mother Care" ||
                              dataService == "Baby Care" ||
                              layananHomeC.statusOrderDetail.value == 2 &&
                                  dataService == "Home Visit Doctor" ||
                              dataService == "Nursing Home" ||
                              dataService == "Mother Care" ||
                              dataService == "Baby Care"
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
                      layananHomeC.statusOrderDetail.value == 4 &&
                              dataService == "Home Visit Doctor"
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
                                                  await layananHomeC.updateStatus(
                                                      orderId: layananHomeC
                                                              .dataListOrder[
                                                          index]['order']['id'],
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
                          : layananHomeC.statusOrderDetail.value == 5 &&
                                  dataService == "Home Visit Doctor"
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : layananHomeC.statusOrderDetail.value == 6 &&
                                      dataService == "Home Visit Doctor"
                                  ? const SizedBox(
                                      height: 1.0,
                                    )
                                  : ButtomGradient(
                                      label: dataService == "Telemedicine" &&
                                              layananHomeC.statusOrderDetail.value ==
                                                  4
                                          ? 'Sedang Berlangsung'
                                          : dataService == "Telemedicine" &&
                                                      layananHomeC
                                                              .statusOrderDetail
                                                              .value ==
                                                          5 ||
                                                  layananHomeC.statusOrderDetail.value ==
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
                                                      : dataService == "Telemedicine" &&
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
                                        if (controller.loading.value == false) {
                                          if (dataService == "Telemedicine" &&
                                                  layananHomeC.statusOrderDetail
                                                          .value ==
                                                      6 ||
                                              // dataService == "Home Visit Doctor" ||
                                              dataService == "Nursing Home" ||
                                              dataService == "Mother Care" ||
                                              dataService == "Baby Care" &&
                                                  layananHomeC.statusOrderDetail
                                                          .value ==
                                                      6) {
                                            Get.to(() => const KirimResep());
                                          } else {
                                            layananHomeC.doctorId = layananHomeC
                                                .dataListOrder[index]['order']
                                                    ['doctor']['userId']
                                                .toString();
                                            layananHomeC.userName = layananHomeC
                                                    .dataListOrder[index]
                                                ['order']['doctor']['name'];
                                            // if (dataService == "Dokter on Call" && dataLayanan == 4) {
                                            //   layananHomeC.updateStatus(
                                            //       orderId: layananHomeC.dataListOrder[index]['order']['id'],
                                            //       status: 6);
                                            //   print('Ubah Statusss==========-=-=-=-=0-=0');
                                            // }
                                            await ZIMKit().connectUser(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              id: layananHomeC
                                                  .dataListOrder[index]['order']
                                                      ['doctor']['userId']
                                                  .toString(),
                                            );
                                            var layanan = layananHomeC
                                                        .dataListOrder[index]
                                                    ['order']['service_price']
                                                ['name'];
                                            if (layanan == 'Layanan Chat') {
                                              //     controller.loading.value = true;
                                              // print('CWK' + controller.loading.value.toString()  );
                                              // controller.startTimer();
                                              Get.find<LayananHomeController>()
                                                  .idOrder
                                                  .value = layananHomeC
                                                      .dataListOrder[index]
                                                  ['order']['id'];
                                              await layananHomeC.getOrder();
                                              // ignore: use_build_context_synchronously
                                              ZIMKit()
                                                  .showDefaultNewPeerChatDialogChat(
                                                context,
                                                layananHomeC
                                                    .dataListOrder[index]
                                                        ['order']['customer']
                                                        ['userId']
                                                    .toString(),
                                              );
                                              layananHomeC.orderId.value =
                                                  layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['id'];
                                            } else if (layanan ==
                                                'Layanan Video Call') {
                                              layananHomeC.startTime();
                                              await layananHomeC.getOrder();
                                              Get.find<LayananHomeController>()
                                                  .idOrder
                                                  .value = layananHomeC
                                                      .dataListOrder[index]
                                                  ['order']['id'];
                                              // layananHomeC.updateStatusTimer(
                                              //     statusPayment:
                                              //         layananHomeC.statusPayment.value + 2,
                                              //     statusOrder:
                                              //         layananHomeC.statusOrderChat.value + 1);
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['id'],
                                                  status: 4);
                                              Get.to(VideoCallService(
                                                  orderId: layananHomeC.dataListOrder[index]
                                                      ['order']['id'],
                                                  userid: layananHomeC
                                                      .dataListOrder[index]['order']
                                                          ['doctor']['userId']
                                                      .toString(),
                                                  userName: layananHomeC.dataListOrder[index]
                                                          ['order']['doctor']
                                                      ['name'],
                                                  callId: layananHomeC
                                                      .dataListOrder[index]
                                                          ['order']['id']
                                                      .toString()));
                                            } else if (dataService ==
                                                    "Dokter on Call" &&
                                                dataLayanan == 4) {
                                              Get.back();
                                              layananHomeC.addOrder();
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['id'],
                                                  status: 5);
                                            } else if (layanan ==
                                                'Layanan Telephone') {
                                              layananHomeC.startTime();
                                              await layananHomeC.getOrder();
                                              Get.find<LayananHomeController>()
                                                  .idOrder
                                                  .value = layananHomeC
                                                      .dataListOrder[index]
                                                  ['order']['id'];
                                              // layananHomeC.updateStatusTimer(
                                              //     statusPayment:
                                              //         layananHomeC.statusPayment.value + 2,
                                              //     statusOrder:
                                              //         layananHomeC.statusOrderChat.value + 1);
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['id'],
                                                  status: 4);
                                              Get.to(VoiceScreen(
                                                  orderId: layananHomeC.dataListOrder[index]
                                                      ['order']['id'],
                                                  userid: layananHomeC
                                                      .dataListOrder[index]['order']
                                                          ['doctor']['userId']
                                                      .toString(),
                                                  userName: layananHomeC.dataListOrder[index]
                                                          ['order']['doctor']
                                                      ['name'],
                                                  callId: layananHomeC
                                                      .dataListOrder[index]
                                                          ['order']['id']
                                                      .toString()));
                                            } else if (dataService ==
                                                    "Home Visit Doctor" ||
                                                dataService == "Nursing Home" ||
                                                dataService == "Mother Care" ||
                                                dataService == "Baby Care" &&
                                                    dataLayanan == 2 ||
                                                dataLayanan == 3) {
                                              Get.back();
                                              layananHomeC.addOrder();
                                              layananHomeC.updateStatus(
                                                  orderId: layananHomeC
                                                          .dataListOrder[index]
                                                      ['order']['id'],
                                                  status: 4);
                                              // controller.startTimer();
                                            }
                                            controller.loading.value = false;
                                          }
                                        }
                                      }),
                    ],
                  ))
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
      //                 dataService == "Home Visit Doctor" ||
      //             layananHomeC.statusOrderDetail.value == 2 &&
      //                 dataService == "Home Visit Doctor" ||
      //             layananHomeC.statusOrderDetail.value == 4 &&
      //                 dataService == "Home Visit Doctor"
      //         ? 220
      //         : 210,
      // data: dataLayanan == 0,
      // pasienTitle: dataLayanan == 99 ? 'Pasien melewatkan jadwal ordernya' : "",
      // pasienSubtitle: dataLayanan == 99
      //     ? 'Tunggu pasien untuk mengatur jadwal order selanjutnya'
      //     : "",
      // terlewatkan: dataLayanan == 99 ? 'Terlewatkan' : "",
      // statusVerifikasi: dataLayanan == 0
      //     ? layananHomeC.dataListOrder[index]['order']['statusPayment'] == 0
      //         ? "Pasien belum melakukan pembayaran"
      //         : 'Ter-verifikasi sudah bayar'
      //     : layananHomeC.dataListOrder[index]['order']['statusPayment'] == 1
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
      jamMulai: layananHomeC.dataListOrder[index]['order']['startDateDoctor'],
      jamSelesai: layananHomeC.dataListOrder[index]['order']['endDateDoctor'],

      // layanan: layananHomeC.dataListOrder[index]['order']['service_price']['name'].toString()
    );
  }

  DetailView navigationDetailOrderNurse(
      dataLayanan, dataService, int index, BuildContext context, layanan) {
    return DetailView(
      dataDetail: layananHomeC.dataListOrder[index]['order'],
      iconPembayaran: Obx(
        () => layananHomeC.statusOrderDetail.value == 0
            ? const Icon(Icons.cancel)
            : Icon(
                Icons.check_circle,
                color: greenColor,
              ),
      ),
      statusPembayaran: Obx(() => layananHomeC.statusOrderDetail.value == 0
          ? Txt(text: 'Belum melakukan pembayaran', size: 11, weight: medium)
          : Txt(text: "Ter-verifikasi sudah bayar", size: 11, weight: medium)),
      statusOrderImage: Obx(
        () => layananHomeC.statusOrderDetail.value == 0
            ? StatusImage(
                onTap: () {},
                imageUrl: '0',
                title: 'Pasien belum bayar',
                subtitle:
                    "Pasien belum melakukan pembayaran untuk \nlayanan yang dipilih")
            : layananHomeC.statusOrderDetail.value == 2 ||
                    layananHomeC.statusOrderDetail.value == 3 ||
                    layananHomeC.statusOrderDetail.value == 4 ||
                    layananHomeC.statusOrderDetail.value == 1
                ? StatusImage(
                    onTap: () {},
                    imageUrl: '34',
                    title: 'Konsultasi berlangsung',
                    subtitle: "Tekan lihat konsultasi / lanjutkan")
                : layananHomeC.statusOrderDetail.value == 6 ||
                        layananHomeC.statusOrderDetail.value == 5
                    ? StatusImage(
                        onTap: () {},
                        imageUrl: '56',
                        title: 'Konsultasi Selesai',
                        subtitle: "Sesi konsultasi telah selesai")
                    : dataService == "Telemedicine" &&
                                layananHomeC.statusOrderDetail.value == 99 ||
                            dataService == "Dokter on Call" &&
                                layananHomeC.statusOrderDetail.value == 99
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
        () => layananHomeC.statusOrderDetail.value == 0
            ? InfoOrder(onTap: () {}, status: '0')
            : layananHomeC.statusOrderDetail.value == 2
                ? InfoOrder(onTap: () {}, status: '2N')
                : layananHomeC.statusOrderDetail.value == 1
                    ? InfoOrder(onTap: () {}, status: '2N')
                    : layananHomeC.statusOrderDetail.value == 3
                        ? InfoOrder(onTap: () {}, status: '3N')
                        : layananHomeC.statusOrderDetail.value == 4
                            ? InfoOrder(onTap: () {}, status: '4N')
                            : layananHomeC.statusOrderDetail.value == 6
                                ? InfoOrder(onTap: () {}, status: '5N')
                                : layananHomeC.statusOrderDetail.value == 5
                                    ? InfoOrder(onTap: () {}, status: '6N')
                                : layananHomeC.statusOrderDetail.value == 98
                                    ? InfoOrder(onTap: () {}, status: '98N')
                                    : layananHomeC.statusOrderDetail.value == 99
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
      // discount: layananHomeC.dataListOrder[index]['order']['discount'],
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
        () => layananHomeC.statusOrderDetail.value == 5
            ? Rating(
                rating: double.parse(layananHomeC.dataListOrder[index]['order']
                        ['rating']
                    .toString()),
              )
            : const SizedBox(),
      ),
      buttonGradient: Obx(
        () => layananHomeC.statusOrderDetail.value == 3 ||
                dataService == "Telemedicine" &&
                    layananHomeC.statusOrderDetail.value == 4 ||
                layananHomeC.statusOrderDetail.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 5 &&
                    layananHomeC.statusOrderDetail.value == 6 &&
                    Get.find<DetailController>().imageRecipe.value == "" &&
                    myC.statusOrderDetail.value != 7 ||
                dataService == "Home Visit Doctor" ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" &&
                    layananHomeC.statusOrderDetail.value == 2 ||
                layananHomeC.statusOrderDetail.value == 4 &&
                    dataService == "Home Visit Doctor" ||
                dataService == "Nursing Home" ||
                dataService == "Mother Care" ||
                dataService == "Baby Care" // 'Dokter on Call'
            ? Obx(() => controller.loading.value == true
                ? loadingIndicator()
                : layananHomeC.statusOrderDetail.value == 0 ||
                        layananHomeC.statusOrderDetail.value == 5
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : layananHomeC.statusOrderDetail.value == 1 ||
                            layananHomeC.statusOrderDetail.value == 6
                        ? const SizedBox(
                            height: 1.0,
                          )
                        : ButtomGradient(
                            margin: 25,
                            label: layananHomeC.statusOrderDetail.value == 4
                                ? 'Pesanan selesai'
                                : layananHomeC.statusOrderDetail.value == 5 ||
                                        layananHomeC.statusOrderDetail.value ==
                                            6
                                    ? 'Kirim Resep'
                                    : layananHomeC.statusOrderDetail.value == 4
                                        ? "Selesai"
                                        : layananHomeC
                                                    .statusOrderDetail.value ==
                                                6
                                            ? "Beri Resep Dokter"
                                            : layananHomeC.statusOrderDetail
                                                        .value ==
                                                    6
                                                ? "Beri Resep Dokter"
                                                : "Berangkat & Mulai Sekarang",
                            // layanan == 'Layanan Chat' && dataLayanan == 3
                            //     ? 'Mulai Chat Sekarang'
                            //     : layanan == 'Layanan Video Call' && dataLayanan == 3
                            //         ? 'Mulai Video Call Sekarang'
                            //         : 'Mulai Sekarang',
                            onTap: () async {
                              if (controller.loading.value == false) {
                                if (layananHomeC.statusOrderDetail.value == 4) {
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
      //                 dataService == "Home Visit Doctor" ||
      //             layananHomeC.statusOrderDetail.value == 2 &&
      //                 dataService == "Home Visit Doctor" ||
      //             layananHomeC.statusOrderDetail.value == 4 &&
      //                 dataService == "Home Visit Doctor"
      //         ? 220
      //         : 210,
      // data: dataLayanan == 0,
      // pasienTitle: dataLayanan == 99 ? 'Pasien melewatkan jadwal ordernya' : "",
      // pasienSubtitle: dataLayanan == 99
      //     ? 'Tunggu pasien untuk mengatur jadwal order selanjutnya'
      //     : "",
      // terlewatkan: dataLayanan == 99 ? 'Terlewatkan' : "",
      // statusVerifikasi: dataLayanan == 0
      //     ? layananHomeC.dataListOrder[index]['order']['status'] == 0
      //         ? "Pasien belum melakukan pembayaran"
      //         : 'Ter-verifikasi sudah bayar'
      //     : layananHomeC.dataListOrder[index]['order']['status'] == 1
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
      jamMulai: layananHomeC.dataListOrder[index]['order']['startDateNurse'],
      jamSelesai: layananHomeC.dataListOrder[index]['order']['endDateNurse'],

      // layanan: layananHomeC.dataListOrder[index]['order']['service_price']['name'].toString()
    );
  }
}

List<Widget> items = [
  CarouselBanner(
    imageUrl: '1',
  ),
  CarouselBanner(
    imageUrl: '2',
  ),
  CarouselBanner(
    imageUrl: '3',
  ),
  CarouselBanner(
    imageUrl: '4',
  ),
  CarouselBanner(
    imageUrl: '5',
  ),
  CarouselBanner(
    imageUrl: '7',
  ),
  CarouselBanner(
    imageUrl: '8',
  ),
  CarouselBanner(
    imageUrl: '9',
  ),
  // Image.asset('assets/Group 804.png'),
  // Image.asset('assets/Group 804.png'),
  // Image.asset('assets/Group 804.png'),
];

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
