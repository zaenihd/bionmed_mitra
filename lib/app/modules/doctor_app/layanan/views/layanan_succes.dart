import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/layanan_controller.dart';
import 'layanan_proses.dart';

class LayananSucces extends GetView<LayananController> {
  const LayananSucces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ButtomGradient(
          label: "Mulai",
          onTap: () {
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
      ),
      body: ProsesWidget(
          imageUrl: 'assets/berhasil.png',
          title: 'Berhasil',
          subtitle:
              'anda telah berhasil melakukan registrasi akun\nuntuk menggunakan BOINMED.'),
    );
  }
}
