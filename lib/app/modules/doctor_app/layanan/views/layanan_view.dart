import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../../theme.dart';
import '../../../../widget/header/header_layanan.dart';
import '../../../../widget/other/loading_indicator.dart';
import '../controllers/layanan_controller.dart';

// ignore: must_be_immutable
class LayananView extends GetView<LayananController> {
  bool? selected;
  LayananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorC,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Pilih Layanan"),
          titleTextStyle: const TextStyle(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                  imageUrl: 'assets/icon/icon_layanan.png',
                  title: 'Layanan Anda',
                  subtitle:
                      'Pilih spesialis bidang keahlian mu untuk melayani pasien'),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pilih Layanan",
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                  ),
                  Obx(() => controller.layananTerpilih.value != 0
                      ? Text(
                          "Terpilih (${controller.layananTerpilih.value})",
                          style: blackTextStyle.copyWith(
                              fontWeight: bold, fontSize: 16),
                        )
                      : const SizedBox()),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.only(bottom: 30),
                    itemCount:controller.services.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: ListTile(
                        // if(controller.selected.value == false){
                        // controller.serviceSelected.addAll(controller.services[index]);
                        // }else{
                        //   // controller.serviceSelected.removeLast();
                        // }
                        // // controller.selected.value = !controller.selected.value;
                        // print('object' +
                        //     controller.counter(
                        //         controller.dataCount[index]['index'],
                        //         controller.dataCount[index]));
                        //         print('aloooo ' + controller.dataCount.toString());
                        title: Text(
                          '${controller.services[index]['name']}',
                          // '',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        leading: Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                              color: textFieldC,
                              borderRadius: BorderRadius.circular(9)),
                          child: Obx(() => LoadingOverlay(
                                isLoading: controller.isloading.value,
                                progressIndicator: loadingIndicator(),
                                color: Colors.transparent,
                                opacity: 0.2,
                                child: Image.network(
                                    '${controller.services[index]['image']}'),
                              )),
                        ),
                        trailing: Obx(
                          () => controller.load.value == false
                              ? controller.dataCount[index]['value'] == true.obs
                                  ? InkWell(
                                      onTap: () {
                                        controller.counterMin(
                                            controller.dataCount[index]
                                                ['index'],
                                            controller.dataCount[index]);
                                        // controller.layananTerpilih.value = controller.layananTerpilih.value - 1;
                                        // controller.tampunganLayanan
                                        //     .removeAt(index);
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/checkboxon.png')),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        controller.tampunganLayanan.add(
                                            controller.services[index]['id']);
                                        controller.counter(
                                            controller.dataCount[index]
                                                ['index'],
                                            controller.dataCount[index]);

                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/checkboxoff.png')),
                                        ),
                                      ))
                              : InkWell(
                                  onTap: () {
                                    controller.tampunganLayanan
                                        .add(controller.services[index]);

                                    // controller.counter(
                                    //     controller.dataCount[index]['index'],
                                    //     controller.dataCount[index]);

                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icon/checkboxoff.png')),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Obx(
          () => controller.layananTerpilih.value != 0
              ? Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child:Obx(()=> ButtomGradient(
                    label:controller.isloading.isFalse ? "Lanjutkan" : "Loading.....",
                    onTap: ()async {
                      if(controller.isloading.isFalse){

                     await controller.addService(
                          serviceId: controller.tampunganLayanan);
                      Get.toNamed(Routes.PILIH_SPESIALIS);
                      }
                    },
                  ),)
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: ButtonPrimary(
                    title: "Lanjutkan",
                    onPressed: () {
                      // controller.addService(serviceId: [1,7,17]);
                      // Get.toNamed(Routes.PILIH_SPESIALIS);
                    },
                  ),
                ),
        ));
  }
}

List<Map<String, dynamic>> layanan = [
  {
    "imageUrl": "assets/icon/doctor.png",
    "title": "Dokter on Call By Specialist",
    "value": false
  },
  {
    "imageUrl": "assets/icon/doctor.png",
    "title": "Dokter on Call By Specialist",
    "value": false
  },
  {
    "imageUrl": "assets/icon/doctor.png",
    "title": "Dokter on Call By Specialist",
    "value": false
  },
];
