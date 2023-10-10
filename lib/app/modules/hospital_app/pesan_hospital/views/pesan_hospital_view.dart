import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/hospital_app/pesan_hospital/views/pesan_penarikan_saldo_hospital.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../../../../constant/colors.dart';
import '../controllers/pesan_hospital_controller.dart';

class PesanHospitalView extends StatelessWidget {
   PesanHospitalView({Key? key}) : super(key: key);
  final controller = Get.put(PesanHospitalController());
  @override
  Widget build(BuildContext context) {
    controller.fetchInboxHospital();
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(
        height: 1.0,
        ),
    title: const Text("Pesan"),
    elevation: 0.0,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: AppColor.gradient1,
      ),
    ),
  ),
      body: Obx(()=>
        controller.isLoading.isTrue ? loadingIndicator() :
      
      ListView.builder(
        itemCount: controller.listInboxHospital.length ,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
        return InkWell(
      onTap: (){
        Get.to(()=>  PesanPenarikanSaldoHospital(data: controller.listInboxHospital[index]['inbox'], imageUrl: 
        controller.listInboxHospital[index]['service'] == "Penarikan Saldo" ? "null" :
        controller.listInboxHospital[index]['service']['image'],));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.listInboxHospital[index]['service'] == "Penarikan Saldo" ? Image.asset('assets/icon/saldo.png',width: 40,) :
                Image.network(
                  "${controller.listInboxHospital[index]['service']['image']}", width: 40,),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.listInboxHospital[index]['service'] == "Penarikan Saldo" ? "Penarikan Saldo" :
                      "${controller.listInboxHospital[index]['service']['name']}",
                      style:
                          blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.notifications, color: Colors.red, size: 15,),
                        const SizedBox(
                        width: 5.0,
                        ),
                        AutoSizeText(
                            maxLines: 2, "${controller.listInboxHospital[index]['inbox'].length} Notifikasi baru", style: TextStyles.small1),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 15,)
          ],
        ),
      ),
    );},
    )
    )
    );
  }
}
