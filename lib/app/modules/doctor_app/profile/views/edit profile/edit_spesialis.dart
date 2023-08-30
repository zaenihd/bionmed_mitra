import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan/controllers/layanan_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../pilih_spesialis/controllers/pilih_spesialis_controller.dart';

class EditSpesialis extends StatefulWidget {
  const EditSpesialis({Key? key}) : super(key: key);

  @override
  State<EditSpesialis> createState() => _PilihSpesialisViewState();
}

class _PilihSpesialisViewState extends State<EditSpesialis> {
  final registerC = Get.put(RegisterController());

  final loginC = Get.put(LoginController());

  final serviceC = Get.put(LayananController());

  final controller = Get.put(PilihSpesialisController());

  final myC = Get.put(ProfileController());
  final loginCV2 = Get.put(JadwalSayaController());

  int? selected;
  RxInt terpilih = 0.obs;

  @override
  Widget build(BuildContext context) {
    controller.spesialist();
    return  Scaffold(
      backgroundColor: backgroundColorC,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Pilih Spesialis"),
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => LoadingOverlay(
              isLoading: loginCV2.isloading.value,
              progressIndicator: loadingIndicator(),
              color: Colors.transparent,
              opacity: 0.2,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child:Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spesialis',
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 600,
                child: Obx(
                  () => controller.isloading.isTrue
                      ? loadingIndicator()
                      : ListView.builder(
                          itemCount: controller.spesialisData.length,
                          itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                height: 72,
                                // color: blueColor,
                                child: ListTile(
                                    onTap: () {
                                      myC.selectedIndex.value == index;
                                      log('message ' + index.toString());
                                      myC.toggle11(index);
                                      controller.selectedInt =
                                          controller.spesialisData[index]['id'];
                                    },
                                    title: Text(
                                      '${controller.spesialisData[index]['name']}',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: medium,
                                          color: const Color(0xff555555)),
                                    ),
                                    leading: Container(
                                      alignment: Alignment.center,
                                      height: 72,
                                      width: 72,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: textFieldC),
                                      child: Image.network(
                                          "${controller.spesialisData[index]['image']}"),
                                    ),
                                    trailing: 
                                    // loginCV2.spesialis.value 
                                    Obx(() => 
                                    Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: 
                                                 myC.selectedIndex.value == index
                                                      ? const AssetImage(
                                                          'assets/icon/checkboxon.png')
                                                      : const AssetImage(
                                                          'assets/icon/checkboxoff.png'))),
                                        )

                                    
                                    // :Container(
                                    //       height: 20,
                                    //       width: 20,
                                    //       decoration: BoxDecoration(
                                    //           image: DecorationImage(
                                    //               image: 
                                    //               myC.selectedIndex
                                    //                           .value ==
                                    //                       index
                                    //                   ? const AssetImage(
                                    //                       'assets/icon/checkboxon.png')
                                    //                   : const AssetImage(
                                    //                       'assets/icon/checkboxoff.png'))),
                                    //     )
                                        )
                                        ,
                              )),
                )))
          ],
        ),
      ),)),
      
    ),
    bottomSheet: Obx(() => Container(
            margin: const EdgeInsets.only(bottom: 24),
            // ignore: unrelated_type_equality_checks
            child: myC.selectedIndex != 20
                ? ButtomGradient(
                    label: "Simpan",
                    onTap: () async{
                    //  await myC.editSpesialis(serviceId: myC.selectedIndex.value);
                     await myC.editSpesialis(
                            serviceId: controller.selectedInt,);
                             final box = GetStorage();
                                var phone = await box.read('phone');
                                if (phone != null) {
                                  await 
                                      loginCV2.loginData(phoneNumber: phone);
                                }
                      Get.back();
                      // Get.to(LayananSucces());
                      //             loginC.controllerPhone.clear();
                    },
                  )
                : ButtonPrimary(title: "Simpan", onPressed: () {}),
          ),
          ),);
  }
}
