import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/perawat_app/list_service_nurse/controllers/list_service_nurse_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListServiceNurseViewEdit extends GetView<ListServiceNurseController> {
  ListServiceNurseViewEdit({Key? key}) : super(key: key);
  @override
  final controller = Get.put(ListServiceNurseController());
  @override
  Widget build(BuildContext context) {
    controller.listServiceNurse();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nurse Service'),
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
                    itemCount: Get.find<LoginController>().inHospital.value == "0"
                        ? 1
                        : controller.listServiceNurseData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        Get.put(PaketLayananNurseController())
                                .serviceIdNurse
                                .value =
                            controller.listServiceNurseData[index]['id'];
                        // if( Get.put(PaketLayananNurseController())
                        // .serviceIdNurse
                        // .value !=4){
                        //   showPopUp(
                        //   onTap: () {},
                        //   imageAction: 'assets/json/eror.json',
                        //   description: "Sedang dalam proses\npengembangan");
                        // }else{
                        // }
                        Get.put(PaketLayananNurseController()).getNursePket();
                        // print(  Get.put(PaketLayananNurseController()).serviceIdNurse.value.toString());
                        // controller.serviceId.value = controller.listServiceData[index]['id'];
                        // Get.to(() => LengkapiJamPraktek());
                        Get.toNamed(Routes.PAKET_LAYANAN_NURSE);
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
