import 'package:bionmed/app/modules/doctor_app/home/views/home_view.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/views/layanan_home_view.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/pesan/views/pesan_view.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/profile_view.dart';
import 'package:bionmed/app/modules/hospital_app/pesan_hospital/views/pesan_hospital_view.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../pesan/controllers/pesan_controller.dart';
import '../controllers/bottom_navigation_controller.dart';

// ignore: must_be_immutable
class BottonNavigationView extends GetView<BottomNavigationController> {
  final myC = Get.put(BottomNavigationController());
  final loginC = Get.put(LoginController());
  final pesanC = Get.put(PesanController());

  Future<bool> showExitPopup() async {
    return await showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              title: const Text('Apakah anda yakin?'),
              content: const Text('Keluar dari Aplikasi?'),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),

                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Tidak'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Ya'),
                ),
              ],
            ),
          ) ?? false;

  }
  DateTime? currentBackPressTime;

   // ignore: unused_element
   Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
        ),
      );
      return false;
    }

    return true;
  }

  BottonNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(builder: (myC) {
      return Scaffold(
        body:
        WillPopScope(
          onWillPop: showExitPopup,
          child: Stack(
            children: [ IndexedStack(
          index: myC.onChange,
          children: [
            HomeView(),
            // ignore: prefer_const_constructors
            LayananHomeView(test: false),
            loginC.role.value == "hospital" ? const PesanHospitalView() :
            PesanView(),
            ProfileView()
          ],
        ),])),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: myC.onChange,
            unselectedItemColor: greyColor,
            selectedItemColor: blueColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: myC.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(const Icon(Icons.home_filled), "Beranda"),
              _bottomNavigationBarItem(const Icon(Icons.article_sharp), "Layanan"),
              _bottomNavigationBarItem( 
                Obx(()=>
                // ignore: unrelated_type_equality_checks
                Get.find<PesanController>().activeNotif == 0 ? 
                      const Icon(Icons.mail) : 
                  Stack(
                    children: [
                      const Icon(Icons.mail),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Container(padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                          ),
                          color: Colors.red),
                          child: Text('${Get.find<PesanController>().activeNotif}', style: const TextStyle(fontSize: 8, color: Colors.white,),),)
                      )
                    ],
                  )),
                  "Pesan"),
              _bottomNavigationBarItem(const Icon(Icons.person), "Profil"),
            ]),
      );
    });
  }
}

_bottomNavigationBarItem(Widget icon, String label) {
  return BottomNavigationBarItem(icon: icon, label: label);
}
