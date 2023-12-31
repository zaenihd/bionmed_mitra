import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KonfirmasiPinSaldo extends StatelessWidget {
  KonfirmasiPinSaldo({super.key});
  final controller = Get.put(PendapatanSaldoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/icon/icon_konfirmasi.png'),
              const SizedBox(
                height: 10.0,
              ),
              Txt(
                text: 'Konfirmasi PIN',
                size: 26,
                weight: bold,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Txt(text: 'Masukkan 6 Digit kode pin anda'),
              const SizedBox(
                height: 40.0,
              ),
              Cntr(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                  height: 60,
                  width: Get.width,
                  // border: Border.all(color: const Color(0xffC1C1C1)),
                  child: Obx(
                    () => TextFormField(
                      onChanged: (value) {},
                      controller: controller.kodePinKonformasiC,
                      obscureText: controller.isHiddenPinKonfirmasi.value,
                      keyboardType: TextInputType.none,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.isHiddenPinKonfirmasi.value =
                                    !controller.isHiddenPinKonfirmasi.value;
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: controller.isHiddenPinKonfirmasi.isTrue
                                    ? Colors.grey
                                    : Colors.blue,
                              )),
                          border: const OutlineInputBorder()),
                    ),
                  )
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                // height: 60,
                // width: Get.width,
                // border: Border.all(color: const Color(0xffC1C1C1)),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Obx(
                //       () => controller.isHiddenPinKonfirmasiKonfirmasi.isFalse
                //           ? Txt(
                //               text: controller.kodePinViewKonfirmasi.value,
                //               size: 26,
                //               weight: bold,
                //             )
                //           : Row(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                   for (var i = 0;
                //                       i < controller.kodePinKonfirmasi.length;
                //                       i++)
                //                     Txt(
                //                       text: '*',
                //                       weight: bold,
                //                       size: 40,
                //                     )
                //                 ]),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         controller.isHiddenPinKonfirmasi.value =
                //             !controller.isHiddenPinKonfirmasi.value;
                //       },
                //       child: Obx(
                //         () => Icon(
                //           Icons.remove_red_eye,
                //           color: controller.isHiddenPinKonfirmasi.isTrue
                //               ? Colors.grey
                //               : Colors.blue,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  // mainAxisExtent: 100
                ),
                itemCount: 12,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Cntr(
                      onTap: () {
                        print(index);
                        if (controller.kodePinKonfirmasi.value.length != 6) {
                          if (index == 10) {
                            controller.kodePinKonfirmasi.value.add(0);
                            controller.kodePinViewKonfirmasi.value =
                                controller.kodePinKonfirmasi.join("");
                                 controller.kodePinKonformasiC.text =
                                controller.kodePinViewKonfirmasi.value;
                          } else if (index == 11) {
                            controller.kodePinKonfirmasi.value.removeLast();
                            controller.kodePinViewKonfirmasi.value =
                                controller.kodePinKonfirmasi.join("");
                                controller.kodePinKonformasiC.text =
                                controller.kodePinViewKonfirmasi.value;
                          } else {
                            controller.kodePinKonfirmasi.value.add(index + 1);
                            controller.kodePinViewKonfirmasi.value =
                                controller.kodePinKonfirmasi.join("");
                            log(controller.kodePinViewKonfirmasi.value
                                .toString());
                                controller.kodePinKonformasiC.text =
                                controller.kodePinViewKonfirmasi.value;
                          }
                        } else {
                          if (index == 11) {
                            print(index);
                            controller.kodePinKonfirmasi.value.removeLast();
                            controller.kodePinViewKonfirmasi.value =
                                controller.kodePinKonfirmasi.join("");
                                controller.kodePinKonformasiC.text =
                                controller.kodePinViewKonfirmasi.value;
                          }
                        }
                      },
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      radius: BorderRadius.circular(100),
                      color: Colors.grey[300],
                      child: index == 11
                          ? const Icon(Icons.backspace_rounded)
                          : index == 9
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : index == 10
                                  ? Txt(
                                      text: '0',
                                      size: 26,
                                      weight: bold,
                                    )
                                  : Txt(
                                      text: '${index + 1}',
                                      size: 26,
                                      weight: bold,
                                    ));
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(() => ButtomGradient(
                  label: controller.isLoading.isTrue
                      ? "Loading..."
                      : 'Konfirmasi PIN',
                  onTap: () async {
                    if (controller.isLoading.isTrue) {
                    } else {
                      if (controller.kodePinView.value !=
                              controller.kodePinViewKonfirmasi.value ||
                          controller.kodePinViewKonfirmasi.value.length != 6) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          content: const Text('Pin tidak cocok!'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                            .showSnackBar(snackBar);
                      } else {
                        await controller.buatPin();
                        popUpBerhasilBuatKodePin(context);
                        Get.find<JadwalSayaController>().loginDataHospital(
                            phoneNumber: Get.find<LoginController>()
                                .phoneNumberUser
                                .value);
                        Get.find<JadwalSayaController>().getLocation();
                      }
                    }
                  })),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  popUpBerhasilBuatKodePin(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 400,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/icon/icon_selesai_profil.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          const Text(
                            'Terima kasih',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tidak dianjurkan kode PIN anda\ndiketahui kepada seseorang',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Oke",
                            onTap: () {
                              controller.kodePinView.value = '';
                              controller.kodePinViewKonfirmasi.value = '';
                              // Get.offAll(PendapatanView());
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ])
                  ]));
        });
  }
}
