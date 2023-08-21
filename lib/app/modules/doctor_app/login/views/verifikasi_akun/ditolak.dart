import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Ditolak extends StatelessWidget {
  const Ditolak({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 50,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 30),
        child: ButtomGradient(label: 'Daftar ulang', onTap: (){
          Get.offAllNamed(Routes.LOGIN);
        })),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/ditolak.png'),
          const SizedBox(
            height: 50.0,
          ),
          Txt(
            text: 'Ditolak',
            size: 24,
            weight: bold,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Txt(
            text:
                'Mohon maaf, anda belum bisa melanjutkan pendaftaran, silahkan coba lagi',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      
    );
  }
}
