import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/list_jadwal.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../perawat_app/list_service_nurse/controllers/list_service_nurse_controller.dart';
import '../controllers/lengkapi_profil_controller.dart';

class LengkapiTepatPraktek extends GetView<LengkapiProfilController> {
  const LengkapiTepatPraktek({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset('assets/icon/icon_praktek.png'),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Tempat Praktek',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              'Informasikan tempat praktek anda ',
              style: subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Image.asset('assets/icon/stepper2.png'),
            const SizedBox(
              height: 23.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Masukkan Tempat Praktek',
                  textAlign: TextAlign.left,
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
                InkWell(
                  onTap: () {
                    if (controller.pengalamanC.value.text.isEmpty) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Mohon isi tempat praktek'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      controller.listPengalaman.add(
                          {'experience': controller.pengalamanC.value.text});
                      controller.pengalamanC.clear();
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
            InputPrimary(
              onChange: (p0) {},
              controller: controller.pengalamanC,
              onTap: () {},
              hintText: 'Masukkan tempat praktek anda',
            ),
            SizedBox(
              height: 300.0,
              child: Obx(() => ListView.builder(
                    itemCount: controller.listPengalaman.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: buttonColor!),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${controller.listPengalaman[index]['experience']}',
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: medium),
                          ),
                          InkWell(
                            onTap: () {
                              controller.listPengalaman.removeAt(index);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ]),
        )),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Obx(() => ButtomGradient(
              label: controller.isloading.isFalse ? 'Lanjutkan' : "Loading...",
              onTap: () async {
                if (controller.isloading.isFalse) {
                  if (controller.listPengalaman.isEmpty) {
                    if (controller.pengalamanC.value.text == "") {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Mohon isi data Pengalaman'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      controller.listPengalaman.add(
                          {"experience": controller.pengalamanC.value.text});
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        controller.tambahPengalaman(
                            experience: controller.listPengalaman);
                      }
                      {
                        controller.tambahPengalamanNurse(
                            experience: controller.listPengalaman);
                      }
                      // controller.tambahPengalaman(
                      //     experience: controller.listPengalaman);
                      controller.pengalamanC.clear();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Berhasil di simpan'),
                        backgroundColor: (Colors.green),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Get.to(() => LengkapiListJadwal());
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        Get.to(() => LengkapiListJadwal());
                      } else {
                        Get.put(ListServiceNurseController())
                            .listServiceNurse();

                        Get.toNamed(Routes.LIST_SERVICE_NURSE);
                      }
                    }
                  } else {
                    if (controller.pengalamanC.value.text == "" &&
                        controller.listPengalaman.isEmpty) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Mohon isi data Pengalaman'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (controller.pengalamanC.value.text == "") {
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        Get.to(() => LengkapiListJadwal());
                      } else {
                        Get.put(ListServiceNurseController())
                            .listServiceNurse();

                        Get.toNamed(Routes.LIST_SERVICE_NURSE);
                      }
                      // Get.to(() => LengkapiListJadwal());
                    } else {
                      controller.listPengalaman.add(
                          {"experience": controller.pengalamanC.value.text});
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        controller.tambahPengalaman(
                            experience: controller.listPengalaman);
                      }
                      {
                        controller.tambahPengalamanNurse(
                            experience: controller.listPengalaman);
                      }
                      // controller.tambahPengalaman(
                      //     experience: controller.listPengalaman);
                      controller.pengalamanC.clear();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Berhasil di simpan'),
                        backgroundColor: (Colors.green),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        Get.to(() => LengkapiListJadwal());
                      } else {
                        Get.put(ListServiceNurseController())
                            .listServiceNurse();

                        Get.toNamed(Routes.LIST_SERVICE_NURSE);
                      }
                    }
                    if (Get.find<LoginController>().role.value == 'doctor') {
                      await controller.tambahPengalaman(
                          experience: controller.listPengalaman);
                    }
                    {
                      await controller.tambahPengalamanNurse(
                          experience: controller.listPengalaman);
                    }
                  }
                }
              }))),
    );
  }
}
