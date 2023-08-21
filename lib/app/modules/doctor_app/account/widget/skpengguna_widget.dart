import 'package:bionmed/app/modules/doctor_app/account/widget/syarat_ketentuan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme.dart';

class SkPengguna extends StatelessWidget {
  const SkPengguna({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Dengan masuk atau mendaftar'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Get.find<AccountController>().ketentuanPengguna();
                Get.to(()=> SyaratDanKetentuan());

              },
              child: Text(
                'Syarat',
                style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
              ),
            ),
            const Text(' dan '),
            InkWell(
              onTap: () {
                Get.to(()=> SyaratDanKetentuan());
                // Get.find<AccountController>().ketentuanPengguna();

                          // Get.find<AccountController>().kebijakanPrivasi();
                
              },
              child: Text(
                'Ketentuan Pengguna Mitra BionMed',
                style: blueTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }
}