import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/verifikasi_view.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/pendapatan_saldo_controller/pendapatan_saldo_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuatKodeAkses extends StatelessWidget {
  BuatKodeAkses({super.key});
  final controller = Get.put(PendapatanSaldoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Cntr(
        margin: const EdgeInsets.only(bottom: 20),
        child: ButtomGradient(
            label: 'Lanjutkan',
            onTap: () async {
              if (controller.nomerPhoneCodeAksesC.text == "") {
                showPopUp(
                    onTap: () {
                      Get.back();
                    },
                    imageAction: 'assets/json/eror.json',
                    description: "Mohon isi nomer Handphone");
              } else {
                // Get.to(() => BuatPinSaldo());
                await Get.find<LoginController>().sendOtp();
                Get.to(() => VerifikasiView());
              }
            }),
      ),
      appBar: appbarGradient('Buat kode akases'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(text: 'No. Handphone'),
            InputPrimary(
                hintText: "Masukkan no handphone",
                onChange: (p0) {},
                controller: controller.nomerPhoneCodeAksesC,
                onTap: () {})
          ],
        ),
      ),
    );
  }
}
