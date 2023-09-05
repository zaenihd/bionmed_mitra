import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        child: Column(children: [
          EditProfileWidget(
            imageUrl: Image.asset('assets/icon/pengaturan_icon.png'),
            title: 'Pemilik Rumah Sakit',
            subtitle: "Data pemilik rumah sakit",
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE_OWNER_HOSPITAL);
            },
          ),const SizedBox(
          height: 15.0,
          ),
          EditProfileWidget(
            imageUrl: Image.asset('assets/icon/pengaturan_icon1.png'),
            title: 'Data Rumah Sakit',
            subtitle: "Data Rumah sakit",
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE_HOSPITAL);

            },
          ),const SizedBox(
          height: 15.0,
          ),
          EditProfileWidget(
            imageUrl: Image.asset('assets/icon/pengaturan_icon2.png'),
            title: 'Tim Layanan',
            subtitle: "Data tim layanan rumah sakit",
            onTap: () {
            },
          ),const SizedBox(
          height: 15.0,
          ),
          EditProfileWidget(
            imageUrl: Image.asset('assets/icon/pengaturan_icon3.png'),
            title: 'Paket Tim Layanan',
            subtitle: "Data paket tim layanan rumah sakit",
            onTap: () {
            },
          ),const SizedBox(
          height: 15.0,
          ),
          EditProfileWidget(
            imageUrl: Image.asset('assets/icon/pengaturan_icon14.png'),
            title: 'Jadwal Tim Layanan',
            subtitle: "Data jadwal tim layanan rumah sakit",
            onTap: () {
            },
          ),
        ],),
      ),
    );
  }
}
