import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/paket_layanan_hospital/views/paket_layanan_detail.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widget/other/show_dialog.dart';
import '../controllers/paket_layanan_hospital_controller.dart';

class PaketLayananHospitalView extends GetView<PaketLayananHospitalController> {
  PaketLayananHospitalView({Key? key}) : super(key: key);

  final myC = Get.find<LengkapiDataHospitalController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Paket Layanan'),
          centerTitle: true,
        ),
        body: Obx(
          () => Get.find<LengkapiDataHospitalController>().isloading.isTrue
              ? loadingIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: myC.listServiceHospital.length,
                  itemBuilder: (context, index) => Cntr(
                    onTap: () async {
                      if(myC.listServiceHospital[index]['service']['id'] == 5 || myC.listServiceHospital[index]['service']['id'] == 6 || myC.listServiceHospital[index]['service']['id'] == 8 ){

                      myC.index.value =index;
                      controller.seviceId.value =
                          myC.listServiceHospital[index]['service']['id'];
                      myC.listTimServiceHospital.value =
                          myC.listServiceHospital[index]['team'];
                      Get.put(PaketLayananHospitalController());
                      controller.hospitalIncome();
                      Get.to(() => PaketLayananHospitalDetail());
                      }else{
                        showPopUp(
                              onTap: () {
                                Get.back();
                              },
                              imageAction: 'assets/json/eror.json',
                              description: "Sedang dalam proses\npengembangan");

                      }
                    },
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 0.4,
                        color: Color.fromARGB(255, 222, 221, 221),
                      )
                    ],
                    radius: BorderRadius.circular(10),
                    color: Colors.white,
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 24, right: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Cntr(
                                onTap: () async {},
                                // color: Colors.grey,
                                height: 40,
                                width: 40,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${myC.listServiceHospital[index]['service']['image']}'),
                                    fit: BoxFit.cover),
                              ),
                              // Image.network('${controller.listServiceHospital[index]['service']['image']}'),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Txt(
                                    text:
                                        '${myC.listServiceHospital[index]['service']['name']}',
                                    weight: bold,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      myC.listServiceHospital[index]['team']
                                                  .toString() ==
                                              "[]"
                                          ? const Icon(
                                              Icons.crisis_alert_outlined,
                                              color: Colors.yellow,
                                              size: 15,
                                            )
                                          : const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 15,
                                            ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Txt(
                                        text: myC.listServiceHospital[index]
                                                        ['team']
                                                    .toString() ==
                                                "[]"
                                            ? "Belum terdaftar"
                                            : 'Layanan Terdaftar',
                                        weight: medium,
                                        size: 11,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          // const Icon(Icons.arrow_forward_ios_rounded),
                        ]),
                  ),
                ),
        ));
  }
}
