import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/lengkapi_tempat_praktek.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../../../../widget/appbar/appbar_back.dart';
import '../../../../widget/textform/input_primary1.dart';
import '../controllers/lengkapi_profil_controller.dart';

class LengkapiProfilView extends GetView<LengkapiProfilController> {
  const LengkapiProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icon/icon_pendidikan.png'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Pendidikan Profesi',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    'Masukkan daftar riwayat pendidikan anda untuk\nmelengkapi profil anda',
                    style: subtitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 13.0,
                  ),
                  Image.asset('assets/icon/steper1.png'),
                  const SizedBox(
                    height: 23.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Instansi Anda',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.pendidikan.value.text.isEmpty ||
                              controller.tahunMasuk.value.text.isEmpty ||
                              controller.tahunLulus.value.text.isEmpty) {
                            final snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              content:
                                  const Text('Mohon isi semua data pendidikan'),
                              backgroundColor: (Colors.red),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {},
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            controller.listPendidikan.add({
                              "education": controller.pendidikan.value.text,
                              "year":
                                  "${controller.tahunMasuk.value.text} - ${controller.tahunLulus.value.text}",
                              // "lulus": controller.tahunLulus.value.text
                            });
                            controller.pendidikan.clear();
                            controller.tahunLulus.clear();
                            controller.tahunMasuk.clear();
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
                    height: 16.0,
                  ),

                  //Form
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Pendidikan Profesi',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputPrimary(
                    onChange: (p0) {},
                    controller: controller.pendidikan,
                    onTap: () {},
                    hintText: 'Nama Instansi',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width / 2.3,
                        child: InputPrimary(
                          keyboardType: TextInputType.number,
                          onChange: (p0) {},
                          controller: controller.tahunMasuk,
                          onTap: () {},
                          hintText: 'Masuk',
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: Get.width / 2.4,
                        child: InputPrimary(
                          keyboardType: TextInputType.number,
                          onChange: (p0) {},
                          controller: controller.tahunLulus,
                          onTap: () {},
                          hintText: 'Lulus',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300.0,
                    child: Obx(() => ListView.builder(
                          itemCount: controller.listPendidikan.length,
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
                                  controller.listPendidikan[index]['education'],
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: normal),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Tahun ${controller.listPendidikan[index]['year']}',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14, fontWeight: normal)),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.listPendidikan
                                            .removeAt(index);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child:Obx(()=> ButtomGradient(
                label:
                    controller.isloading.isFalse ? 'Lanjutkan' : "Loading...",
                onTap: () async {
                  if (controller.isloading.isFalse) {
                    if (controller.listPendidikan.isEmpty) {
                      if (controller.pendidikan.value.text == "" ||
                          controller.tahunLulus.value.text == "" ||
                          controller.tahunMasuk.value.text == "") {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 24),
                          content:
                              const Text('Mohon isi semua data pendidikan'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        controller.listPendidikan.add({
                          "education": controller.pendidikan.value.text,
                          "year":
                              "${controller.tahunMasuk.value.text} - ${controller.tahunLulus.value.text}",
                        });
                         if (Get.find<LoginController>().role.value == 'doctor') {
                        await controller.tambahPendidikan(
                            education: controller.listPendidikan);
                      }else{
                        await controller.tambahPendidikanNurse(
                            education: controller.listPendidikan);
                      }
                        // await controller.tambahPendidikan(
                        //     education: controller.listPendidikan);
                        controller.pendidikan.clear();
                        controller.tahunLulus.clear();
                        controller.tahunMasuk.clear();
                        Get.to(() => const LengkapiTepatPraktek());
                      }
                    } else {
                      if (controller.listPendidikan.isNotEmpty) {
                        if (controller.pendidikan.value.text == "" &&
                                controller.listPendidikan.isEmpty ||
                            controller.tahunLulus.value.text == "" &&
                                controller.listPendidikan.isEmpty ||
                            controller.tahunMasuk.value.text == "" &&
                                controller.listPendidikan.isEmpty) {
                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 24),
                            content:
                                const Text('Mohon isi semua data pendidikan'),
                            backgroundColor: (Colors.red),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (controller.pendidikan.value.text == "" ||
                            controller.tahunLulus.value.text == "" ||
                            controller.tahunMasuk.value.text == "") {
                          Get.to(() => const LengkapiTepatPraktek());
                        } else {
                          controller.listPendidikan.add({
                            "education": controller.pendidikan.value.text,
                            "year":
                                "${controller.tahunMasuk.value.text} - ${controller.tahunLulus.value.text}",
                          });
                          if (Get.find<LoginController>().role.value ==
                              'doctor') {
                            await controller.tambahPendidikan(
                                education: controller.listPendidikan);
                          } else {
                            await controller.tambahPendidikanNurse(
                                education: controller.listPendidikan);
                          }
                          // await controller.tambahPendidikan(
                          //     education: controller.listPendidikan);
                          controller.pendidikan.clear();
                          controller.tahunLulus.clear();
                          controller.tahunMasuk.clear();
                          Get.to(() => const LengkapiTepatPraktek());
                        }
                      }
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        await controller.tambahPendidikan(
                            education: controller.listPendidikan);
                      } else {
                        await controller.tambahPendidikanNurse(
                            education: controller.listPendidikan);
                      }
                    }

                    //  await controller.tambahPendidikan(
                    //       education: controller.listPendidikan);
                  }
                }))));
  }
}
