import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuksesKirimResep extends StatelessWidget {
  const SuksesKirimResep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Berhasil Mengupload', style: blackTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 20),),
          const SizedBox(
          height: 10.0,
          ),
          Text('Terima Kasih', style: blackTextStyle.copyWith(fontWeight: FontWeight.w400,),),
          const SizedBox(
          height: 20.0,
          ),
          Image.asset('assets/images/berhasil.png')
        ],),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ButtomGradient(
            label: "Selesai",
            onTap: () {
              Get.back();
              Get.back();
              Get.offNamed(Routes.BOTTOM_NAVIGATION);
              // Get.to(SuksesKirimResep());
              // pickerFilesImage(context);
            }),
      ),
    );
  }
}