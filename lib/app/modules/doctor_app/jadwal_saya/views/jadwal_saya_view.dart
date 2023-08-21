import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../widget/button/button_gradien.dart';
import '../controllers/jadwal_saya_controller.dart';

class JadwalSayaView extends GetView<JadwalSayaController> {
  JadwalSayaView({Key? key}) : super(key: key);
  final loginC = Get.find<JadwalSayaController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // controller.getdata();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Jadwal Saya"),
          elevation: 0.0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/icon/icon_jadwal_saya.png'),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Praktek',
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Atur jadwal praktek anda sesuai jam kerja\nanda untuk menangani pasien',
                        style: blackTextStyle.copyWith(
                            fontSize: 11, fontWeight: normal),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height / 1.6,
                child: Obx(
                  () => controller.isloading.isTrue
                      ? loadingIndicator()
                      // SizedBox(
                      //     width: Get.width,
                      //     height: 50,
                      //     child: 
                      //     ListView.builder(
                      //       // padding: EdgeInsets.all(10),
                      //       itemCount: 7,
                      //       itemBuilder: (context, index) => Shimmer.fromColors(
                      //           baseColor: Colors.grey,
                      //           highlightColor: Colors.white,
                      //           child: Container(
                      //             margin: EdgeInsets.only(top: 20),
                      //             height: 50,
                      //             width: Get.width,
                      //             color: Colors.black,
                      //           )),
                      //     ))
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          // reverse: true,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: loginC.dataDokter.length,
                          itemBuilder: (context, index) {
                            int reverseIndex =
                                loginC.dataDokter.length - 1 - index;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      loginC.dataDokter[reverseIndex]['day'],
                                      style:
                                          blackTextStyle.copyWith(fontSize: 16),
                                    ),
                                    Obx(() => controller
                                                    .dataDokter[reverseIndex]
                                                ['isActive'] ==
                                            false
                                        ? InkWell(
                                            onTap: () async {
                                              controller.idJadwal.value = loginC
                                                      .dataDokter[reverseIndex]
                                                  ['id'];
                                              await controller
                                                  .updateJadwanOnOff(
                                                      isActive: true);
                                              var phone =
                                                  await box.read('phone');
                                              if (phone != null) {
                                                await controller.loginData(
                                                    phoneNumber: phone);
                                              }
                                            },
                                            child: Image.asset(
                                                'assets/icon/jadwal_off.png'))
                                        : InkWell(
                                            onTap: () async {
                                              controller.idJadwal.value = loginC
                                                      .dataDokter[reverseIndex]
                                                  ['id'];
                                              await controller
                                                  .updateJadwanOnOff(
                                                      isActive: false);
                                              var phone =
                                                  await box.read('phone');
                                              if (phone != null) {
                                                await controller.loginData(
                                                    phoneNumber: phone);
                                              }
                                            },
                                            child: Image.asset(
                                                'assets/icon/jadwal_on.png')))
                                  ],
                                ),
                                controller.dataDokter[reverseIndex]
                                            ['isActive'] ==
                                        true
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: Get.width / 3.5,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: buttonColor!)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: buttonColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(loginC.dataDokter[
                                                              reverseIndex]
                                                          ['startTime'])
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              const Text(':'),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 40,
                                                  width: Get.width / 3.5,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: buttonColor!)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: buttonColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(loginC.dataDokter[
                                                              reverseIndex]
                                                          ['endTime'])
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      )
                                    : const SizedBox(),
                                const Divider(
                                  thickness: 1,
                                )
                              ],
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 30, top: 20),
          child: ButtomGradient(
            label: 'Selesai',
            onTap: () {
              // Get.back();
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 400,
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
                        Image.asset('assets/icon/icon_jadwal_time.png'),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Simpan Jadwal',
                          style: blackTextStyle.copyWith(
                              fontWeight: bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Apakah anda yakin untuk merubah jadwal praktek anda?',
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        ButtomGradient(
                            label: 'Simpan Perubahan',
                            onTap: () {
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
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
