import 'package:bionmed/app/modules/doctor_app/layanan/controllers/layanan_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../widget/other/loading_indicator.dart';
import '../controllers/pilih_spesialis_controller.dart';

class PilihSpesialisView extends StatefulWidget {
  const PilihSpesialisView({Key? key}) : super(key: key);

  @override
  State<PilihSpesialisView> createState() => _PilihSpesialisViewState();
}

class _PilihSpesialisViewState extends State<PilihSpesialisView> {
  final registerC = Get.put(RegisterController());

  final loginC = Get.put(LoginController());

  final serviceC = Get.put(LayananController());

  final controller = Get.put(PilihSpesialisController());

  int? selected;

  @override
  Widget build(BuildContext context) {
    controller.spesialist();
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Pilih Spesialis"),
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isloading.value,
          progressIndicator: loadingIndicator(),
          color: Colors.transparent,
          opacity: 0.2,
          child: Padding(
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
                                          controller.toggle11(index);

                                          controller.selectedInt = controller
                                              .spesialisData[index]['id'];
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
                                        trailing: Obx(() => Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: controller
                                                                  .selectedIndex
                                                                  .value ==
                                                              index
                                                          ? const AssetImage(
                                                              'assets/icon/checkboxon.png')
                                                          : const AssetImage(
                                                              'assets/icon/checkboxoff.png'))),
                                            ))),
                                  )),
                    )
                    // Obx(
                    //   () => ListView.builder(
                    //     itemCount: controller.spesialisData.length,
                    //     itemBuilder: (context, index) => Container(
                    //         margin: const EdgeInsets.only(bottom: 24),
                    //         height: 72,
                    //         // color: blueColor,
                    //         child: ListTile(
                    //             onTap: () {
                    //               setState(() {
                    //                 selected = index;
                    //               });

                    //               controller.selectedInt =
                    //                   controller.spesialisData[index]['id'];
                    //               print('object${controller.selectedInt}');
                    //               print('object anjay${controller.selectedView}');
                    //             },
                    //             title: Text(
                    //               '${controller.spesialisData[index]['name']}',
                    //               style: blackTextStyle.copyWith(
                    //                   fontWeight: medium,
                    //                   color: const Color(0xff555555)),
                    //             ),
                    //             leading: Container(
                    //                   alignment: Alignment.center,
                    //                   height: 72,
                    //                   width: 72,
                    //                   decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(10),
                    //                       color:textFieldC),
                    //                   child:controller.isloading.isTrue ? loadingIndicator() :  Image.network(
                    //                       "${controller.spesialisData[index]['image']}"),
                    //                 ),
                    //             trailing: Container(
                    //               height: 20,
                    //               width: 20,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       image: selected == index
                    //                           ? const AssetImage(
                    //                               'assets/icon/checkboxon.png')
                    //                           : const AssetImage(
                    //                               'assets/icon/checkboxoff.png'))),
                    //             )
                    //             )),
                    //   ),
                    // )
                    )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 24),
        // ignore: unnecessary_null_comparison
        child: controller.isSelected != null
            ? Obx(() => ButtomGradient(
                  label:
                      controller.isloading.isFalse ? "Selesai" : "Loading....",
                  onTap: () async {
                      if(controller.isloading.isFalse){
                     await controller.addService(
                        serviceId: controller.selectedInt,
                      );
                      // Get.to(() => const LayananSucces());
                      popUpSelesai();
                      loginC.controllerPhone.clear();
                      // Get.to(()=> RegisterDataAkun());
                      }
                  },
                ))
            : ButtonPrimary(title: "Pilih", onPressed: () {}),
        // child: controller.selected.isFalse
        //     ? ButtonPrimary(
        //         title: "Pilih",
        //         onPressed: () {
        //           controller.addService(
        //             serviceId: controller.selectedInt,
        //             // doctor_services : controller.spesialisSelected
        //           );
        //           // registerC.register(
        //           //   image: 'akun',
        //           //     name: registerC.controllerName.text,
        //           //     brithdayDate: registerC.controllerDate.text,
        //           //     address: registerC.controllerAlamat.text,
        //           //     gender: registerC.selectedValue,
        //           //     phoneNumber: loginC.controllerPhone.text,
        //           //     experience: registerC.controllerPengalaman.text,
        //           //     strNumber: registerC.controllerNomerStr.text,
        //           //     deviceId: '',
        //           //     service: serviceC.serviceSelected,
        //           //     spesialis: controller.spesialisSelected);
        //           // Get.to(const LayananSucces());
        //         })
        //     : ButtomGradient(label: "Pilih", onTap: () {}),
      ),
    );
  }

  popUpSelesai() {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/images/terkirim.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(
                            text: 'Berhasil Terkirim',
                            size: 16,
                            weight: bold,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Data anda sudah kami terima, dan saat ini masih dalam proses. waktu maksimal 3 Hari kerja akan kami konfirmasi kembali',
                            style: TextStyle(fontSize: 12, fontWeight: light),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Selesai",
                            onTap: () {
                              Get.back();
                              Get.offAllNamed(Routes.LOGIN);

                              //   loginC.controllerPhone.clear();
                            },
                          )
                        ])
                  ]));
        });
  }
}
