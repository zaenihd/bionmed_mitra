
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/introduction_screen_model.dart';
// import 'package:get/state_manager.dart';
// import 'package:get/utils.dart';

class IntroductionScreenController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage =>
      selectedPageIndex.value == onboardingScreens.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      // ignore: curly_braces_in_flow_control_structures
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnboardingModel> onboardingScreens = [
    OnboardingModel('assets/images/img-splash1.jpg', 'Mudah Berkonsultasi',
        'Konsultasi kesehatan  bersama BionMed Dengan layanan Chat,  voice call dan video call dengan dokter umum dan dokter spesialis'),
    OnboardingModel('assets/images/img-splash2.jpg', 'Buat Jadwal anda',
        'Dokter bisa mengatur sendiri jadwal praktek on line, nilai jasa layanan dokter bahkan bisa memberikan diskon kepada pasien dokter. Kenyamanan dokter adalah prioritas utama kami sehingga bisa membantu pasien secara maksimal'),
    OnboardingModel('assets/images/img-splash3.jpg', 'Sehat Dengan BIONMED',
        'Mulailah hari bersama BionMed dengan layanan layanan yang dapat memudahkan dalam menjaga dan memelihara kesehatan')
  ];
}
