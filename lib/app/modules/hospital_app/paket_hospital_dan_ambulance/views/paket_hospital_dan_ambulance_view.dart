import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme.dart';
import '../controllers/paket_hospital_dan_ambulance_controller.dart';

class PaketHospitalDanAmbulanceView
    extends GetView<PaketHospitalDanAmbulanceController> {
  const PaketHospitalDanAmbulanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Paket Hospital'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Cntr(
              height: 400,
              width: Get.width,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => Cntr(
                  margin: const EdgeInsets.only(bottom: 10),
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  gradient: gradient1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                text: "PAKET",
                                weight: bold,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Txt(
                                text: "DEskripsi",
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
                                  // controller
                                  //     .idPaket.value = controller
                                  //         .nursepaketData[index]
                                  //     ['id'];
                                  // Get.defaultDialog(
                                  //   title: "Apakah Anda yakin?",
                                  //   middleText:
                                  //       'Menghapus Paket Layanan ini',
                                  //   confirm: ElevatedButton(
                                  //       style: ElevatedButton
                                  //           .styleFrom(
                                  //               backgroundColor:
                                  //                   Colors.red),
                                  //       onPressed: () async {
                                  //         await controller
                                  //             .deleteNursePket();
                                  //         controller
                                  //             .getNursePket();
                                  //         Get.back();
                                  //       },
                                  //       child: Txt(
                                  //         text: 'Hapus',
                                  //         color: Colors.white,
                                  //       )),
                                  //   cancel: ElevatedButton(
                                  //       onPressed: () {
                                  //         Get.back();
                                  //       },
                                  //       child: Txt(
                                  //         text: 'Kembali',
                                  //         color: Colors.white,
                                  //       )),
                                  // );
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
                                  // controller
                                  //     .idPaket.value = controller
                                  //         .nursepaketData[index]
                                  //     ['id'];
                                  // controller.namaPaketC
                                  //     .text = controller
                                  //         .nursepaketData[index]
                                  //     ['name'];
                                  // controller.deskripsiPaketC
                                  //     .text = controller
                                  //         .nursepaketData[index]
                                  //     ['description'];
                                  // controller.hargaPaketC.text =
                                  //     controller
                                  //         .nursepaketData[index]
                                  //             ['price']
                                  //         .toString();
                                  // controller.diskonPaket.text =
                                  //     controller
                                  //         .nursepaketData[index]
                                  //             ['discount']
                                  //         .toString();
                                  //         controller.hargaCurrens.value = controller
                                  //         .nursepaketData[index]
                                  //             ['price']
                                  //         .toString();
                                  // if (controller.nursepaketData[
                                  //         index]['discount'] !=
                                  //     0) {
                                  //   controller.tambahDiskon
                                  //       .value = true;
                                  // }
                                  popUptambahPaket();
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
                            Txt(
                              text: NumberFormat.currency(
                                locale: 'id_IDR',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format(200000).toString(),
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
                              text: " 33",
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
                              text: "diso",
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
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const TambahPaketAmbulance());
                // popUptambahPaket();

                // popUpActionTambahTenagaMedis(context);
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
                      'Buat paket layanan',
                      style: greyTextStyle,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
                      // controller
                      //         .namaPaket
                      //         .value =
                      //     controller
                      //         .namaPaketC
                      //         .text;
                    },
                    controller: TextEditingController(),
                    onTap: () {}),
                InputPrimary(
                    hintText: "Deskripsi",
                    onChange: (p0) {
                      // controller
                      //         .deskripsiPaket
                      //         .value =
                      //     controller
                      //         .deskripsiPaketC
                      //         .text;
                    },
                    controller: TextEditingController(),
                    // controller
                    //     .deskripsiPaketC,
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
                      //                    controller.hargaCurrens.value =
                      // int.parse(controller
                      //         .hargaPaketC.text
                      //         .replaceAll(".", ""))
                      //     .toString();
                      //                   controller
                      //                           .totalHargaPaket
                      //                           .value =
                      //                       double.parse(controller.hargaCurrens.value);
                    },
                    controller: TextEditingController(),
                    // controller
                    //     .hargaPaketC,
                    onTap: () {}),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    // if (controller
                    //     .nurseScopeData
                    //     .isEmpty) {
                    //   await controller
                    //       .getNurseWorkScope();
                    // }
                    // for (var i = 0;
                    //     i <
                    //         controller
                    //             .nursepaketData
                    //             .length;
                    //     i++) {
                    //   // var item = items[i];
                    //   controller
                    //       .packageNurseSops
                    //       .value = controller
                    //           .nursepaketData[i]
                    //       [
                    //       'package_nurse_sops'];
                    // }

                    // a
                    // Get.to(() =>
                    //     const TambahScopeOfWork());
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
                        //   () => controller.tampunganNurseId.isNotEmpty ||
                        //           controller.nursepaketData[index]['package_nurse_sops'] !=
                        //               []
                        //       ? Txt(
                        //           text: controller.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${controller.tampunganNurseId.length} Dipilih')
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
                // Obx(
                //   () => controller
                //           .tambahDiskon
                //           .isTrue
                //       ? Row(
                //           crossAxisAlignment:
                //               CrossAxisAlignment
                //                   .center,
                //           children: [
                //             Container(
                //                 margin:
                //                     const EdgeInsets.only(top: 10),
                //                 width: Get.width / 1.7,
                //                 height: 45,
                //                 decoration: BoxDecoration(
                //                     border: Border.all(
                //                       width: 1.0,
                //                       color: Colors.grey[400]!,
                //                     ),
                //                     borderRadius: BorderRadius.circular(6),
                //                     color: Colors.white),
                //                 alignment: Alignment.center,
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       padding: const EdgeInsets.only(left: 10),
                //                       width: Get.width / 2,
                //                       child: TextFormField(

                //                         keyboardType: TextInputType.number,
                //                         controller:TextEditingController(),
                //                         //  controller.diskonPaket,
                //                         onChanged: (value) {
                //                           // var harga = double.parse(controller.hargaCurrens.value);
                //                           // var diskonHome = double.parse(controller.diskonPaket.value.text);
                //                           // var persenDisko = diskonHome / 100;
                //                           // controller.totalHargaPaket.value = harga - (harga * persenDisko);
                //                         },
                //                         style: blackTextStyle.copyWith(fontWeight: bold),
                //                         decoration: const InputDecoration(
                //                           fillColor: AppColor.bgForm,
                //                           filled: true,
                //                           contentPadding: EdgeInsets.only(bottom: 5),
                //                           border: OutlineInputBorder(borderSide: BorderSide.none),
                //                         ),
                //                       ),
                //                     ),
                //                     Icon(
                //                       Icons.percent,
                //                       color: yellowColor,
                //                     ),
                //                   ],
                //                 )),
                //             const SizedBox(
                //               width:
                //                   10.0,
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.only(top: 10.0),
                //               child:
                //                   InkWell(
                //                 onTap:
                //                     () {
                //                   // controller.tambahDiskon.value = false;
                //                   // controller.diskonPaket.text = "";
                //                   // controller.totalHargaPaket.value = double.parse(controller.hargaPaketC.text);
                //                 },
                //                 child:
                //                     Row(
                //                   children: [
                //                     const Icon(
                //                       Icons.disabled_by_default_outlined,
                //                       color: Colors.red,
                //                     ),
                //                     const SizedBox(
                //                       width: 6.0,
                //                     ),
                //                     Txt(text: 'Hapus', color: Colors.red)
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )
                //       :
                InkWell(
                  onTap: () {
                    // controller
                    //     .tambahDiskon
                    //     .value = true;
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
                    SizedBox(
                        width: Get.width / 4.5,
                        child: Txt(
                          text: NumberFormat.currency(
                            locale: 'id_IDR',
                            symbol: 'Rp. ',
                            decimalDigits: 0,
                          ).format(1000000),
                          color: Colors.green,
                        )),
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
                    margin: 0, label: 'Simpan', onTap: () async {}),
                // ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }
}

