import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_harga_paket_hospital.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_jadwal_tim_hospital.dart';
import 'package:bionmed/app/modules/hospital_app/profile/pengaturan%20akun/tim_layanan_profile.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/views/paket_layanan_nurse_view.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../doctor_app/profile/views/edit profile/pengaturan_akun.dart';

class PengaturanAkunHospital extends StatelessWidget {
  const PengaturanAkunHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Pengaturan Akun'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Get.put(LoginController()).inHospital != "0"
                ? const SizedBox(
                    height: 1.0,
                  )
                : Column(
                    children: [
                      EditProfileWidget(
                        imageUrl:
                            Image.asset('assets/icon/pengaturan_icon.png'),
                        title: 'Pemilik Rumah Sakit',
                        subtitle: "Data pemilik rumah sakit",
                        onTap: () {
                          Get.toNamed(Routes.EDIT_PROFILE_OWNER_HOSPITAL);
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      EditProfileWidget(
                        imageUrl:
                            Image.asset('assets/icon/pengaturan_icon1.png'),
                        title: 'Data Rumah Sakit',
                        subtitle: "Data Rumah sakit",
                        onTap: () {
                          Get.toNamed(Routes.EDIT_PROFILE_HOSPITAL);
                        },
                      ),
                    ],
                  ),
            const SizedBox(
              height: 15.0,
            ),
            EditProfileWidget(
              imageUrl: Image.asset('assets/icon/pengaturan_icon2.png'),
              title: 'Tim Layanan',
              subtitle: "Data tim layanan rumah sakit",
              onTap: () async {
                Get.put(PaketLayananNurseController()).isHospital.value = true;
                if (Get.put(PaketLayananNurseController())
                    .isTimHospital
                    .isTrue) {
                      Get.to(()=>  TimLayananProfile());
                } else {
                  Get.toNamed(Routes.LENGKAPI_DATA_HOSPITAL);
                  Get.put(LengkapiDataHospitalController())
                      .isFromProfile
                      .value = true;
                  // Get.to(() => TambahHargaPaketHospital());
                  // Get.put(LengkapiDataHospitalController())
                  //     .isFromProfile
                  //     .value = true;
                  // await Get.put(LengkapiDataHospitalController())
                  //     .allTimHospital();
                }
                // TambahTimLayanan
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            EditProfileWidget(
              imageUrl: Image.asset('assets/icon/pengaturan_icon3.png'),
              title: 'Paket Tim Layanan',
              subtitle: "Data paket tim layanan rumah sakit",
              onTap: () async {
                Get.put(PaketLayananNurseController()).isHospital.value = true;
                if (Get.put(PaketLayananNurseController())
                    .isTimHospital
                    .isTrue) {
                  Get.put(PaketLayananNurseController()).idTimHospital.value =
                      Get.find<LoginController>().idLogin;
                  Get.put(PaketLayananNurseController()).serviceIdNurse.value =
                      Get.find<LoginController>().nurseServiceId.value;

                  Get.to(() => PaketLayananNurseView());
                } else {
                  Get.to(() => TambahHargaPaketHospital());
                  Get.put(LengkapiDataHospitalController())
                      .isFromProfile
                      .value = true;
                  await Get.put(LengkapiDataHospitalController())
                      .allTimHospital();
                }
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            EditProfileWidget(
              imageUrl: Image.asset('assets/icon/pengaturan_icon14.png'),
              title: 'Jadwal Tim Layanan',
              subtitle: "Data jadwal tim layanan rumah sakit",
              onTap: () async {
                Get.put(PaketLayananNurseController()).isHospital.value = true;
                if (Get.put(PaketLayananNurseController())
                    .isTimHospital
                    .isTrue) {
                  Get.put(PaketLayananNurseController()).isHospital.value =
                      true;
                  Get.put(PaketLayananNurseController()).idTimHospital.value =
                      Get.find<LoginController>().idLogin;
                  Get.put(PaketLayananNurseController()).serviceIdNurse.value =
                      Get.find<LoginController>().nurseServiceId.value;
                  Get.to(() => const EditJadwal());
                } else {
                  Get.to(() => const TambahJadwalTimHospital());
                  Get.put(LengkapiDataHospitalController())
                      .isFromProfile
                      .value = true;
                  await Get.put(LengkapiDataHospitalController())
                      .allTimHospital();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
