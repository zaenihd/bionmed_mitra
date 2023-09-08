
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/profile/pengaturan%20akun/list_service_tim_layanan.dart';
import 'package:bionmed/app/modules/hospital_app/profile/pengaturan%20akun/tim_layanan_profile.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/views/paket_layanan_nurse_view.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../doctor_app/profile/views/edit profile/pengaturan_akun.dart';

class PengaturanAkunHospital extends StatelessWidget {
  PengaturanAkunHospital({super.key});

  final controller = Get.put(LengkapiDataHospitalController());
  final paketLayananNurseController = Get.put(PaketLayananNurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Pengaturan Akun'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Get.put(LoginController()).inHospital.value == ''
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
                paketLayananNurseController.isHospital.value = true;
                if (paketLayananNurseController.isTimHospital.isTrue) {
                  Get.to(() => TimLayananProfile());
                } else {
                  await controller.serviceHospital();

                  Get.toNamed(Routes.LENGKAPI_DATA_HOSPITAL);

                  controller.isFromProfile.value = true;

                  // Get.to(() =>  ListServiceTimLayanan());
                  // controller
                  //     .isFromProfile
                  //     .value = true;
                  // await controller
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
                paketLayananNurseController.isHospital.value = true;
                if (paketLayananNurseController.isTimHospital.isTrue) {
                  paketLayananNurseController.idTimHospital.value =
                      Get.find<LoginController>().idLogin;
                  paketLayananNurseController.serviceIdNurse.value =
                      Get.find<LoginController>().nurseServiceId.value;

                  Get.to(() => PaketLayananNurseView());
                } else {
                  // Get.to(() => TambahHargaPaketHospital());
                  controller.isJadwal.value = false;

                  controller.isFromProfile.value = true;
                  await controller.serviceHospital();
                  Get.to(() => ListServiceTimLayanan());
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
                paketLayananNurseController.isHospital.value = true;
                if (paketLayananNurseController.isTimHospital.isTrue) {
                  paketLayananNurseController.isHospital.value = true;
                  paketLayananNurseController.idTimHospital.value =
                      Get.find<LoginController>().idLogin;
                  paketLayananNurseController.serviceIdNurse.value =
                      Get.find<LoginController>().nurseServiceId.value;
                  Get.to(() => const EditJadwal());
                } else {
                  controller.isFromProfile.value = true;
                  controller.isJadwal.value = true;
                  //  controller.isFromProfile.value = true;
                  await controller.serviceHospital();
                  // log('xxxx ${ controller.isJadwal.value.toString()}');

                  Get.to(() => ListServiceTimLayanan());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
