import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/buat_pin.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KodePinAksesEdit extends StatelessWidget {
  KodePinAksesEdit({super.key});

  final controller = Get.put(PendapatanSaldoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/icon/icon_pin.png'),
              const SizedBox(
                height: 10.0,
              ),
              Txt(
                text: 'Kode PIN',
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
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  height: 60,
                  width: Get.width,
                  // border: Border.all(color: const Color(0xffC1C1C1)),
                  child: Obx(
                    () => TextFormField(
                      onChanged: (value) {},
                      controller: controller.kodePinAksesC,
                      obscureText: controller.isHiddenPinAksesCheck.value,
                      keyboardType: TextInputType.none,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.isHiddenPinAksesCheck.value =
                                    !controller.isHiddenPinAksesCheck.value;
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: controller.isHiddenPinAksesCheck.isTrue
                                    ? Colors.grey
                                    : Colors.blue,
                              )),
                          border: const OutlineInputBorder()),
                    ),
                  )

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [

                  //     // Obx(
                  //     //   () => controller.isHiddenPinAksesCheck.isTrue
                  //     //       ? Txt(
                  //     //           text: controller.kodePinViewAkses.value,
                  //     //           size: 26,
                  //     //           weight: bold,
                  //     //         )
                  //     //       : Row(
                  //     //           crossAxisAlignment: CrossAxisAlignment.center,
                  //     //           children: [
                  //     //               for (var i = 0;
                  //     //                   i < controller.kodePinAkses.length;
                  //     //                   i++)
                  //     //                 Txt(
                  //     //                   text: '*',
                  //     //                   weight: bold,
                  //     //                   size: 40,
                  //     //                 )
                  //     //             ]),
                  //     // ),
                  //     InkWell(
                  //       onTap: () {
                  //         controller.isHiddenPinAksesCheck.value =
                  //             !controller.isHiddenPinAksesCheck.value;
                  //       },
                  //       child: Obx(
                  //         () => Icon(
                  //           Icons.remove_red_eye,
                  //           color: controller.isHiddenPinAksesCheck.isTrue
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
                        // controller.isHiddenPinAksesCheck.value = true;
                        if (controller.kodePinAkses.length != 6) {
                          if (index == 10) {
                            controller.kodePinAkses.value.add(0);
                            controller.kodePinViewAkses.value =
                                controller.kodePinAkses.join("");
                                controller.kodePinAksesC.text =
                                controller.kodePinViewAkses.value;
                          } else if (index == 11) {
                            print(index);
                            controller.kodePinAkses.value.removeLast();
                            controller.kodePinViewAkses.value =
                                controller.kodePinAkses.join("");
                            controller.kodePinAksesC.text =
                                controller.kodePinViewAkses.value;
                          } else {
                            log("sasas${controller.kodePinAksesC.text}");
                            controller.kodePinAkses.value.add(index + 1);
                            controller.kodePinViewAkses.value =
                                controller.kodePinAkses.join("");
                            log(controller.kodePinAkses.length.toString());
                            controller.kodePinAksesC.text =
                                controller.kodePinViewAkses.value;
                          }
                        } else {
                          if (index == 11) {
                            print(index);
                            controller.kodePinAkses.value.removeLast();
                            controller.kodePinViewAkses.value =
                                controller.kodePinAkses.join("");
                            controller.kodePinAksesC.text =
                                controller.kodePinViewAkses.value;
                          }
                        }
                        log(controller.kodePinViewAkses.value.toString());
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
              ButtomGradient(
                  label: 'Submit',
                  onTap: () async {
                    if (controller.kodePinAkses.length != 6) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 24),
                        content: const Text('Masukkan 6 Digit Pin!'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
                    } else {
                      if (Get.find<JadwalSayaController>().codeAccess.value ==
                          controller.kodePinViewAkses.value) {
                        controller.kodePinViewAkses.value = "";
                        Get.to(() => BuatPinSaldo());
                        // controller.isWithDraw.value = false;
                      } else {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          content: const Text('PIN tidak cocok'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                            .showSnackBar(snackBar);
                      }
                    }
                  }),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
