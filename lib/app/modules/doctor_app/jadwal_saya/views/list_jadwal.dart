import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/sukses.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/modules/perawat_app/list_service_nurse/controllers/list_service_nurse_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListJadwal extends StatelessWidget {
  final myC = Get.put(JadwalSayaController());
  final loginC = Get.put(LoginController());
  final listServiceC = Get.put(ListServiceNurseController());

  ListJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    if (loginC.role.value == 'nurse') {
      // listServiceC.listServiceNurse();
    }
    // myC.listService();
    return Scaffold(
        appBar: appbarGradient('Jadwal Layanan'),
        body: ListView.builder(
          itemCount: loginC.role.value == 'nurse' && loginC.inHospital == "0"
              ? 1
              : loginC.role.value == 'nurse'
                  ? 3
                  : myC.service.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              if (loginC.role.value == 'nurse') {
                myC.serviceId.value =
                    listServiceC.listServiceNurseData[index]['id'];
              } else {
                myC.serviceId.value = myC.service[index]['service']['id'];
              }
              // if(myC.serviceId.value == 5 || myC.serviceId.value == 6 ){
              //   showPopUp(
              //                 onTap: () {},
              //                 imageAction: 'assets/json/eror.json',
              //                 description: "Sedang dalam proses\npengembangan");
              // }else{

              // }
              // }
              Get.to(() => const EditJadwal());
            },
            child: Container(
              margin: const EdgeInsets.only(left: 24.0, right: 24, top: 10),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    loginC.role.value == 'nurse'
                        ? listServiceC.listServiceNurseData[index]['image']
                        : '${myC.service[index]['service']['image']}',
                    width: 50,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loginC.role.value == 'nurse'
                            ? listServiceC.listServiceNurseData[index]['name']
                            : "${myC.service[index]['service']['name']}",
                        // title,
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                          width: Get.width / 2,
                          child: Text(
                              loginC.role.value == 'nurse'
                                  ? listServiceC.listServiceNurseData[index]
                                      ['description']
                                  : "Tentukan jadwal layanan praktik anda",
                              style: TextStyles.small1)),
                    ],
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ));
  }
}

class ListJadwalCompleteProfil extends StatelessWidget {
  final myC = Get.put(JadwalSayaController());
  final loginC = Get.put(LoginController());
  final listServiceC = Get.put(ListServiceNurseController());

  ListJadwalCompleteProfil({super.key});

  @override
  Widget build(BuildContext context) {
    if (loginC.role.value == 'nurse') {
      listServiceC.listServiceNurse();
    }
    // myC.listService();
    return Scaffold(
        bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ButtomGradient(
                label: 'Selesai',
                onTap: () {
                  Get.to(() => const Sukses());
                })),
        appBar: appbarGradient('Jadwal Layanan'),
        body: ListView.builder(
          itemCount: loginC.role.value == 'nurse' && loginC.inHospital == "0"
              ? 1
              : loginC.role.value == 'nurse'
                  ? 3
                  : myC.service.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              if (loginC.role.value == 'nurse') {
                myC.serviceId.value =
                    listServiceC.listServiceNurseData[index]['id'];
              } else {
                myC.serviceId.value = myC.service[index]['service']['id'];
              }
              Get.to(() => const EditJadwal());
              // }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 24.0, right: 24, top: 10),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    loginC.role.value == 'nurse'
                        ? listServiceC.listServiceNurseData[index]['image']
                        : '${myC.service[index]['service']['image']}',
                    width: 50,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loginC.role.value == 'nurse'
                            ? listServiceC.listServiceNurseData[index]['name']
                            : "${myC.service[index]['service']['name']}",
                        // title,
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                          width: Get.width / 2,
                          child: Text(
                              loginC.role.value == 'nurse'
                                  ? listServiceC.listServiceNurseData[index]
                                      ['description']
                                  : "Tentukan jadwal layanan praktik anda",
                              style: TextStyles.small1)),
                    ],
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ));
  }
}
