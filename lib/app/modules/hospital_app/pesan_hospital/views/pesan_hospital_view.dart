import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/hospital_app/pesan_hospital/views/pesan_penarikan_saldo_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../controllers/pesan_hospital_controller.dart';

class PesanHospitalView extends GetView<PesanHospitalController> {
  const PesanHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Pesan'),
      body: ListView.builder(
        itemCount: 3,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) => InkWell(
      onTap: (){
        Get.to(()=> const PesanPenarikanSaldoHospital());
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
                Image.asset('assets/icon/saldo.png', width: 40,),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Penarikan Saldo",
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
                            maxLines: 2, "5 Notifikasi baru", style: TextStyles.small1),
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
    ),)
    );
  }
}
