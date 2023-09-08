import 'dart:developer';

import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_harga_paket_hospital.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_jadwal_tim_hospital.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme.dart';

class ListServiceTimLayanan extends StatelessWidget {
  ListServiceTimLayanan({super.key});
  final controller = Get.find<LengkapiDataHospitalController>();
  final paketLayananNurseController = Get.put(PaketLayananNurseController());

  @override
  Widget build(BuildContext context) {
    controller.listServiceHospital.value = controller.listServiceHospital
        .where(
          (p0) => p0['team'].length != 0,
        )
        .toList();
    log("filter :${controller.listServiceHospital.where(
          (p0) => p0['team'].length != 0,
        ).toList()}");
    return Scaffold(
      appBar: appbarBack(),
      body: ListView.builder(
        itemCount: controller.listServiceHospital.length,
        itemBuilder: (context, index) => Cntr(
          onTap: () async {
            log('xxxx ${controller.isJadwal.value.toString()}');
            if (controller.listServiceHospital[index]['service']['name'] ==
                "Mother Care") {
              if (controller.isFromProfile.isTrue) {
                await controller.allTimHospital();
                controller.listAllTimHospital.value = controller
                    .listAllTimHospital
                    .where((p0) => p0['service']['name'] == "Mother Care")
                    .toList();
                if (controller.isJadwal.isTrue) {
                  Get.to(() => const TambahJadwalTimHospital());
                } else {
                  Get.to(() => TambahHargaPaketHospital());
                }
              }
            } else {
              if (controller.isFromProfile.isTrue) {
                await controller.allTimHospital();
                controller.listAllTimHospital.value = controller
                    .listAllTimHospital
                    .where((p0) => p0['service']['name'] == "Baby Care")
                    .toList();
                if (Get.put(LengkapiDataHospitalController()).isJadwal.value ==
                    true) {
                  Get.to(() => const TambahJadwalTimHospital());
                } else {
                  Get.to(() => TambahHargaPaketHospital());
                }
              }
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
          margin: const EdgeInsets.only(bottom: 10, left: 24, right: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Cntr(
                  onTap: () async {},
                  // color: Colors.grey,
                  height: 40,
                  width: 40,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${controller.listServiceHospital[index]['service']['image']}'),
                      fit: BoxFit.cover),
                ),
                // Image.network('${controller.listServiceHospital[index]['service']['image']}'),
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
                      text: 'Buat tim layanan',
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
    );
  }
}
