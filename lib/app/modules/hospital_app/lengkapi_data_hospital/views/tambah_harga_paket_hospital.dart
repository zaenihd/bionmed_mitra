import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_jadwal_tim_hospital.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/views/paket_layanan_nurse_view.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_lengkapi_data.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/lengkapi_data_hospital_controller.dart';

class TambahHargaPaketHospital extends GetView<LengkapiDataHospitalController> {
  TambahHargaPaketHospital({Key? key}) : super(key: key);

  final paketLayananNurseController = Get.put(PaketLayananNurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderLengkapiDataHospital(
                imageUrl: 'assets/icon/icon_harga.png',
                title: 'Harga paket',
                subtitle: 'Buat paket harga layanan tim\nanda pada rumah sakit',
                stepper: 'assets/icon/stepper2.png'),
            const SizedBox(
              height: 30.0,
            ),
            Cntr(
              height: Get.height / 2.1,
              child: ListView.builder(
                itemCount: controller.listAllTimHospital.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    cardHargaPaketTimHospital(index),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ButtomGradient(
          label: 'Lanjutkan',
          onTap: () {
            Get.to(() => TambahJadwalTimHospital());
          },
        ),
      ),
    );
  }

  Cntr cardHargaPaketTimHospital(int index) {
    return Cntr(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      radius: BorderRadius.circular(10),
      width: Get.width,
      gradient: gradient1,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              Cntr(
                color: Colors.transparent,
                height: 40,
                width: 40,
                image: DecorationImage(
                    image: NetworkImage(
                        '${controller.listAllTimHospital[index]['service']['image']}'),
                    fit: BoxFit.cover),
              ),
              // Icon(
              //   Icons.people,
              //   size: 30,
              // ),
              const SizedBox(
                width: 10.0,
              ),
              Txt(
                text: '${controller.listAllTimHospital[index]['team']['name']}',
                weight: bold,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          dataPaketlistName(title: 'Rumah sakit', data: '${controller.listAllTimHospital[index]['team']['hospital']['name']}'),
          const SizedBox(
            height: 12.0,
          ),
          dataPaketlistName(
              title: 'Layanan',
              data:
                  "${controller.listAllTimHospital[index]['service']['name']}"),
          const SizedBox(
            height: 12.0,
          ),
          dataPaketlistName(
              title: 'No PIC Layanan',
              data:
                  "${controller.listAllTimHospital[index]['team']['user']['phoneNumber']}"),
          const SizedBox(
            height: 12.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          ButtonPrimary(
            title: 'Buat paket harga',
            onPressed: () {
               Get.put(PaketLayananNurseController()).isHospital.value = true;
             Get.put(PaketLayananNurseController()).idTimHospital.value = controller.listAllTimHospital[index]['team']['id'];
               Get.put(PaketLayananNurseController())
                                .serviceIdNurse
                                .value = controller.listAllTimHospital[index]['team']['nurse_services'][0]['serviceId']
                            ;
              // controller.paketTimHospital();
              Get.to(() => PaketLayananNurseView());
            },
            backgroundColor: Color(0xffFFC93F),
            marginLeft: 0,
            marginRight: 0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Obx(()=>
          Visibility(
            visible: controller.listAllTimHospital[index]['team']['service_price_nurses'].toString() != "[]",
            child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xff50FF61),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Txt(
                text: '${controller.listAllTimHospital[index]['team']['service_price_nurses'].length} Paket didaftarkan',
                color: Colors.white,
              )
            ],
          )))
         
        ],
      ),
    );
  }

  Row dataPaketlistName({required String title, required String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Txt(
          text: title,
          size: 12,
          weight: light,
          color: Colors.white,
        ),
        Txt(
          text: data,
          size: 12,
          weight: light,
          color: Colors.white,
        ),
      ],
    );
  }
}

