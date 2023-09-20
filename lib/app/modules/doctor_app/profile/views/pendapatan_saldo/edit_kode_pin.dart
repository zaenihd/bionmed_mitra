import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/kode_pin_akses_edit.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditKodeAkses extends StatelessWidget {
  EditKodeAkses({super.key});
  final controller = Get.put(PendapatanSaldoController());
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Cntr(
        height: 110,
        margin: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ButtomGradient(
                  label: 'Ubah Kode PIN',
                  onTap: () {
                    final formState = formKey.currentState!.validate();
                    if (formState) {
                      if (Get.find<JadwalSayaController>().codeAccess.value !=
                          controller.kodePinKonfirmasiEditC.text) {
                        showPopUp(
                            onTap: () {
                              Get.back();
                            },
                            imageAction: 'assets/json/eror.json',
                            description: "PIN Salah");
                      } else {
                        Get.to(() => KodePinAksesEdit());
                      }
                    }
                    // if (controller.kodePinEditC.text !=
                    //     controller.kodePinKonfirmasiEditC.text) {
                    //   showPopUp(
                    //       onTap: () {
                    //         Get.back();
                    //       },
                    //       imageAction: 'assets/json/eror.json',
                    //       description: "PIN tidak cocok");
                    // } else {
                    // }
                  }),
              const SizedBox(
                height: 10.0,
              ),
              ButtonPrimary(title: 'Lupa PIN?', onPressed: () {})
            ],
          ),
        ),
      ),
      appBar: appbarGradient('Akses PIN'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(text: 'Kode PIN'),
            Obx(()=>
            InputPrimary(
              keyboardType: TextInputType.number,

              suffixIcon: InkWell(
                onTap: () {
                  controller.isHiddenPinAkses.value = !controller.isHiddenPinAkses.value;
                },
                child: const Icon(Icons.lock)),
              obsecureText: controller.isHiddenPinAkses.value,
                hintText: "********",
                onChange: (p0) {},
                controller: controller.kodePinEditC,
                onTap: () {}),),
            const SizedBox(
              height: 20.0,
            ),
            Txt(text: 'Konfirmasi PIN'),
            Obx(()=>
            InputPrimary(
              keyboardType: TextInputType.number,
                validate: (value) {
                  if (value.toString() != controller.kodePinEditC.text) {
                    return "PIN tidak cocok";
                  } else if (value.toString().isNotEmpty) {
                    return null;
                  }
                  {
                    return "PIN tidak cocok";
                  }
                },
                 suffixIcon: InkWell(
                onTap: () {
                  controller.isHiddenPinAkses.value = !controller.isHiddenPinAkses.value;
                },
                child: const Icon(Icons.lock)),
              obsecureText: controller.isHiddenPinAkses.value,
                hintText: "********",
                onChange: (p0) {},
                controller: controller.kodePinKonfirmasiEditC,
                onTap: () {}),),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
