// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/detail/views/detail_view.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/paket_layanan_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_paket_layanan_controller.dart';

class ProfilePaketLayananView extends GetView<ProfilePaketLayananController> {
  const ProfilePaketLayananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Paket ${Get.find<PaketLayananController>().nameService}',
            style: TextStyle(color: blackColor),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () =>
                    // controller.dataDetailService.isEmpty
                    //     ? InkWell(
                    //         onTap: () {
                    //           controller.buatPaket.value = true;
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(
                    //               horizontal: 24, vertical: 36),
                    //           width: Get.width,
                    //           height: 55,
                    //           decoration: DottedDecoration(
                    //               shape: Shape.box,
                    //               borderRadius: BorderRadius.circular(6),
                    //               color: const Color(0xffCCCCCC)),
                    //           alignment: Alignment.center,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: blueColor,
                    //               ),
                    //               const SizedBox(
                    //                 width: 10.0,
                    //               ),
                    //               Text(
                    //                 'Buat paket chat',
                    //                 style: greyTextStyle,
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     :
                    Column(
                  children: [
                    Get.find<PaketLayananController>().serviceName ==
                                'Home Visit Doctor' ||
                            Get.find<PaketLayananController>().serviceName ==
                                'Nursing Home'
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 20),
                            height: 150,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    height: 48,
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: Get.width / 1.33,
                                          child: TextField(
                                            controller: controller.hargaHome,
                                            onChanged: (value) {
                                              controller.hargaCurrens.value =
                                                  int.parse(controller
                                                          .hargaHome.text
                                                          .replaceAll(".", ""))
                                                      .toString();
                                              // String _formatNumber(String s) =>
                                              //     NumberFormat.decimalPattern('en')
                                              //         .format(int.parse(s));
                                              // value =
                                              //     '${_formatNumber(value.replaceAll('.',''))}';
                                              // controller.hargaHome.value = TextEditingValue(
                                              //   text: value,
                                              //   selection: TextSelection.collapsed(
                                              //       offset: value.length),
                                              // );
                                              controller.totalHargaHome.value =
                                                  double.parse(controller
                                                      .hargaCurrens.value);
                                            },
                                            style: blackTextStyle.copyWith(
                                                fontWeight: bold),
                                            keyboardType: const TextInputType
                                                    .numberWithOptions(
                                                decimal: true),
                                            // inputFormatters: [
                                            //   CurrencyInputFormatter(),
                                            // ],
                                            inputFormatters: [
                                              CurrencyTextInputFormatter(
                                                locale: 'id',
                                                decimalDigits: 0,
                                                symbol: '',
                                              ),
                                            ],
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 5),
                                              border:
                                                  const OutlineInputBorder(),
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0, left: 10),
                                                child: Text(
                                                  'Rp.',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          color: greenColor,
                                                          fontWeight: bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.hargaHome.clear();
                                            controller.diskonHome.clear();
                                            controller.totalHargaHome.value = 0;
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    )),
                                //HOME VISIT
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        width: Get.width / 1.7,
                                        height: 55,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: Colors.grey[400]!,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.white),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              width: Get.width / 2,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    controller.diskonHome,
                                                onChanged: (value) {
                                                  var harga = double.parse(
                                                      controller
                                                          .hargaCurrens.value);
                                                  var diskonHome = double.parse(
                                                      controller.diskonHome
                                                          .value.text);
                                                  var persenDisko =
                                                      diskonHome / 100;
                                                  controller.totalHargaHome
                                                          .value =
                                                      harga -
                                                          (harga * persenDisko);
                                                },
                                                style: blackTextStyle.copyWith(
                                                    fontWeight: bold),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 5),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.percent,
                                              color: yellowColor,
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Actual Prices',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 11),
                                        ),
                                        Obx(() => SizedBox(
                                              width: Get.width / 4.5,
                                              child: Text(
                                                NumberFormat.currency(
                                                  locale: 'id_IDR',
                                                  symbol: 'Rp. ',
                                                  decimalDigits: 0,
                                                )
                                                    .format(controller
                                                        .totalHargaHome.value)
                                                    .toString(),
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 20),
                            height: 150,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        height: 48,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: controller.minute,
                                          style: blackTextStyle.copyWith(
                                              fontWeight: bold),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 5),
                                              border:
                                                  const OutlineInputBorder(),
                                              prefixIcon: Icon(
                                                Icons.access_time_filled,
                                                color: blueColor,
                                              )),
                                        )),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Menit',
                                      style: blackTextStyle,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      ':',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                        height: 48,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: controller.harga,
                                          onChanged: (value) {
                                            controller.hargaCurrens.value =
                                                int.parse(controller.harga.text
                                                        .replaceAll(".", ""))
                                                    .toString();
                                            // String _formatNumber(String s) =>
                                            //     NumberFormat.decimalPattern('en')
                                            //         .format(int.parse(s));
                                            // value =
                                            //     '${_formatNumber(value.replaceAll('.',''))}';
                                            // controller.harga.value = TextEditingValue(
                                            //   text: value,
                                            //   selection: TextSelection.collapsed(
                                            //       offset: value.length),
                                            // );
                                            // controller.totalHarga.value =
                                            //     double.parse(
                                            //         controller.harga.value.text);
                                          },
                                          style: blackTextStyle.copyWith(
                                              fontWeight: bold),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            // FilteringTextInputFormatter.allow(
                                            //     RegExp(r'^\d+\.?\d{0,1}')),
                                            CurrencyTextInputFormatter(
                                              locale: 'id',
                                              decimalDigits: 0,
                                              symbol: '',
                                            ),
                                          ],
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 5),
                                            border: const OutlineInputBorder(),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, left: 10),
                                              child: Text(
                                                'Rp.',
                                                style: blackTextStyle.copyWith(
                                                    color: greenColor,
                                                    fontWeight: bold),
                                              ),
                                            ),
                                          ),
                                        )),
                                    // Icon(
                                    //   Icons.delete_outline,
                                    //   color: Colors.red,
                                    // )
                                  ],
                                ),
                                Obx(
                                  () => controller.buatDiskon.isFalse
                                      ? InkWell(
                                          onTap: () {
                                            controller.buatDiskon.value = true;
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            width: Get.width,
                                            height: 55,
                                            decoration: DottedDecoration(
                                                shape: Shape.box,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: const Color(0xffCCCCCC)),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: yellowColor,
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  'Buat Diskon?',
                                                  style: greyTextStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 15),
                                                width: Get.width / 1.7,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.grey[400]!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      width: Get.width / 2,
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            controller.diskon,
                                                        onChanged: (value) {
                                                          var harga = double
                                                              .parse(controller
                                                                  .hargaCurrens
                                                                  .value);
                                                          var diskon =
                                                              double.parse(
                                                                  controller
                                                                      .diskon
                                                                      .value
                                                                      .text);
                                                          var persenDisko =
                                                              diskon / 100;
                                                          controller.totalHarga
                                                                  .value =
                                                              harga -
                                                                  (harga *
                                                                      persenDisko);
                                                        },
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    bold),
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          border:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.percent,
                                                      color: yellowColor,
                                                    )
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual price',
                                                  style: blackTextStyle
                                                      .copyWith(fontSize: 11),
                                                ),
                                                Obx(() => Text(
                                                      NumberFormat.currency(
                                                        locale: 'id_IDR',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 0,
                                                      )
                                                          .format(controller
                                                              .totalHarga.value)
                                                          .toString(),
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 15),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                )
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Get.find<PaketLayananController>().serviceName ==
                                'Home Visit Doctor' ||
                            Get.find<PaketLayananController>().serviceName ==
                                'Nursing Home'
                        ? const SizedBox(
                            height: 1.0,
                          )
                        : InkWell(
                            onTap: () {
                              if (Get.find<PaketLayananController>()
                                          .serviceName ==
                                      'Home Visit Doctor' ||
                                  Get.find<PaketLayananController>()
                                          .serviceName ==
                                      'Nursing Home') {
                                if (controller.harga.value.text.isEmpty) {
                                  showPopUp(
                                      imageAction: 'assets/json/eror.json',
                                      description: "Data belum lengkap",
                                      onTap: () {
                                        Get.back();
                                      });
                                } else {
                                  controller.listPaketLayanan.add({
                                    "discount":
                                        controller.diskon.value.text.isEmpty
                                            ? controller.diskon.value.text
                                            : int.parse(
                                                controller.diskon.value.text),
                                    "price": int.parse(
                                        controller.hargaCurrens.value),
                                    "minute": 1,
                                  });
                                  controller.minute.clear();
                                  controller.diskon.clear();
                                  controller.harga.clear();
                                  controller.totalHarga.value = 0;
                                  controller.buatDiskon.value = false;
                                }
                              } else if (controller.minute.value.text.isEmpty ||
                                  controller.harga.value.text.isEmpty) {
                                showPopUp(
                                    imageAction: 'assets/json/eror.json',
                                    description: "Data belum lengkap",
                                    onTap: () {
                                      Get.back();
                                    });
                              } else {
                                controller.listPaketLayanan.add({
                                  "discount": controller
                                          .diskon.value.text.isEmpty
                                      ? 0.toString()
                                      : int.parse(controller.diskon.value.text),
                                  "price":
                                      // int.parse(controller.harga.value.text),
                                      int.parse(controller.hargaCurrens.value),
                                  "minute": controller.minute.value.text,
                                });
                                controller.minute.clear();
                                controller.diskon.clear();
                                controller.harga.clear();
                                controller.totalHarga.value = 0;
                                controller.buatDiskon.value = false;
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              height: 40,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  gradient: gradient1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: whiteColor,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Tambah Paket',
                                    style:
                                        whiteTextStyle.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    controller.dataDetailService.isEmpty
                        // ignore: prefer_const_constructors
                        ? Padding(
                            padding: const EdgeInsets.only(top: 180.0),
                            child: Get.find<PaketLayananController>()
                                            .serviceName ==
                                        "Home Visit Doctor" ||
                                    Get.find<PaketLayananController>()
                                            .serviceName ==
                                        'Nursing Home'
                                ? const SizedBox(
                                    height: 1.0,
                                  )
                                // ignore: prefer_const_constructors
                                : Center(
                                    child: const Text('Tidak Ada Data Paket')),
                          )
                        : SizedBox(
                            height: Get.height / 2,
                            child: ListView.builder(
                              itemCount: controller.listPaketLayanan.length,
                              itemBuilder: (context, index) => Get.find<
                                                  PaketLayananController>()
                                              .serviceName ==
                                          "Home Visit Doctor" ||
                                      Get.find<PaketLayananController>()
                                              .serviceName ==
                                          'Nursing Home'
                                  ? const Text('')
                                  :

                                  //   Get.find<PaketLayananController>().serviceName ==
                                  // 'Dokter on Call' ?
                                  Column(
                                      children: [
                                        // initiallyExpanded: true,
                                        // // backgroundColor: Colors.grey[200],
                                        // title:
                                        Container(
                                          // padding: const EdgeInsets.symmetric(
                                          //     horizontal: 10, vertical: 12),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          // height:
                                          //     // controller.listPaket[index]['diskon'] == "" ? 75 : 150,
                                          //     75,
                                          width: Get.width,
                                          decoration: const BoxDecoration(
                                            // color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        height: 48,
                                                        width: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]!,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                                color: Colors
                                                                    .white),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_time_filled_outlined,
                                                              color: blueColor,
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Text(
                                                              '${controller.listPaketLayanan[index]['minute']}',
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        'Menit',
                                                        style: blackTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        ':',
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    height: 48,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1.0,
                                                          color:
                                                              Colors.grey[500]!,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10.0),
                                                        ),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          CurrencyFormat
                                                              .convertToIdr(
                                                                  controller.listPaketLayanan[
                                                                          index]
                                                                      ['price'],
                                                                  0),
                                                          style: blackTextStyle
                                                              .copyWith(
                                                            fontWeight: bold,
                                                            color: const Color(
                                                                0xff555555),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30))),
                                                        context: context,
                                                        builder: (context) {
                                                          return SizedBox(
                                                            height: 270,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          18,
                                                                      top: 14),
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
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                Text(
                                                                  'Apakah Anda yakin\nMenghapus Paket?',
                                                                  style: blackTextStyle
                                                                      .copyWith(
                                                                          fontWeight:
                                                                              medium),
                                                                ),
                                                                const SizedBox(
                                                                  height: 36.0,
                                                                ),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: 312,
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), backgroundColor: Colors.red),
                                                                      onPressed: () async {
                                                                        controller
                                                                            .listPaketLayanan
                                                                            .removeAt(index);
                                                                        Get.back();
                                                                      },
                                                                      child: const Text("Hapus Paket")),
                                                                ),
                                                                const SizedBox(
                                                                  height: 16.0,
                                                                ),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: 312,
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), backgroundColor: buttonColor),
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
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Obx(
                                                () =>
                                                    controller.listPaketLayanan[
                                                                    index]
                                                                ['discount'] ==
                                                            ""
                                                        ? const SizedBox(
                                                            height: 1.0,
                                                          )
                                                        : const SizedBox(
                                                            height: 1.0,
                                                          ),
                                                //       Row(
                                                //           crossAxisAlignment:
                                                //               CrossAxisAlignment.center,
                                                //           children: [
                                                //             Container(
                                                //                 margin:
                                                //                     EdgeInsets.only(top: 15),
                                                //                 width: Get.width / 1.7,
                                                //                 height: 55,
                                                //                 decoration: BoxDecoration(
                                                //                     border: Border.all(
                                                //                       width: 1.0,
                                                //                       color: Colors.grey[400]!,
                                                //                     ),
                                                //                     borderRadius:
                                                //                         BorderRadius.circular(
                                                //                             6),
                                                //                     color: Colors.white),
                                                //                 alignment: Alignment.center,
                                                //                 child: Row(
                                                //                   children: [
                                                //                     Container(
                                                //                       padding: EdgeInsets.only(
                                                //                           left: 10),
                                                //                       width: Get.width / 2,
                                                //                       child: Text('')
                                                //                     ),
                                                //                     Icon(
                                                //                       Icons.percent,
                                                //                       color: yellowColor,
                                                //                     )
                                                //                   ],
                                                //                 )),
                                                //             const SizedBox(
                                                //               width: 4.0,
                                                //             ),
                                                //             Column(
                                                //               mainAxisAlignment:
                                                //                   MainAxisAlignment.center,
                                                //               crossAxisAlignment:
                                                //                   CrossAxisAlignment.start,
                                                //               children: [
                                                //                 Text(
                                                //                   'Actual price',
                                                //                   style: blackTextStyle
                                                //                       .copyWith(fontSize: 11),
                                                //                 ),
                                                //                 Obx(() => Text(
                                                //              NumberFormat.currency(locale: 'id_IDR', symbol: 'Rp', decimalDigits: 0).format(controller.listPaket[index]['harga']).toString(),
                                                // style: blackTextStyle.copyWith(
                                                //     fontWeight: bold,
                                                //     color: const Color(0xff555555),
                                                //     ),

                                                //     ),)
                                                //               ],
                                                //             )
                                                //           ],
                                                //         ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // childrenPadding:
                                        //     EdgeInsets.only(left: 20, bottom: 20),
                                        // children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, top: 15),
                                                width: Get.width / 1.7,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.grey[400]!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        width: Get.width / 2,
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Diskon : '),
                                                            Text(
                                                              '${controller.dataDetailService[index]['discount']}',
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          bold,
                                                                      fontSize:
                                                                          20),
                                                            ),
                                                          ],
                                                        )),
                                                    Icon(
                                                      Icons.percent,
                                                      color: yellowColor,
                                                    )
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual price',
                                                  style: blackTextStyle
                                                      .copyWith(fontSize: 11),
                                                ),
                                                Obx(() => Text(
                                                      CurrencyFormat.convertToIdr(
                                                          controller.listPaketLayanan[index][
                                                                      'discount'] ==
                                                                  "0"
                                                              ? controller
                                                                      .listPaketLayanan[index]
                                                                  ['price']
                                                              : controller.listPaketLayanan[
                                                                          index][
                                                                      'price'] -
                                                                  (controller.listPaketLayanan[index]
                                                                          [
                                                                          'price'] *
                                                                      controller.listPaketLayanan[index]
                                                                          ['discount'] /
                                                                      100),
                                                          0),
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 15),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                            ))
                  ],
                ),
              )

              //
            ],
          ),
        ),
        bottomSheet:
            //  Obx(
            //   () => controller.listPaketLayanan.isEmpty
            //       ? const SizedBox(
            //           height: 1.0,
            //         )
            //       :
            Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtomGradient(
            label: 'Simpan',
            onTap: () {
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
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Anda yakin ingin Menyimpan ini?',
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: gradient1),
                            height: 45,
                            width: 312,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () async {
                                
                                if (controller.isLoading.isFalse) {
                                  if (Get.find<PaketLayananController>()
                                              .serviceName ==
                                          "Home Visit Doctor" ||
                                      Get.find<PaketLayananController>()
                                              .serviceName ==
                                          'Nursing Home') {
                                            controller.hargaCurrens.value = int.parse(
                                        controller.hargaHome.text
                                            .replaceAll(".", ""))
                                    .toString();
                                    await controller
                                        .postEditLayanan(listPaketLayanan: [
                                      {
                                        "discount":
                                            controller.diskonHome.value.text,
                                        "price": controller.hargaCurrens.value,
                                        "minute": 0
                                      }
                                    ]);
                                  } else {
                                    await controller.postEditLayanan(
                                        listPaketLayanan:
                                            controller.listPaketLayanan);
                                    // controller.listPaket.clear();
                                    log('hahahah');
                                  }
                                }
                              },
                              child: Obx(() => Text(controller.isLoading.isFalse
                                  ? "Simpan"
                                  : "Loading..")),
                            )),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: 45,
                          width: 312,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
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
            },
          ),
          // ),
        ));
  }
}
