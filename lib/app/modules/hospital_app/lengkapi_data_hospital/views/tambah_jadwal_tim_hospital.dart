import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/sukses.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_lengkapi_data.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import '../controllers/lengkapi_data_hospital_controller.dart';

class TambahJadwalTimHospital extends GetView<LengkapiDataHospitalController> {
  const TambahJadwalTimHospital({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: controller.isFromProfile.isFalse,
              child: HeaderLengkapiDataHospital(
                  imageUrl: 'assets/icon/icon_jadwal.png',
                  title: 'Jadwal tim layanan',
                  subtitle:
                      'Buat jadwal tim anda untuk setiap\nlayanan yang didaftarkan',
                  stepper: 'assets/icon/stepper3.png'),
            ),
            const SizedBox(
              height: 30.0,
            ),
        Obx(()=>
            controller.isloading.isTrue ? loadingIndicator() :
            Cntr(
              height:controller.isFromProfile.isFalse? Get.height / 2.1 : Get.height/1.2,
              child: ListView.builder(
                itemCount: controller.listAllTimHospital.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    cardHargaPaketTimHospital(index),
              ),
            ))
          ],
        ),
      ),
      bottomSheet: Visibility(
        visible: controller.isFromProfile.isFalse,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ButtomGradient(
            label: 'Submit',
            onTap: () {
              Get.to(() => const Sukses());
            },
          ),
        ),
      ),
    );
  }

  Cntr cardHargaPaketTimHospital(int index) {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      radius: BorderRadius.circular(10),
      width: Get.width,
      gradient: gradient1,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
          dataPaketlistName(
              title: 'Rumah sakit',
              data:
                  '${controller.listAllTimHospital[index]['team']['hospital']['name']}'),
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
            title: 'Buat Jadwal',
            onPressed: () {
              Get.put(PaketLayananNurseController()).idTimHospital.value =
                  controller.listAllTimHospital[index]['team']['id'];
              Get.put(JadwalSayaController()).serviceId.value =
                  controller.listAllTimHospital[index]['team']['nurse_services']
                      [0]['serviceId'];
              Get.to(() => const EditJadwal());
            },
            backgroundColor: const Color(0xffFFC93F),
            marginLeft: 0,
            marginRight: 0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.check_circle,
          //       color: Color(0xff50FF61),
          //       size: 15,
          //     ),
          //     const SizedBox(
          //       width: 5.0,
          //     ),
          //     Txt(
          //       text: '1 Jadwal didaftarkan',
          //       size: 11,
          //       color: Colors.white,
          //     )
          //   ],
          // )
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
