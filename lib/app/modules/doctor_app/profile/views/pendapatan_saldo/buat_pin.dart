import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/konfirmasi_pin.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class BuatPinSaldo extends StatelessWidget {
  BuatPinSaldo({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                height: 60,
                width: Get.width,
                border: Border.all(color: Color(0xffC1C1C1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => controller.isHiddenPin.isFalse
                          ? Txt(
                              text: controller.kodePinView.value,
                              size: 26,
                              weight: bold,
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  for (var i = 0;
                                      i < controller.kodePin.length;
                                      i++)
                                    Txt(
                                      text: '*',
                                      weight: bold,
                                      size: 40,
                                    )
                                ]),
                    ),
                    InkWell(
                      onTap: () {
                        controller.isHiddenPin.value =
                            !controller.isHiddenPin.value;
                      },
                      child:
                      Obx(()=> Icon(
                        Icons.remove_red_eye,
                        color:controller.isHiddenPin.isTrue ?  Colors.grey : Colors.blue,
                      ),),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  // mainAxisExtent: 100
                ),
                itemCount: 12,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Cntr(
                      onTap: () {
                        if (controller.kodePin.length != 6) {
                          if (index == 10) {
                            controller.kodePin.value.add(0);
                            controller.kodePinView.value =
                                controller.kodePin.join("");
                          } else if (index == 11) {
                            print(index);
                            controller.kodePin.value.removeLast();
                            controller.kodePinView.value =
                                controller.kodePin.join("");
                          } else {
                            controller.kodePin.value.add(index + 1);
                            controller.kodePinView.value =
                                controller.kodePin.join("");
                            log(controller.kodePin.length.toString());
                          }
                        } else {
                          if (index == 11) {
                            print(index);
                            controller.kodePin.value.removeLast();
                            controller.kodePinView.value =
                                controller.kodePin.join("");
                          }
                        }
                      },
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      radius: BorderRadius.circular(100),
                      color: Colors.grey[300],
                      child: index == 11
                          ? Icon(Icons.backspace_rounded)
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
                  label: 'Simpan',
                  onTap: () {
                    Get.to(() => KonfirmasiPinSaldo());
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
