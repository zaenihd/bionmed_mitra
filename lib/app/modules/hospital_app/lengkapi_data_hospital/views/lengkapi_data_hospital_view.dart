import 'dart:developer';

import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_harga_paket_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_lengkapi_data.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widget/other/show_dialog.dart';
import '../controllers/lengkapi_data_hospital_controller.dart';

class LengkapiDataHospitalView extends GetView<LengkapiDataHospitalController> {
  const LengkapiDataHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.
    // getService();
    if (controller.isFromProfile.isTrue) {
      controller.listServiceHospital.value = controller.listServiceHospital
          .where(
            (p0) => p0['team'].length != 0,
          )
          .toList();
    } else {
      controller.serviceHospital();
    }
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: controller.isFromProfile.isFalse,
              child: HeaderLengkapiDataHospital(
                  imageUrl: 'assets/icon/icon_praktek.png',
                  title: 'Layanan',
                  subtitle:
                      'Pilih layanan yang tersedia di Rumah\nSakit dan buat paket layanan',
                  stepper: 'assets/icon/steper1.png'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            listTimLayanan()
          ],
        ),
      ),
      bottomSheet: Visibility(
        visible: controller.isFromProfile.isFalse,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ButtomGradient(
            label: 'Lanjutkan',
            onTap: () async {
              await controller.allTimHospital();

              Get.to(() => TambahHargaPaketHospital());
            },
          ),
        ),
      ),
    );
  }

  Cntr listTimLayanan() {
    return Cntr(
        height: controller.isFromProfile.isFalse ? Get.height / 2 : Get.height,
        width: Get.width,
        child: Obx(
          () => controller.listServiceHospital.isEmpty
              ? loadingIndicator()
              : ListView.builder(
                  itemCount: controller.listServiceHospital.length,
                  itemBuilder: (context, index) => Cntr(
                    onTap: () {
                      if (controller.listServiceHospital[index]['service']
                                  ['name'] ==
                              "Mother Care" ||
                          controller.listServiceHospital[index]['service']
                                  ['name'] ==
                              "Baby Care") {
                        // dataTim.value = controller.listServiceHospital[index]['team'] ?? [];
                        controller.serviceName.value =
                            controller.listServiceHospital[index]['service']
                                    ['name'] ??
                                "";
                        controller.serviceImage.value =
                            controller.listServiceHospital[index]['service']
                                    ['image'] ??
                                "";
                        controller.serviceId.value = controller
                            .listServiceHospital[index]['service']['id'];
                        log('message ${controller.serviceId.value}');
                        controller.index.value = index;
                        Get.to(() => TambahTimLayanan(
                              dataTim: controller.listServiceHospital[index]
                                  ['team'],
                            ));
                      } else {
                        showPopUp(
                            onTap: () {
                              Get.back();
                            },
                            imageAction: 'assets/json/eror.json',
                            description: "Sedang dalam proses\npengembangan");
                        //

                      }
                    },
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 0.4,
                        color: Color.fromARGB(255, 222, 221, 221),
                      )
                    ],
                    radius: BorderRadius.circular(10),
                    color: Colors.white,
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 24, right: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Visibility(
                                visible: controller.isFromProfile.isFalse,
                                child: Row(
                                  children: [
                                    Image.asset(controller
                                                .listServiceHospital[index]
                                                    ['team']
                                                .toString() ==
                                            "[]"
                                        ? 'assets/icon/cekoff.png'
                                        : 'assets/icon/cekon.png'),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                              Cntr(
                                // color: Colors.grey,
                                height: 40,
                                width: 40,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${controller.listServiceHospital[index]['service']['image']}'),
                                    fit: BoxFit.cover),
                              ),
                              // Image.network('${controller.listServiceHospital[index]['service']['image']}')
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Txt(
                                    text:
                                        '${controller.listServiceHospital[index]['service']['name']}',
                                    weight: bold,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Txt(
                                    text: controller.isFromProfile.isTrue
                                        ? "${controller.listServiceHospital[index]['team'].length} tim terdaftar"
                                        : controller
                                                    .listServiceHospital[index]
                                                        ['team']
                                                    .length !=
                                                0
                                            ? "${controller.listServiceHospital[index]['team'].length} tim terdaftar"
                                            : 'Buat tim layanan',
                                    weight: medium,
                                    size: 11,
                                    color: Colors.grey,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ]),
                  ),
                ),
        ));
  }
}