class PaketTimLayanan extends GetView<LengkapiDataHospitalController> {
  PaketTimLayanan({super.key});
  final paketLayananNurseController = Get.put(PaketLayananNurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: ListView.builder(
        itemCount: 1,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index) => cardPaketTim(index),
      ),
      bottomSheet: Cntr(
        height: 140,
        width: Get.width,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                popUptambahPaket();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
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
                      'Buat paket tim layanan',
                      style: greyTextStyle,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            ButtomGradient(
                label: "Simpan",
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }

  Cntr cardPaketTim(int index) {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 10),
      radius: BorderRadius.circular(10),
      width: Get.width,
      gradient: gradient1,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: "PAKET Regular",
                    weight: bold,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Txt(
                    text: "Deskripsi",
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
                      paketLayananNurseController.idPaket.value =
                          controller.nursepaketData[index]['id'];
                      Get.defaultDialog(
                        title: "Apakah Anda yakin?",
                        middleText: 'Menghapus Paket Layanan ini',
                        confirm: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              await paketLayananNurseController
                                  .deleteNursePket();
                              controller.paketTimHospital;
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
                      paketLayananNurseController.idPaket.value =
                          controller.nursepaketData[index]['id'];
                      controller.namaPaketController.text =
                          controller.nursepaketData[index]['name'];
                      controller.deskripsiPaketController.text =
                          controller.nursepaketData[index]['description'];
                      controller.hargaPaketController.text =
                          controller.nursepaketData[index]['price'].toString();
                      controller.diskonPaketController.text = controller
                          .nursepaketData[index]['discount']
                          .toString();
                      controller.hargaCurrens.value =
                          controller.nursepaketData[index]['price'].toString();
                      if (controller.nursepaketData[index]['discount'] != 0) {
                        controller.tambahDiskon.value = true;
                      }
                      popUpEditPaket(index);
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            alignment: Alignment.centerLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Txt(
                      text: NumberFormat.currency(
                        locale: 'id_IDR',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ).format(200000).toString(),
                      color: Colors.black,
                      weight: bold,
                    ),
                    Txt(
                      text: "  /1 hari",
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Cntr(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            alignment: Alignment.centerLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Obx(
                //   () => paketLayananNurseController.tampunganNurseId.isNotEmpty ||
                //           controller.nursepaketData[index]['package_nurse_sops'] !=
                //               []
                //       ? Txt(
                //           text: paketLayananNurseController.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${paketLayananNurseController.tampunganNurseId.length} Dipilih')
                //       :
                Txt(
                  text: " 5 dipilih",
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            alignment: Alignment.centerLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: "50",
                  color: Colors.black,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ).format(
                    // controller
                    //           .nursepaketData[index]
                    //       ['price'] -
                    //   (controller.nursepaketData[index]
                    //               ['price'] *
                    //           controller.nursepaketData[
                    //               index]['discount']) /
                    //       100
                    20000),
                color: whiteColor,
                weight: bold,
                size: 16,
              )
            ],
          )
        ],
      ),
    );
  }

  popUptambahPaket() {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: 500,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Cntr(
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                      paketLayananNurseController.namaPaket.value =
                          controller.namaPaketController.text;
                    },
                    controller: controller.namaPaketController,
                    onTap: () {}),
                InputPrimary(
                    hintText: "Deskripsi",
                    onChange: (p0) {
                      paketLayananNurseController.deskripsiPaket.value =
                          controller.deskripsiPaketController.text;
                    },
                    controller: controller.deskripsiPaketController,
                    // controller
                    //     .deskripsiPaketC,
                    onTap: () {}),
                Row(
                  children: [
                    Cntr(
                      // height: 75,
                      width: Get.width / 1.3,
                      child: InputPrimary(
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
                            controller.hargaCurrens.value = int.parse(controller
                                    .hargaPaketController.text
                                    .replaceAll(".", ""))
                                .toString();
                            controller.totalHargaPaket.value =
                                double.parse(controller.hargaCurrens.value);
                          },
                          controller: controller.hargaPaketController,
                          // controller
                          //     .hargaPaketC,
                          onTap: () {}),
                    ),
                    Txt(
                      text: '    /Hari',
                      color: Colors.grey,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    if (paketLayananNurseController.nurseScopeData.isEmpty) {
                      await paketLayananNurseController.getNurseWorkScope();
                    }
                    for (var i = 0; i < controller.nursepaketData.length; i++) {
                      // var item = items[i];
                      paketLayananNurseController.packageNurseSops.value =
                          controller.nursepaketData[i]['package_nurse_sops'];
                    }
                    Get.to(() => const TambahScopeOfWork());
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Obx(
                        //   () => paketLayananNurseController.tampunganNurseId.isNotEmpty ||
                        //           controller.nursepaketData[index]['package_nurse_sops'] !=
                        //               []
                        //       ? Txt(
                        //           text: paketLayananNurseController.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${paketLayananNurseController.tampunganNurseId.length} Dipilih')
                        //       :
                        Txt(
                          text: 'Scope of Work',
                          color: AppColor.bodyColor.shade500,
                        ),
                        // ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.bodyColor.shade500,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                        controller:
                                            controller.diskonPaketController,
                                        //  controller.diskonPaket,
                                        onChanged: (value) {
                                          var harga = double.parse(
                                              controller.hargaCurrens.value);
                                          var diskonHome = double.parse(
                                              controller.diskonPaketController
                                                  .value.text);
                                          var persenDisko = diskonHome / 100;
                                          controller.totalHargaPaket.value =
                                              harga - (harga * persenDisko);
                                        },
                                        style: blackTextStyle.copyWith(
                                            fontWeight: bold),
                                        decoration: const InputDecoration(
                                          fillColor: AppColor.bgForm,
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
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
                              padding: const EdgeInsets.only(top: 10.0),
                              child: InkWell(
                                onTap: () {
                                  controller.hargaTanpaDiskon.value =
                                      controller.hargaPaketController.text;
                                  controller.tambahDiskon.value = false;
                                  controller.diskonPaketController.text = "";
                                  controller.totalHargaPaket.value =
                                      double.parse(
                                          controller.hargaTanpaDiskon.value);
                                },
                                child: Row(
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
                          onTap: () {
                            controller.tambahDiskon.value = true;
                            // Get.to(() => TambahScopeOfWork());
                          },
                          child: Container(
                            width: Get.width,
                            height: 45,
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
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                // Obx(() =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Actual Prices',
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Obx(
                      () => SizedBox(
                          width: Get.width / 4.5,
                          child: Txt(
                            text: NumberFormat.currency(
                              locale: 'id_IDR',
                              symbol: 'Rp. ',
                              decimalDigits: 0,
                            ).format(controller.totalHargaPaket.value),
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                // Obx(
                //   () =>
                //   controller
                //               .namaPaket
                //               .isEmpty &&
                //           controller
                //               .deskripsiPaket
                //               .isEmpty &&
                //           controller
                //                   .totalHargaPaket
                //                   .value ==
                //               0.0 &&
                //           controller
                //               .tampunganNurseId
                //               .isEmpty
                //       ? ButtonPrimary(
                //           marginLeft:
                //               0,
                //           marginRight:
                //               0,
                //           title:
                //               'Tambahkan',
                //           onPressed:
                //               () {})
                //       :
                ButtomGradient(
                    margin: 0,
                    label: 'Simpan',
                    onTap: () async {
                      Get.back();
                    }),
                // ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }

  popUpEditPaket(int index) {
    return Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: 500,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Cntr(
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                      // controller
                      //         .namaPaket
                      //         .value =
                      //     controller
                      //         .namaPaketController
                      //         .text;
                    },
                    controller: controller.namaPaketController,
                    onTap: () {}),
                InputPrimary(
                    hintText: "Deskripsi",
                    onChange: (p0) {
                      // controller
                      //         .deskripsiPaket
                      //         .value =
                      //     controller
                      //         .deskripsiPaketController
                      //         .text;
                    },
                    controller: controller.deskripsiPaketController,
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
                      controller.hargaCurrens.value = int.parse(controller
                              .hargaPaketController.text
                              .replaceAll(".", ""))
                          .toString();
                      controller.totalHargaPaket.value =
                          double.parse(controller.hargaCurrens.value);
                    },
                    controller: controller.hargaPaketController,
                    onTap: () {}),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    if (paketLayananNurseController.nurseScopeData.isEmpty) {
                      await paketLayananNurseController.getNurseWorkScope();
                    }
                    for (var i = 0; i < controller.nursepaketData.length; i++) {
                      // var item = items[i];
                      paketLayananNurseController.packageNurseSops.value =
                          controller.nursepaketData[i]['package_nurse_sops'];
                    }

                    // a
                    Get.to(() => const TambahScopeOfWork());
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => paketLayananNurseController
                                      .tampunganNurseId.isNotEmpty ||
                                  controller.nursepaketData[index]
                                          ['package_nurse_sops'] !=
                                      []
                              ? Txt(
                                  text: paketLayananNurseController
                                          .tampunganNurseId.isEmpty
                                      ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih"
                                      : '${paketLayananNurseController.tampunganNurseId.length} Dipilih')
                              : Txt(
                                  text: 'Scope of Work',
                                  color: AppColor.bodyColor.shade500,
                                ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.bodyColor.shade500,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 10),
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
                                        controller:
                                            controller.diskonPaketController,
                                        onChanged: (value) {
                                          var harga = double.parse(
                                              controller.hargaCurrens.value);
                                          var diskonHome = double.parse(
                                              controller.diskonPaketController
                                                  .value.text);
                                          var persenDisko = diskonHome / 100;
                                          controller.totalHargaPaket.value =
                                              harga - (harga * persenDisko);
                                        },
                                        style: blackTextStyle.copyWith(
                                            fontWeight: bold),
                                        decoration: const InputDecoration(
                                          fillColor: AppColor.bgForm,
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
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
                              padding: const EdgeInsets.only(top: 10.0),
                              child: InkWell(
                                onTap: () {
                                  controller.tambahDiskon.value = false;
                                  controller.diskonPaketController.text = "";
                                  controller.totalHargaPaket.value =
                                      double.parse(
                                          controller.hargaPaketController.text);
                                },
                                child: Row(
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
                          onTap: () {
                            controller.tambahDiskon.value = true;
                            // Get.to(() => TambahScopeOfWork());
                          },
                          child: Container(
                            width: Get.width,
                            height: 45,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Actual Prices',
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                            width: Get.width / 4.5,
                            child: Txt(
                              text: NumberFormat.currency(
                                locale: 'id_IDR',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              )
                                  .format(controller.totalHargaPaket.value)
                                  .toString(),
                              color: Colors.green,
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () => paketLayananNurseController.namaPaket.isEmpty &&
                          paketLayananNurseController.deskripsiPaket.isEmpty &&
                          controller.totalHargaPaket.value == 0.0 &&
                          paketLayananNurseController.tampunganNurseId.isEmpty
                      ? ButtonPrimary(
                          marginLeft: 0,
                          marginRight: 0,
                          title: 'Tambahkan',
                          onPressed: () {})
                      : ButtomGradient(
                          margin: 0,
                          label: 'Ubah Paket',
                          onTap: () async {
                            await controller.editPaketLayananNurse();
                            Get.back();
                            controller.namaPaketController.clear();
                            controller.deskripsiPaketController.clear();
                            controller.hargaPaketController.clear();
                            controller.diskonPaketController.clear();
                            paketLayananNurseController.tampunganNurseId.value =
                                [];
                            controller.paketTimHospital();
                            paketLayananNurseController.namaPaket.value = "";
                            paketLayananNurseController.deskripsiPaket.value =
                                "";
                            controller.totalHargaPaket.value = 0.0;
                            controller.tambahDiskon.value = false;
                            paketLayananNurseController.dataActive.clear();
                            paketLayananNurseController.tampunganNurseId.value =
                                [];
                            paketLayananNurseController.nurseScopeData.value =
                                [];

                            paketLayananNurseController.packageNurseSops.value =
                                [];
                          }),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }
}
