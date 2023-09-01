import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/views/list_jadwal.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../doctor_app/login/controllers/login_controller.dart';
import '../../paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import '../controllers/list_service_nurse_controller.dart';

class ListServiceNurseView extends GetView<ListServiceNurseController> {
  const ListServiceNurseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.listServiceNurse();
    return Scaffold(
        bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ButtomGradient(
                label: 'Lanjutkan',
                onTap: () {
                  Get.to(() => ListJadwalCompleteProfil());
                })),
        appBar: AppBar(
          title: InkWell(onTap: () {}, child: const Text('Nurse Service')),
          elevation: 0.0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Obx(() => controller.listServiceNurseData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: Get.find<LoginController>().inHospital == "0"
                        ? 1
                        :controller.listServiceNurseData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        Get.put(PaketLayananNurseController())
                                .serviceIdNurse
                                .value =
                            controller.listServiceNurseData[index]['id'];
                        // if (Get.put(PaketLayananNurseController())
                        //         .serviceIdNurse
                        //         .value !=
                        //     4) {
                        //   showPopUp(
                        //       onTap: () {},
                        //       imageAction: 'assets/json/eror.json',
                        //       description: "Sedang dalam proses\npengembangan");
                        // } else {
                        // }
                          Get.toNamed(Routes.PAKET_LAYANAN_NURSE);
                        // await Get.put(PaketLayananNurseController()).getNursePket();
                        // print(  Get.put(PaketLayananNurseController()).serviceIdNurse.value.toString());
                        // controller.serviceId.value = controller.listServiceData[index]['id'];
                        // Get.to(() => LengkapiJamPraktek());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
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
                              '${controller.listServiceNurseData[index]['image']}',
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
                                  "${controller.listServiceNurseData[index]['name']}",
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
                                        "${controller.listServiceNurseData[index]['description']}",
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
                  ))));
  }
}
