import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:get/get.dart';

class ProfilLoginRequired extends StatelessWidget {
  const ProfilLoginRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(title: Txt(text: 'text'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Txt(text: 'Mohon untuk melakukan login terlebih dahulu'),
            Cntr(
              height: 300,
              width: 300,
              image: const DecorationImage(
                  image: AssetImage('assets/images/loginFirst.png')),
            ),
            const SizedBox(
            height: 20.0,
            ),
            ButtomGradient(label: 'Login Sekarang', onTap: (){
              Get.toNamed(Routes.ACCOUNT);
            }),
            // const SizedBox(
            // height: 10.0,
            // ),
            // ButtonPrimary(title: 'Nanti Saja', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
