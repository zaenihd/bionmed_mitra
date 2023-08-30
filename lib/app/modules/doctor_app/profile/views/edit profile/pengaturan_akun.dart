import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/layanan/controllers/layanan_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_layanan.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_pendidikan.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_pengalaman.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_profile.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_spesialis.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../jadwal_saya/controllers/jadwal_saya_controller.dart';

class PengaturanAkun extends StatelessWidget {
  PengaturanAkun({super.key});

  final loginC = Get.put(JadwalSayaController());
  final profilC = Get.put(ProfileController());
  final layananC = Get.put(LayananController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Pengaturan akun'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 26),
          child: Column(
            children: [
              EditProfileWidget(
                imageUrl: Image.asset('assets/icon/icon_edit_biodata.png'),
                title: 'Edit Biodata',
                subtitle: 'anda bisa mengubah informasi biodata di\nakun anda',
                onTap: () {
                  Get.to(() => const EditProfile());
                },
              ),
              Visibility(
                visible: Get.find<LoginController>().role.value != "nurse",
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    EditProfileWidget(
                      imageUrl:
                          Image.asset('assets/icon/icon_edit_spesialist.png'),
                      title: 'Edit Spesialist',
                      subtitle:
                          'anda bisa mengubah atau menambahkan\nspesialist untuk layanan',
                      onTap: () async {
                        final box = GetStorage();
                        var phone = await box.read('phone');
                        if (phone != null) {
                          await Get.put(JadwalSayaController())
                              .loginData(phoneNumber: phone);
                        }
                        if (loginC.spesialist.value == 1) {
                          profilC.selectedIndex.value = 0;
                        }
                        if (loginC.spesialist.value == 8) {
                          profilC.selectedIndex.value = 1;
                        }
                        if (loginC.spesialist.value == 9) {
                          profilC.selectedIndex.value = 2;
                        }
                        if (loginC.spesialist.value == 10) {
                          profilC.selectedIndex.value = 3;
                        }
                        if (loginC.spesialist.value == 11) {
                          profilC.selectedIndex.value = 4;
                        }
                        if (loginC.spesialist.value == 12) {
                          profilC.selectedIndex.value = 5;
                        }
                        //  profilC.selectedIndex.value = Get.put(JadwalSayaController()).spesialist.value;
                        //   print("Cek Cek" + Get.find<ProfileController>().selectedIndex.toString());
                        Get.to(() => const EditSpesialis());
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: Get.find<LoginController>().role.value != "nurse",
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    EditProfileWidget(
                      imageUrl:
                          Image.asset('assets/icon/icon_edit_layanan.png'),
                      title: 'Edit Layanan',
                      subtitle:
                          'Edit layanan anda untuk mempersonalisasi\ndengan mudah',
                      onTap: () async {
                        // var phone = await box.read('phone');
                        // if (phone != null) {
                        //   await Get.put(JadwalSayaController())
                        //       .loginData(phoneNumber: phone);
                        // }

                        // for (var i = 0; i < loginC.service.length; i++) {
                        //   layananC.tampunganLayanan.add(loginC.service[i]['id']);
                        // }

                        // print('CEK MASUK POL' + loginC.service.toString());
                        Get.to(() => const EditLayanan());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              EditProfileWidget(
                imageUrl: Image.asset('assets/icon/icon_edit_pengalaman.png'),
                title: 'Edit Pengalaman Praktek',
                subtitle:
                    'Buat pengalaman praktek Anda untuk lebih\nprofesional',
                onTap: () async {
                  if (Get.find<LoginController>().role.value == "nurse") {
                    await loginC.loginDataNurse(
                        phoneNumber:
                            Get.find<LoginController>().phoneNumberUser.value);
                  } else {
                    loginC.loginData(
                        phoneNumber:
                            Get.find<LoginController>().phoneNumberUser.value);
                  }
                  Get.to(() => const EditPengalaman());
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              EditProfileWidget(
                imageUrl: Image.asset('assets/icon/icon_edit_pendidikan.png'),
                title: 'Edit Pendidikan',
                subtitle: 'Ubah/Tambahkan pendidikan universitas\nAnda',
                onTap: () async {
                 if (Get.find<LoginController>().role.value == "nurse") {
                    await loginC.loginDataNurse(
                        phoneNumber:
                            Get.find<LoginController>().phoneNumberUser.value);
                  } else {
                    loginC.loginData(
                        phoneNumber:
                            Get.find<LoginController>().phoneNumberUser.value);
                  }
                  Get.to(() => EditPendidikan());
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditProfileWidget extends StatelessWidget {
  EditProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  Widget imageUrl;
  String title;
  String subtitle;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 11),
            ),
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageUrl,
            const SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                    width: Get.width / 1.7,
                    child: AutoSizeText(
                        maxLines: 2, subtitle, style: TextStyles.small1)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
