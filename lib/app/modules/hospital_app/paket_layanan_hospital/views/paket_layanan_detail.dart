import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/paket_layanan_hospital/views/detail_pendapatan_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/paket_layanan_hospital_controller.dart';

class PaketLayananHospitalDetail
    extends GetView<PaketLayananHospitalController> {
  PaketLayananHospitalDetail({Key? key}) : super(key: key);

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
              radius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffE9E9E9)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Aktivasi layanan',
                        size: 12,
                        weight: bold,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Txt(
                        text:
                            'Jika menonaktifkan layanan, anda tidak\ndapat menerima pesanan layanan ini',
                        size: 10,
                        weight: light,
                      )
                    ],
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      activeColor: Colors.blue,
                      value: controller.isActive.value,
                      onChanged: (value) {
                        controller.isActive.value = !controller.isActive.value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Txt(
              text: 'Laporan pendapatan layanan',
              weight: bold,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Cntr(
              gradient: gradient1,
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
                            text: 'Total pendapatan',
                            size: 10,
                            weight: light,
                            color: Colors.white,
                          ),
                          const SizedBox(
                          height: 5.0,
                          ),
                          Txt(
                            text: 'Rp 600.000',
                            size: 12,
                            weight: bold,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Cntr(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    color: Colors.amber,
                    radius: BorderRadius.circular(5),
                    child: Txt(
                      text: 'Lihat rincian',
                      size: 10,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
            height: 26.0,
            ),
            for(var i=0; i< 3 ;i++)
            Cntr(
              onTap: () {
                Get.to(()=> DetailPendapatanHospital());
              },
              margin: const EdgeInsets.only(bottom: 10),
              radius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffE9E9E9)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: 
              Row(
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
                  Cntr(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    color: Colors.amber,
                    radius: BorderRadius.circular(5),
                    child: Txt(
                      text: 'Lihat rincian',
                      size: 10,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
