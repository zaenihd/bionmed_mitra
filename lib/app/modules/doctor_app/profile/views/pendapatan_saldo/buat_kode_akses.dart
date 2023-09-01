import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/input_verifikasi_kode.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class BuatKodeAkses extends StatelessWidget {
  const BuatKodeAkses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: TextEditingController(),
                onTap: () {
                  Get.to(()=> InputVerifikasiKode());
                })
          ],
        ),
      ),
    );
  }
}


