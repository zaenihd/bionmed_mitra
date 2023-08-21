import 'package:bionmed/app/modules/doctor_app/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sukses extends StatelessWidget {
  const Sukses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon/icon_selesai_profil.png'),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Terima kasih',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              'Terima kasih telah melengkapi data praktek anda, mulai sekarang untuk melayani pasien',
              style: subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ButtomGradient(
            label: 'Selesai',
            onTap: () async {
              if (Get.put(LoginController().role.value == 'nurse')) {
                Get.put(LengkapiProfilController())
                    .updateProfilNurseVerifikasi();
              }
              // GetStorage().write("popUp", true);

              // Get.find<LoginController>().loginV2(
              //     phoneNumber:
              //         Get.find<LoginController>().controllerPhone.text);
              Get.to(() => BottonNavigationView());
              // Get.back();
              // Get.back();
              // Get.back();
              // Get.back();
            }),
      ),
    );
  }
}
