import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/card/card_order_hospital.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/paket_layanan_hospital_controller.dart';

class DetailPendapatanHospital extends GetView<PaketLayananHospitalController> {
  DetailPendapatanHospital({Key? key}) : super(key: key);

  final myC = Get.find<LengkapiDataHospitalController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Cntr(
              margin: const EdgeInsets.only(bottom: 10),
              radius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffE9E9E9)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: 'Pendapatan Harian',
                            size: 10,
                            weight: light,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Txt(
                            text: 'Rp 600.000',
                            size: 12,
                            weight: bold,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Txt(
                        text: '1 Pesanan',
                        size: 12,
                        weight: bold,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Txt(
              text: 'Rincian Pesanan',
              weight: bold,
            ),
            const SizedBox(
              height: 15.0,
            ),
            for (var i = 0; i < 3; i++)
                    const CardOrderHospital(),
              
          ],
        ),
      ),
    );
  }
}
