import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import '../../../doctor_app/jadwal_saya/views/list_jadwal.dart';
import '../controllers/paket_layanan_nurse_controller.dart';

class PaketLayananNurseView extends GetView<PaketLayananNurseController> {
  PaketLayananNurseView({Key? key}) : super(key: key);
  final loginC = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    controller.getNursePket();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Txt(
          text: 'Kembali',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => controller.isloading.isTrue
            ? loadingIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Cntr(
                            alignment: Alignment.center,
                            radius: BorderRadius.circular(100),
                            height: 72,
                            width: 72,
                            border: Border.all(color: Colors.blue, width: 3),
                            child: Image.asset('assets/icon/layanan.png')),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Txt(
                        text: 'Paket Layanan',
                        size: 16,
                        weight: bold,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      controller.nursepaketData.isNotEmpty
                          ? const SizedBox(
                              height: 1.0,
                            )
                          : Column(
                              children: [
                                Txt(
                                  text: 'Tambahkan paket layanan Anda',
                                  size: 11,
                                  weight: medium,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Image.asset('assets/icon/stepper3.png'),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            log(controller.serviceIdNurse.toString());
                          },
                          child: Txt(
                            text: controller.nursepaketData.isNotEmpty
                                ? "Edit Paket"
                                : 'Buat Paket',
                            weight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Obx(
                        () => 
                        Visibility(
                          visible: controller.nursepaketData.isNotEmpty,
                          child: Cntr(
                            // margin: const EdgeInsets.only(bottom: 10),
                            height: 270,
                            width: Get.width,
                            radius: BorderRadius.circular(10),
                            // padding: EdgeInsets.symmetric(vertical :10),
                            child: ListView.builder(
                              itemCount: controller.nursepaketData.length,
                              itemBuilder: (context, index) => Cntr(
                                margin: const EdgeInsets.only(bottom: 10),
                                radius: BorderRadius.circular(10),
                                width: Get.width,
                                gradient: gradient1,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Txt(
                                              text: controller
                                                      .nursepaketData[index]
                                                  ['name'],
                                              weight: bold,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Txt(
                                              text: controller
                                                          .nursepaketData[index]
                                                      ['description'] ??
                                                  'null',
                                              weight: light,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .idPaket.value = controller
                                                        .nursepaketData[index]
                                                    ['id'];
                                                Get.defaultDialog(
                                                  title: "Apakah Anda yakin?",
                                                  middleText:
                                                      'Menghapus Paket Layanan ini',
                                                  confirm: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red),
                                                      onPressed: () async {
                                                        await controller
                                                            .deleteNursePket();
                                                        controller
                                                            .getNursePket();
                                                        Get.back();
                                                      },
                                                      child: Txt(
                                                        text: 'Hapus',
                                                        color: Colors.white,
                                                      )),
                                                  cancel: ElevatedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Txt(
                                                        text: 'Kembali',
                                                        color: Colors.white,
                                                      )),
                                                );
                                              },
                                              child: const Icon(
                                                Icons.delete_forever_outlined,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            // INIEDIT
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .idPaket.value = controller
                                                        .nursepaketData[index]
                                                    ['id'];
                                                controller.namaPaketC
                                                    .text = controller
                                                        .nursepaketData[index]
                                                    ['name'];
                                                controller.deskripsiPaketC
                                                    .text = controller
                                                        .nursepaketData[index]
                                                    ['description'];
                                                controller.hargaPaketC.text =
                                                    controller
                                                        .nursepaketData[index]
                                                            ['price']
                                                        .toString();
                                                controller.diskonPaket.text =
                                                    controller
                                                        .nursepaketData[index]
                                                            ['discount']
                                                        .toString();
                                                        controller.hargaCurrens.value = controller
                                                        .nursepaketData[index]
                                                            ['price']
                                                        .toString();
                                                if (controller.nursepaketData[
                                                        index]['discount'] !=
                                                    0) {
                                                  controller.tambahDiskon
                                                      .value = true;
                                                }
                                                Get.bottomSheet(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30))),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                      height: 500,
                                                      width: Get.width,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Cntr(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                                height: 10,
                                                                width: 200,
                                                                color: Colors
                                                                    .grey[300],
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Txt(
                                                              text:
                                                                  'Buat Paket Layanan Anda',
                                                              weight: bold,
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            InputPrimary(
                                                                hintText:
                                                                    "Masukan nama paket",
                                                                onChange: (p0) {
                                                                  controller
                                                                          .namaPaket
                                                                          .value =
                                                                      controller
                                                                          .namaPaketC
                                                                          .text;
                                                                },
                                                                controller:
                                                                    controller
                                                                        .namaPaketC,
                                                                onTap: () {}),
                                                            InputPrimary(
                                                                hintText:
                                                                    "Deskripsi",
                                                                onChange: (p0) {
                                                                  controller
                                                                          .deskripsiPaket
                                                                          .value =
                                                                      controller
                                                                          .deskripsiPaketC
                                                                          .text;
                                                                },
                                                                controller:
                                                                    controller
                                                                        .deskripsiPaketC,
                                                                onTap: () {}),
                                                            InputPrimary(
                                                               inputFormatters: [
                                            // FilteringTextInputFormatter.allow(
                                            //     RegExp(r'^\d+\.?\d{0,1}')),
                                            CurrencyTextInputFormatter(
                                              locale: 'id',
                                              decimalDigits: 0,
                                              symbol: '',
                                            ),
                                          ],
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                hintText:
                                                                    "Harga Paket",
                                                                onChange: (p0) {
                                                                   controller.hargaCurrens.value =
                                                int.parse(controller
                                                        .hargaPaketC.text
                                                        .replaceAll(".", ""))
                                                    .toString();
                                                                  controller
                                                                          .totalHargaPaket
                                                                          .value =
                                                                      double.parse(controller.hargaCurrens.value);
                                                                },
                                                                controller:
                                                                    controller
                                                                        .hargaPaketC,
                                                                onTap: () {}),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (controller
                                                                    .nurseScopeData
                                                                    .isEmpty) {
                                                                  await controller
                                                                      .getNurseWorkScope();
                                                                }
                                                                for (var i = 0;
                                                                    i <
                                                                        controller
                                                                            .nursepaketData
                                                                            .length;
                                                                    i++) {
                                                                  // var item = items[i];
                                                                  controller
                                                                      .packageNurseSops
                                                                      .value = controller
                                                                          .nursepaketData[i]
                                                                      [
                                                                      'package_nurse_sops'];
                                                                }

                                                                // a
                                                                Get.to(() =>
                                                                    const TambahScopeOfWork());
                                                              },
                                                              child: Cntr(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                height: 45,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width:
                                                                    Get.width,
                                                                color: AppColor
                                                                    .bgForm,
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]!),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Obx(
                                                                      () => controller.tampunganNurseId.isNotEmpty ||
                                                                              controller.nursepaketData[index]['package_nurse_sops'] !=
                                                                                  []
                                                                          ? Txt(
                                                                              text: controller.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${controller.tampunganNurseId.length} Dipilih')
                                                                          : Txt(
                                                                              text: 'Scope of Work',
                                                                              color: AppColor.bodyColor.shade500,
                                                                            ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: AppColor
                                                                          .bodyColor
                                                                          .shade500,
                                                                      size: 15,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Obx(
                                                              () => controller
                                                                      .tambahDiskon
                                                                      .isTrue
                                                                  ? Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 10),
                                                                            width: Get.width / 1.7,
                                                                            height: 45,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  width: 1.0,
                                                                                  color: Colors.grey[400]!,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(6),
                                                                                color: Colors.white),
                                                                            alignment: Alignment.center,
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(left: 10),
                                                                                  width: Get.width / 2,
                                                                                  child: TextFormField(
                                                                                  
                                                                                    keyboardType: TextInputType.number,
                                                                                    controller: controller.diskonPaket,
                                                                                    onChanged: (value) {
                                                                                      var harga = double.parse(controller.hargaCurrens.value);
                                                                                      var diskonHome = double.parse(controller.diskonPaket.value.text);
                                                                                      var persenDisko = diskonHome / 100;
                                                                                      controller.totalHargaPaket.value = harga - (harga * persenDisko);
                                                                                    },
                                                                                    style: blackTextStyle.copyWith(fontWeight: bold),
                                                                                    decoration: const InputDecoration(
                                                                                      fillColor: AppColor.bgForm,
                                                                                      filled: true,
                                                                                      contentPadding: EdgeInsets.only(bottom: 5),
                                                                                      border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Icon(
                                                                                  Icons.percent,
                                                                                  color: yellowColor,
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        const SizedBox(
                                                                          width:
                                                                              10.0,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 10.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.tambahDiskon.value = false;
                                                                              controller.diskonPaket.text = "";
                                                                              controller.totalHargaPaket.value = double.parse(controller.hargaPaketC.text);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.disabled_by_default_outlined,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 6.0,
                                                                                ),
                                                                                Txt(text: 'Hapus', color: Colors.red)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .tambahDiskon
                                                                            .value = true;
                                                                        // Get.to(() => TambahScopeOfWork());
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        decoration: DottedDecoration(
                                                                            shape:
                                                                                Shape.box,
                                                                            borderRadius: BorderRadius.circular(6),
                                                                            color: const Color(0xffCCCCCC)),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Row(
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
                                                                              'Tambah Diskon',
                                                                              style: greyTextStyle,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Obx(() => Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Actual Prices',
                                                                      style: blackTextStyle.copyWith(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    SizedBox(
                                                                        width: Get.width /
                                                                            4.5,
                                                                        child:
                                                                            Txt(
                                                                          text:
                                                                              NumberFormat.currency(
                                                                            locale:
                                                                                'id_IDR',
                                                                            symbol:
                                                                                'Rp. ',
                                                                            decimalDigits:
                                                                                0,
                                                                          ).format(controller.totalHargaPaket.value).toString(),
                                                                          color:
                                                                              Colors.green,
                                                                        )),
                                                                  ],
                                                                )),
                                                            const SizedBox(
                                                              height: 20.0,
                                                            ),
                                                            Obx(
                                                              () => controller
                                                                          .namaPaket
                                                                          .isEmpty &&
                                                                      controller
                                                                          .deskripsiPaket
                                                                          .isEmpty &&
                                                                      controller
                                                                              .totalHargaPaket
                                                                              .value ==
                                                                          0.0 &&
                                                                      controller
                                                                          .tampunganNurseId
                                                                          .isEmpty
                                                                  ? ButtonPrimary(
                                                                      marginLeft:
                                                                          0,
                                                                      marginRight:
                                                                          0,
                                                                      title:
                                                                          'Tambahkan',
                                                                      onPressed:
                                                                          () {})
                                                                  : ButtomGradient(
                                                                      margin: 0,
                                                                      label:
                                                                          'Ubah Paket',
                                                                      onTap:
                                                                          () async {
                                                                        await controller
                                                                            .editPaketLayananNurse();
                                                                        Get.back();
                                                                        controller
                                                                            .namaPaketC
                                                                            .clear();
                                                                        controller
                                                                            .deskripsiPaketC
                                                                            .clear();
                                                                        controller
                                                                            .hargaPaketC
                                                                            .clear();
                                                                        controller
                                                                            .diskonPaket
                                                                            .clear();
                                                                        controller
                                                                            .tampunganNurseId
                                                                            .value = [];
                                                                        controller
                                                                            .getNursePket();
                                                                        controller
                                                                            .namaPaket
                                                                            .value = "";
                                                                        controller
                                                                            .deskripsiPaket
                                                                            .value = "";
                                                                        controller
                                                                            .totalHargaPaket
                                                                            .value = 0.0;
                                                                        controller
                                                                            .tambahDiskon
                                                                            .value = false;
                                                                        controller
                                                                            .dataActive
                                                                            .clear();
                                                                        controller
                                                                            .tampunganNurseId
                                                                            .value = [];
                                                                        controller
                                                                            .nurseScopeData
                                                                            .value = [];

                                                                        controller
                                                                            .packageNurseSops
                                                                            .value = [];
                                                                      }),
                                                            ),
                                                            const SizedBox(
                                                              height: 30.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              },
                                              child: const Icon(
                                                Icons.edit_note_rounded,
                                                color: Color(0xFF0B9444),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Cntr(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      height: 45,
                                      alignment: Alignment.centerLeft,
                                      width: Get.width,
                                      color: AppColor.bgForm,
                                      radius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Txt(
                                            text: NumberFormat.currency(
                                              locale: 'id_IDR',
                                              symbol: 'Rp. ',
                                              decimalDigits: 0,
                                            )
                                                .format(
                                                  controller
                                                          .nursepaketData[index]
                                                      ['price'],
                                                )
                                                .toString(),
                                            color: Colors.black,
                                            weight: bold,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Cntr(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      height: 45,
                                      alignment: Alignment.centerLeft,
                                      width: Get.width,
                                      color: AppColor.bgForm,
                                      radius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Txt(
                                            text:
                                                " ${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih",
                                            color: Colors.black,
                                            weight: bold,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Cntr(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      height: 45,
                                      alignment: Alignment.centerLeft,
                                      width: Get.width,
                                      color: AppColor.bgForm,
                                      radius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Txt(
                                            text: controller
                                                .nursepaketData[index]
                                                    ['discount']
                                                .toString(),
                                            color: Colors.amber,
                                            weight: bold,
                                          ),
                                          const Icon(
                                            Icons.percent,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Txt(
                                          text: 'Actual Price',
                                          color: whiteColor,
                                          weight: bold,
                                        ),
                                        Txt(
                                          // "${}",
                                          text: NumberFormat.currency(
                                            locale: 'id_IDR',
                                            symbol: 'Rp. ',
                                            decimalDigits: 0,
                                          ).format(controller
                                                      .nursepaketData[index]
                                                  ['price'] -
                                              (controller.nursepaketData[index]
                                                          ['price'] *
                                                      controller.nursepaketData[
                                                          index]['discount']) /
                                                  100),
                                          color: whiteColor,
                                          weight: bold,
                                          size: 16,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //INIBUAT
                      InkWell(
                        onTap: () {
                          controller.tambahDiskon.value = false;
                          controller.namaPaketC.clear();
                          controller.deskripsiPaketC.clear();
                          controller.nurseScopeData.clear();
                          controller.diskonPaket.clear();
                          controller.hargaPaketC.clear();
                          Get.bottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                height: 500,
                                width: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Cntr(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 10,
                                          width: 200,
                                          color: Colors.grey[300],
                                          radius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Txt(
                                        text: 'Buat Paket Layanan Anda',
                                        weight: bold,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      InputPrimary(
                                          hintText: "Masukan nama paket",
                                          onChange: (p0) {
                                            controller.namaPaket.value =
                                                controller.namaPaketC.text;
                                          },
                                          controller: controller.namaPaketC,
                                          onTap: () {}),
                                      InputPrimary(
                                          hintText: "Deskripsi",
                                          onChange: (p0) {
                                            controller.deskripsiPaket.value =
                                                controller.deskripsiPaketC.text;
                                          },
                                          controller:
                                              controller.deskripsiPaketC,
                                          onTap: () {}),
                                      InputPrimary(
                                          inputFormatters: [
                                            // FilteringTextInputFormatter.allow(
                                            //     RegExp(r'^\d+\.?\d{0,1}')),
                                            CurrencyTextInputFormatter(
                                              locale: 'id',
                                              decimalDigits: 0,
                                              symbol: '',
                                            ),
                                          ],
                                          keyboardType: TextInputType.number,
                                          hintText: "Harga Paket",
                                          onChange: (p0) {
                                            controller.hargaCurrens.value =
                                                int.parse(controller
                                                        .hargaPaketC.text
                                                        .replaceAll(".", ""))
                                                    .toString();
                                            controller.totalHargaPaket.value =
                                                double.parse(controller.hargaCurrens.value);
                                          },
                                          controller: controller.hargaPaketC,
                                          onTap: () {}),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (controller
                                              .nurseScopeData.isEmpty) {
                                            controller.getNurseWorkScope();
                                          }
                                          Get.to(
                                              () => const TambahScopeOfWork());
                                        },
                                        child: Cntr(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 45,
                                          alignment: Alignment.centerLeft,
                                          width: Get.width,
                                          color: AppColor.bgForm,
                                          radius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Obx(
                                                () => controller
                                                        .tampunganNurseId
                                                        .isNotEmpty
                                                    ? Txt(
                                                        text:
                                                            '${controller.tampunganNurseId.length} Dipilih')
                                                    : Txt(
                                                        text: 'Scope of Work',
                                                        color: AppColor
                                                            .bodyColor.shade500,
                                                      ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color:
                                                    AppColor.bodyColor.shade500,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Obx(
                                        () => controller.tambahDiskon.isTrue
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      width: Get.width / 1.7,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey[400]!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colors.white),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            width:
                                                                Get.width / 2,
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  controller
                                                                      .diskonPaket,
                                                              onChanged:
                                                                  (value) {
                                                                var harga = double
                                                                    .parse(controller.hargaCurrens.value);
                                                                var diskonHome =
                                                                    double.parse(controller
                                                                        .diskonPaket
                                                                        .value
                                                                        .text);
                                                                var persenDisko =
                                                                    diskonHome /
                                                                        100;
                                                                controller
                                                                        .totalHargaPaket
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
                                                                fillColor:
                                                                    AppColor
                                                                        .bgForm,
                                                                filled: true,
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        bottom:
                                                                            5),
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.percent,
                                                            color: yellowColor,
                                                          ),
                                                        ],
                                                      )),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.tambahDiskon
                                                            .value = false;
                                                        controller.diskonPaket
                                                            .text = "";
                                                        controller
                                                                .totalHargaPaket
                                                                .value =
                                                            double.parse(
                                                                controller
                                                                    .hargaPaketC
                                                                    .text);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .disabled_by_default_outlined,
                                                            color: Colors.red,
                                                          ),
                                                          const SizedBox(
                                                            width: 6.0,
                                                          ),
                                                          Txt(
                                                              text: 'Hapus',
                                                              color: Colors.red)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  controller.tambahDiskon
                                                      .value = true;
                                                  // Get.to(() => TambahScopeOfWork());
                                                },
                                                child: Container(
                                                  width: Get.width,
                                                  height: 45,
                                                  decoration: DottedDecoration(
                                                      shape: Shape.box,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: const Color(
                                                          0xffCCCCCC)),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: yellowColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        'Tambah Diskon',
                                                        style: greyTextStyle,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Obx(() => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Actual Prices',
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                  width: Get.width / 4.5,
                                                  child: Txt(
                                                    text: NumberFormat.currency(
                                                      locale: 'id_IDR',
                                                      symbol: 'Rp. ',
                                                      decimalDigits: 0,
                                                    )
                                                        .format(controller
                                                            .totalHargaPaket
                                                            .value)
                                                        .toString(),
                                                    color: Colors.green,
                                                  )),
                                            ],
                                          )),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Obx(
                                        () => controller.namaPaket.isEmpty ||
                                                controller
                                                    .deskripsiPaket.isEmpty ||
                                                controller.totalHargaPaket
                                                        .value ==
                                                    0.0 ||
                                                controller
                                                    .tampunganNurseId.isEmpty
                                            ? ButtonPrimary(
                                                marginLeft: 0,
                                                marginRight: 0,
                                                title: 'Tambahkan',
                                                onPressed: () {})
                                            : ButtomGradient(
                                                margin: 0,
                                                label: 'Tambahkan',
                                                onTap: () async {
                                                  await controller
                                                      .tambahPaketLayananNurse();
                                                  Get.back();
                                                  controller.namaPaketC.clear();
                                                  controller.deskripsiPaketC
                                                      .clear();
                                                  controller.hargaPaketC
                                                      .clear();
                                                  controller.diskonPaket
                                                      .clear();
                                                  controller.tampunganNurseId
                                                      .value = [];
                                                  controller.getNursePket();
                                                  controller.namaPaket.value =
                                                      "";
                                                  controller.deskripsiPaket
                                                      .value = "";
                                                  controller.totalHargaPaket
                                                      .value = 0.0;
                                                  controller.tambahDiskon
                                                      .value = false;
                                                  controller.dataActive.clear();
                                                  controller.packageNurseSops
                                                      .value = [];
                                                }),
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 100),
                          width: Get.width,
                          height: 55,
                          decoration: DottedDecoration(
                              shape: Shape.box,
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffCCCCCC)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: blueColor,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Buat Paket Layanan',
                                style: greyTextStyle,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
      bottomSheet: Cntr(
        margin: const EdgeInsets.only(bottom: 20),
        width: Get.width,
        height: 50,
        child: ButtomGradient(
            label: loginC.isVerifikasiNurse.value == 1 &&
                    loginC.nurseEducation.isEmpty
                ? 'Lanjutkan'
                : "Simpan",
            onTap: () {
              loginC.isVerifikasiNurse.value == 1 &&
                      loginC.nurseEducation.isEmpty
                  ? Get.to(() => ListJadwal())
                  : Get.back();
            }),
      ),
    );
  }
}

class TambahScopeOfWork extends StatefulWidget {
  const TambahScopeOfWork({super.key});

  @override
  State<TambahScopeOfWork> createState() => _TambahScopeOfWorkState();
}

class _TambahScopeOfWorkState extends State<TambahScopeOfWork> {
  final controller = Get.put(PaketLayananNurseController());

  // ignore: prefer_typing_uninitialized_variables
  var dataNurseId;

  @override
  void initState() {
    checkLayana();
    super.initState();
  }

  checkLayana() {
    // ignore: avoid_print
    print('okeokeo ${controller.packageNurseSops}');
    if (controller.tampunganNurseId.isEmpty) {
      for (var i in controller.packageNurseSops) {
        // ignore: invalid_use_of_protected_member
        controller.tampunganNurseId.value
            .add({"work_scope_id": i['workScopeId']});
      }
    }
    setState(() {
      dataNurseId = controller.packageNurseSops;
    });
    // ignore: avoid_print
    print('ZZZ${controller.packageNurseSops}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Txt(text: 'Data layanan anda'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Obx(
        () => controller.nurseScopeData.isEmpty
            ? loadingIndicator()
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20, bottom: 80),
                itemCount: controller.nurseScopeData.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Txt(
                        text: controller.nurseScopeData[index]['name']
                            .toString()),
                    // trailing: Icon(Icons.cabin),
                    trailing: Obx(
                      () => controller.dataActive[index]['value'] == false
                          // ignore: unnecessary_null_comparison, unrelated_type_equality_checks
                          ? dataNurseId
                                      .where((p0) =>
                                          p0['workScopeId'] ==
                                          controller.nurseScopeData[index]
                                              ['id'])
                                      .toString() !=
                                  '()'
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      dataNurseId.removeWhere((element) =>
                                          element['workScopeId'] ==
                                          controller.nurseScopeData[index]
                                              ['id']);
                                    });
                                    controller.tampunganNurseId.removeWhere(
                                        (element) =>
                                            element['work_scope_id'] ==
                                            controller.nurseScopeData[index]
                                                ['id']);

                                    // ignore: avoid_print
                                    print('ZZZZ${controller.tampunganNurseId}');
                                  },
                                  icon: const Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.dataActive[index]['value'] =
                                          !controller.dataActive[index]
                                              ['value'];
                                    });
                                    controller.tampunganNurseId.add({
                                      "work_scope_id":
                                          controller.nurseScopeData[index]['id']
                                    });
                                    // ignore: avoid_print
                                    print(
                                        'ZZ LENGTH ${controller.tampunganNurseId}');
                                  },
                                  icon: const Icon(
                                    Icons.check_box_outline_blank,
                                  ),
                                )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  controller.dataActive[index]['value'] =
                                      !controller.dataActive[index]['value'];
                                });
                                if (controller.dataActive[index]['value'] ==
                                    false) {
                                  controller.tampunganNurseId.removeWhere(
                                      (element) =>
                                          element['work_scope_id'] ==
                                          controller.nurseScopeData[index]
                                              ['id']);
                                  // if (controller.tampunganNurseId.length == 1) {
                                  //   controller.tampunganNurseId.clear();
                                  // } else {

                                  // controller.tampunganNurseId
                                  //     .removeWhere((element) => element['work_scope_id']  == controller.tampunganNurseId[index]['work_scope_id']);
                                }
                                // }
                              },
                              icon: const Icon(
                                Icons.check_box,
                                color: Colors.blue,
                              )),
                    ),
                    leading: Cntr(
                      radius: BorderRadius.circular(10),
                      height: 50,
                      width: 50,
                      image: DecorationImage(
                          image: NetworkImage(
                              controller.nurseScopeData[index]['icon'])),
                    ),
                  ),
                ),
              ),
      ),
      bottomSheet: Cntr(
        margin: const EdgeInsets.only(bottom: 20),
        child: Obx(
          () => controller.tampunganNurseId.isEmpty
              ? ButtonPrimary(title: 'Tambahkan', onPressed: () {})
              : ButtomGradient(
                  label: 'Tambahkan',
                  onTap: () {
                    Get.back();
                  },
                ),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  // ignore: annotate_overrides
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
