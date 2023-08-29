import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_paket_layanan_call_controller.dart';

class ProfilePaketLayananCallView
    extends GetView<ProfilePaketLayananCallController> {
  const ProfilePaketLayananCallView({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Paket Layanan Call',
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
                () => controller.buatPaket.isFalse
                    ? InkWell(
                        onTap: () {
                          controller.buatPaket.value = true;
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 36),
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
                                'Buat paket call',
                                style: greyTextStyle,
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            margin:
                                const EdgeInsets.only(left: 24, right: 24, top: 20),
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
                                            borderRadius:
                                                BorderRadius.all(
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
                                                  const EdgeInsets.only(bottom: 5),
                                              border: const OutlineInputBorder(),
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
                                            borderRadius:
                                                BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: controller.harga,
                                          onChanged: (value) {
                                            controller.totalHarga.value =
                                                double.parse(controller
                                                    .harga.value.text);
                                          },
                                          style: blackTextStyle.copyWith(
                                              fontWeight: bold),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(bottom: 5),
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
                                            margin: const EdgeInsets.only(top: 15),
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
                                                margin:
                                                    const EdgeInsets.only(top: 15),
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
                                                      padding: const EdgeInsets.only(
                                                          left: 10),
                                                      width: Get.width / 2,
                                                      child: TextFormField(
                                                        controller:
                                                            controller.diskon,
                                                        onChanged: (value) {
                                                          var harga =
                                                              double.parse(
                                                                  controller
                                                                      .harga
                                                                      .value
                                                                      .text);
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
                          InkWell(
                            onTap: () {
                              if (controller.minute.value.text.isEmpty ||
                                  controller.harga.value.text.isEmpty) {
                                showPopUp(
                                    imageAction: 'assets/json/eror.json',
                                    description: "Data belum lengkap",
                                    onTap: () {
                                      Get.back();
                                    });
                              } else {
                                controller.listPaket.add({
                                  "minute": controller.minute.value.text,
                                  "harga": controller.totalHarga.value,
                                  "diskon": controller.diskon.value.text,

                                });
                                  controller.minute.clear();
                                  controller.diskon.clear();
                                  controller.harga.clear();
                                  controller.totalHarga.value = 0;
                                  controller.buatDiskon.value = false;
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
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
                          SizedBox(
                              height: Get.height / 1.7,
                              child: ListView.builder(
                                itemCount: controller.listPaket.length,
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  margin: const EdgeInsets.only(
                                      left: 24, right: 24, top: 20),
                                  height:
                                      // controller.listPaket[index]['diskon'] == "" ? 75 : 150,
                                      75,
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
                                            padding: const EdgeInsets.all(10),
                                            height: 48,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey[500]!,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                color: Colors.white),
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
                                                  '${controller.listPaket[index]['minute']}',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontWeight: bold),
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
                                            style: blackTextStyle.copyWith(
                                                fontWeight: bold),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 48,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey[500]!,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'id_IDR',
                                                    symbol: 'Rp. ',
                                                    decimalDigits: 0,
                                                  )
                                                      .format(controller
                                                              .listPaket[index]
                                                          ['harga'])
                                                      .toString(),
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontWeight: bold,
                                                    color:
                                                        const Color(0xff555555),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.listPaket
                                                  .removeAt(index);
                                            },
                                            child: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                      Obx(
                                        () => controller.listPaket[index]
                                                    ['diskon'] ==
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
                              ))
                        ],
                      ),
              )

              //
            ],
          ),
        ),
        bottomSheet: Obx(
          () => controller.buatPaket.isFalse
              ? const SizedBox(
                  height: 1.0,
                )
              : Padding(
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
                                  margin: const EdgeInsets.only(
                                      bottom: 18, top: 14),
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
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                const SizedBox(
                                  height: 36.0,
                                ),
                                Container(
                                  decoration:
                                      BoxDecoration(
                                        borderRadius:
                                                BorderRadius.circular(7),
                                        gradient: gradient1),
                                  height: 45,
                                  width: 312,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Simpan")),
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
                                                  BorderRadius.circular(6)),
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
                ),
        ));
  }
}
