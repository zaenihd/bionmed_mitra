import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/sukses.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_harga_paket_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_lengkapi_data.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            HeaderLengkapiDataHospital(
                imageUrl: 'assets/icon/icon_jadwal.png',
                title: 'Jadwal tim layanan',
                subtitle:
                    'Buat jadwal tim anda untuk setiap\nlayanan yang didaftarkan',
                stepper: 'assets/icon/stepper3.png'),
            const SizedBox(
              height: 30.0,
            ),
            Cntr(
              height: Get.height / 2.1,
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) => cardHargaPaketTimHospital(),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ButtomGradient(
          label: 'Submit',
          onTap: () {
            Get.to(()=>Sukses());
          },
        ),
      ),
    );
  }

  Cntr cardHargaPaketTimHospital() {
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
              Icon(
                Icons.people,
                size: 30,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Txt(
                text: 'Tim Home Visit Dokter 1',
                weight: bold,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          dataPaketlistName(title: 'Rumah sakit', data: 'RS Dedari Kupang'),
          const SizedBox(
            height: 12.0,
          ),
          dataPaketlistName(title: 'Layanan', data: 'Home Visit Dokter'),
          const SizedBox(
            height: 12.0,
          ),
          dataPaketlistName(title: 'No PIC Layanan', data: '0882 2871 8273'),
          const SizedBox(
            height: 12.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          ButtonPrimary(
            title: 'Buat Jadwal',
            onPressed: () {
              Get.to(() => EditJadwal());
            },
            backgroundColor: Color(0xffFFC93F),
            marginLeft: 0,
            marginRight: 0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xff50FF61),
                size: 15,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Txt(
                text: '1 Jadwal didaftarkan',
                size: 11,
                color: Colors.white,
              )
            ],
          )
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
