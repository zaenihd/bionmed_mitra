// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widget/button/button_gradien.dart';
import '../../../../widget/button/button_primary_withtext.dart';
import '../../../../widget/header/header_layanan.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class RegisterDataAkun extends StatelessWidget {
  RegisterDataAkun({super.key});
  TextEditingController pendidikanC = TextEditingController();
  TextEditingController pengalamanKerjaC = TextEditingController();
  TextEditingController jamPraktikC = TextEditingController();
  final registerC = Get.put(RegisterController());

  Widget buildTimePickerMulai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
          String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
          registerC.timesMulai.value = dates.toString();
          registerC.timesMulaiUI.value = datesUi.toString();
        },
        use24hFormat: false,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  Widget buildTimePickerBerakhir() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
          String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
          registerC.timesBerakhir.value = dates.toString();
          registerC.timesBerakhirUI.value = datesUi.toString();
        },
        use24hFormat: false,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                  imageUrl: 'assets/icon/icon_biodata.png',
                  title: "Biodata",
                  subtitle:
                      "Isi data ini dengan lengkap untuk membuat \nakun anda"),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pendidikan',
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      if (pendidikanC.value.text != "") {
                        registerC.listPendidikan.add(pendidikanC.value.text);
                        pendidikanC.clear();
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Tambah',
                          style: blackTextStyle.copyWith(color: blueColor),
                        ),
                        Icon(
                          Icons.add,
                          size: 15,
                          color: blueColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              InputPrimary(
                onChange: (p0) {},
                controller: pendidikanC,
                onTap: () {},
                hintText: 'Masukkan riwayat pendidikan',
              ),
              Obx(
                () => registerC.listPendidikan.isEmpty
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : SizedBox(
                        height: 30.0,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: registerC.listPendidikan.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              height: 20,
                              decoration: const BoxDecoration(
                                gradient: gradient1,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  AutoSizeText(
                                    '${registerC.listPendidikan[index]}',
                                    style: whiteTextStyle.copyWith(),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        registerC.listPendidikan
                                            .removeAt(index);
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        size: 15,
                                        color: whiteColor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pengalaman Anda',
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      if (pengalamanKerjaC.value.text != "") {
                        registerC.listPengalaman
                            .add(pengalamanKerjaC.value.text);
                        pengalamanKerjaC.clear();
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Tambah',
                          style: blackTextStyle.copyWith(color: blueColor),
                        ),
                        Icon(
                          Icons.add,
                          size: 15,
                          color: blueColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              InputPrimary(
                onChange: (p0) {},
                controller: pengalamanKerjaC,
                onTap: () {},
                hintText: 'Pengalaman tugas anda',
              ),
              //
              Obx(
                () => registerC.listPengalaman.isEmpty
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : SizedBox(
                        height: 30.0,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: registerC.listPengalaman.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              height: 20,
                              decoration: const BoxDecoration(
                                gradient: gradient1,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  AutoSizeText(
                                    '${registerC.listPengalaman[index]}',
                                    style: whiteTextStyle.copyWith(),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        registerC.listPengalaman
                                            .removeAt(index);
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        size: 15,
                                        color: whiteColor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jam Praktik',
                    textAlign: TextAlign.left,
                  ),
                  InkWell(
                    onTap: () {
                      if (registerC.timesMulaiUI != "" &&
                          registerC.timesBerakhirUI != "") {
                        registerC.listJadwalMulai.add(registerC.timesMulaiUI);
                        registerC.listJadwalBerakhir
                            .add(registerC.timesBerakhirUI);
                      } else {
                        registerC.timesBerakhirUI.value = "";
                        registerC.timesMulaiUI.value = "";
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Tambah',
                          style: blackTextStyle.copyWith(color: blueColor),
                        ),
                        Icon(
                          Icons.add,
                          size: 15,
                          color: blueColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[350]!),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  buildTimePickerMulai(),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            });
                      },
                      child: Obx(() => Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(registerC.timesMulaiUI.value == ""
                              ? '00:00'
                              : registerC.timesMulaiUI.value))),
                    ),
                    const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  buildTimePickerBerakhir(),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            });
                      },
                      child: Obx(() => Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(registerC.timesBerakhirUI.value == ""
                              ? '00:00'
                              : registerC.timesBerakhirUI.value))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  height: 30.0,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: registerC.listJadwalMulai.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        height: 20,
                        decoration: const BoxDecoration(
                          gradient: gradient1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            AutoSizeText(
                              '${registerC.listJadwalMulai[index]}',
                              style: whiteTextStyle.copyWith(),
                            ),
                            const Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.white,
                            ),
                            AutoSizeText(
                              '${registerC.listJadwalBerakhir[index]}',
                              style: whiteTextStyle.copyWith(),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                                onTap: () {
                                  registerC.listJadwalMulai.removeAt(index);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 15,
                                  color: whiteColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),

              // InputPrimary(
              //   onChange: (p0) {},
              //   controller: jamPraktikC,
              //   onTap: () {
              //     showModalBottomSheet(
              //         context: context,
              //         builder: (context) {
              //           return Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               buildTimePicker(),
              //               ElevatedButton(
              //                 onPressed: () {
              //                   Get.back();
              //                 },
              //                 child: Text('Ok'),
              //               ),
              //               const SizedBox(
              //                 height: 10.0,
              //               ),
              //             ],
              //           );
              //         });
              //     setState(() {
              //       jamPraktikC.value = Get.find<RegisterController>()
              //           .times
              //           .value as TextEditingValue;
              //     });
              //     print(jamPraktikC);
              //   },
              //   hintText: '00:00 - 00:00',
              // )
            ],
          ),
        ),
      ),
      bottomSheet: Obx(() => Container(
          margin: const EdgeInsets.only(bottom: 24),
          height: 45,
          width: double.infinity,
          child: registerC.listPendidikan.isNotEmpty &&
                  registerC.listPengalaman.isNotEmpty &&
                  registerC.listJadwalMulai.isNotEmpty &&
                  registerC.listJadwalBerakhir.isNotEmpty
              ? ButtomGradient(label: "Lanjutkan", onTap: () {
                Get.toNamed(Routes.BOTTOM_NAVIGATION);
              })
              // Get.toNamed(Routes.LAYANAN);
              : ButtonPrimary(
                  title: "Lanjutkan",
                  onPressed: () {
                    // Get.toNamed(Routes.LAYANAN);
                  }))),
    );
  }
}