class TambahPaketAmbulance extends StatelessWidget {
  const TambahPaketAmbulance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Paket Ambulance'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
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
                    //         .namaPaketC
                    //         .text;
                  },
                  controller: TextEditingController(),
                  onTap: () {}),
              InputPrimary(
                  hintText: "Deskripsi",
                  onChange: (p0) {
                    // controller
                    //         .deskripsiPaket
                    //         .value =
                    //     controller
                    //         .deskripsiPaketC
                    //         .text;
                  },
                  controller: TextEditingController(),
                  // controller
                  //     .deskripsiPaketC,
                  onTap: () {}),

              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () async {
                  // if (controller
                  //     .nurseScopeData
                  //     .isEmpty) {
                  //   await controller
                  //       .getNurseWorkScope();
                  // }
                  // for (var i = 0;
                  //     i <
                  //         controller
                  //             .nursepaketData
                  //             .length;
                  //     i++) {
                  //   // var item = items[i];
                  //   controller
                  //       .packageNurseSops
                  //       .value = controller
                  //           .nursepaketData[i]
                  //       [
                  //       'package_nurse_sops'];
                  // }

                  // a
                  // Get.to(() =>
                  //     const TambahScopeOfWork());
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
                      //   () => controller.tampunganNurseId.isNotEmpty ||
                      //           controller.nursepaketData[index]['package_nurse_sops'] !=
                      //               []
                      //       ? Txt(
                      //           text: controller.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${controller.tampunganNurseId.length} Dipilih')
                      //       :
                      Txt(
                        text: 'Pilih tipe ambulance',
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
              InputPrimary(
                  suffixIcon: Cntr(
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Txt(text: '/1 km')),
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
                  hintText: "Masukkan Harga",
                  onChange: (p0) {
                    //                    controller.hargaCurrens.value =
                    // int.parse(controller
                    //         .hargaPaketC.text
                    //         .replaceAll(".", ""))
                    //     .toString();
                    //                   controller
                    //                           .totalHargaPaket
                    //                           .value =
                    //                       double.parse(controller.hargaCurrens.value);
                  },
                  controller: TextEditingController(),
                  // controller
                  //     .hargaPaketC,
                  onTap: () {}),
              const SizedBox(
                height: 10.0,
              ),
              // Obx(
              //   () => controller
              //           .tambahDiskon
              //           .isTrue
              //       ? Row(
              //           crossAxisAlignment:
              //               CrossAxisAlignment
              //                   .center,
              //           children: [
              //             Container(
              //                 margin:
              //                     const EdgeInsets.only(top: 10),
              //                 width: Get.width / 1.7,
              //                 height: 45,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                       width: 1.0,
              //                       color: Colors.grey[400]!,
              //                     ),
              //                     borderRadius: BorderRadius.circular(6),
              //                     color: Colors.white),
              //                 alignment: Alignment.center,
              //                 child: Row(
              //                   children: [
              //                     Container(
              //                       padding: const EdgeInsets.only(left: 10),
              //                       width: Get.width / 2,
              //                       child: TextFormField(

              //                         keyboardType: TextInputType.number,
              //                         controller:TextEditingController(),
              //                         //  controller.diskonPaket,
              //                         onChanged: (value) {
              //                           // var harga = double.parse(controller.hargaCurrens.value);
              //                           // var diskonHome = double.parse(controller.diskonPaket.value.text);
              //                           // var persenDisko = diskonHome / 100;
              //                           // controller.totalHargaPaket.value = harga - (harga * persenDisko);
              //                         },
              //                         style: blackTextStyle.copyWith(fontWeight: bold),
              //                         decoration: const InputDecoration(
              //                           fillColor: AppColor.bgForm,
              //                           filled: true,
              //                           contentPadding: EdgeInsets.only(bottom: 5),
              //                           border: OutlineInputBorder(borderSide: BorderSide.none),
              //                         ),
              //                       ),
              //                     ),
              //                     Icon(
              //                       Icons.percent,
              //                       color: yellowColor,
              //                     ),
              //                   ],
              //                 )),
              //             const SizedBox(
              //               width:
              //                   10.0,
              //             ),
              //             Padding(
              //               padding:
              //                   const EdgeInsets.only(top: 10.0),
              //               child:
              //                   InkWell(
              //                 onTap:
              //                     () {
              //                   // controller.tambahDiskon.value = false;
              //                   // controller.diskonPaket.text = "";
              //                   // controller.totalHargaPaket.value = double.parse(controller.hargaPaketC.text);
              //                 },
              //                 child:
              //                     Row(
              //                   children: [
              //                     const Icon(
              //                       Icons.disabled_by_default_outlined,
              //                       color: Colors.red,
              //                     ),
              //                     const SizedBox(
              //                       width: 6.0,
              //                     ),
              //                     Txt(text: 'Hapus', color: Colors.red)
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         )
              //       :
              InkWell(
                onTap: () {
                  // controller
                  //     .tambahDiskon
                  //     .value = true;
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
              // ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () async {
                  // if (controller
                  //     .nurseScopeData
                  //     .isEmpty) {
                  //   await controller
                  //       .getNurseWorkScope();
                  // }
                  // for (var i = 0;
                  //     i <
                  //         controller
                  //             .nursepaketData
                  //             .length;
                  //     i++) {
                  //   // var item = items[i];
                  //   controller
                  //       .packageNurseSops
                  //       .value = controller
                  //           .nursepaketData[i]
                  //       [
                  //       'package_nurse_sops'];
                  // }

                  // a
                  // Get.to(() =>
                  //     const TambahScopeOfWork());
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
                      //   () => controller.tampunganNurseId.isNotEmpty ||
                      //           controller.nursepaketData[index]['package_nurse_sops'] !=
                      //               []
                      //       ? Txt(
                      //           text: controller.tampunganNurseId.isEmpty ? "${controller.nursepaketData[index]['package_nurse_sops'].length} Dipilih" : '${controller.tampunganNurseId.length} Dipilih')
                      //       :
                      Txt(
                        text: '3 Daerah terpilih',
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
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Txt(text: 'Aktifkan CSR (Layanan Gratis)')
                ],
              ),
              // Obx(() =>
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Actual Prices',
              //       style: blackTextStyle.copyWith(fontSize: 14),
              //     ),
              //     SizedBox(
              //         width: Get.width / 4.5,
              //         child: Txt(
              //           text: NumberFormat.currency(
              //             locale: 'id_IDR',
              //             symbol: 'Rp. ',
              //             decimalDigits: 0,
              //           ).format(1000000),
              //           color: Colors.green,
              //         )),
              //   ],
              // ),
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
              
              // ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ButtomGradient(
                    margin: 20, label: 'Simpan', onTap: () async {
                      showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 290,
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
                            'Apakah anda yakin?',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 46,
                          ),
                          ButtomGradient(
                              label: 'Konfirmasi',
                              onTap: () async {
                               
                                
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                          ButtonPrimary(title: "Batal", onPressed: () {})
                        ],
                      ),
                    );
                  });
                    }),
      ),
    );
  }
}