class TambahTimLayanan extends GetView<LengkapiDataHospitalController> {
  TambahTimLayanan({super.key, this.dataTim});
  var dataTim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Tim Layanan'),
      bottomSheet: InkWell(
        onTap: () {
          controller.isEditTim.value = false;
          controller.namaTimController.clear();
          controller.nomerHpTimController.clear();
          controller.deskripsiTimController.clear();
          popUpActionTambahTimLayanan(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                'Buat tim layanan',
                style: greyTextStyle,
              )
            ],
          ),
        ),
      ),
      body: dataTim.toString() == "[]"
          ? Center(child: Txt(text: 'Belum ada tim ditambahkan'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
              itemCount: dataTim.length,
              itemBuilder: (context, index) => cardTimLayanan(index),
            ),
    );
  }

  Cntr cardTimLayanan(int index) {
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
              Row(
                children: [
                  Cntr(
                    color: Colors.transparent,
                    height: 40,
                    width: 40,
                    image: DecorationImage(
                        image: NetworkImage('${controller.serviceImage}'),
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: controller.serviceName.value,
                        weight: bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Txt(
                        text: dataTim[index]['hospital']['name'],
                        weight: light,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.timId.value = dataTim[index]["id"];
                      Get.defaultDialog(
                        title: "Apakah Anda yakin?",
                        middleText: 'Menghapus Paket Layanan ini',
                        confirm: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              await controller.deleteTimLayananHospital();
                              await controller.serviceHospital();
                              Get.back();
                              Get.back();
                              Get.to(() => TambahTimLayanan(
                                    dataTim: controller.listServiceHospital[
                                        controller.index.value]['team'],
                                  ));
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
                      controller.namaTimController.text =
                          dataTim[index]["name"];
                      controller.nomerHpTimController.text =
                          dataTim[index]["user"]['phoneNumber'];
                      controller.deskripsiTimController.text =
                          dataTim[index]["description"];
                      controller.timId.value = dataTim[index]["id"];
                      controller.isEditTim.value = true;
                      popUpActionTambahTimLayanan(Get.context!);
                      log(controller.timId.value.toString());
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
                  text: "${dataTim[index]["name"]}",
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
                  text: "${dataTim[index]["user"]['phoneNumber']}",
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 70,
            alignment: Alignment.topLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Txt(
              text: "${dataTim[index]["description"]}",
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Future<dynamic> popUpActionTambahTimLayanan(BuildContext context) {
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
                Obx(
                  () => Txt(
                    text: controller.isEditTim.isTrue
                        ? "Edit tim layanan"
                        : 'Buat tim layanan',
                    weight: bold,
                  ),
                ),
                InputPrimary(
                    hintText: "Masukkan nama tim",
                    onChange: (p0) {},
                    controller: controller.namaTimController,
                    onTap: () {}),
                InputPrimary(
                    keyboardType: TextInputType.number,
                    hintText: "No. handphone / akses login PIC",
                    onChange: (p0) {},
                    controller: controller.nomerHpTimController,
                    onTap: () {}),
                const SizedBox(
                  height: 10.0,
                ),
                Cntr(
                    radius: BorderRadius.circular(10),
                    width: Get.width,
                    height: 120,
                    color: AppColor.bgForm,
                    border: Border.all(color: Colors.grey[350]!),
                    child: TextFormField(
                      controller: controller.deskripsiTimController,
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Deskripsi tidak boleh kosong";
                        }
                      },
                      onTap: () async {},
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText:
                              "Deskripsi\n\nContoh : tersedia 1 Dokter umum, 1 perawat dan 1\nDokter spesialis",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () => ButtomGradient(
                      margin: 0,
                      label: controller.isloading.isTrue
                          ? "Loading.."
                          : controller.isEditTim.isTrue
                              ? "Edit Tim"
                              : 'Tambahkan',
                      onTap: () async {
                        if (controller.isloading.isFalse) {
                          if (controller.isEditTim.isTrue) {
                            await controller.updateTimLayananHospital();
                          } else {
                            await controller.tambahTimLayananHospital();
                          }
                          await controller.serviceHospital();
                          controller.namaTimController.clear();
                          controller.nomerHpTimController.clear();
                          controller.deskripsiTimController.clear();
                          Get.back();
                          Get.back();
                          Get.to(() => TambahTimLayanan(
                                dataTim: controller.listServiceHospital[
                                    controller.index.value]['team'],
                              ));
                        }
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
