import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/card/card_order_from_income_hopital.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widget/card/card_layanan.dart';
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
                      Image.asset(
                        controller.dateIncome.value == 1
                            ? 'assets/icon/pendapatan.png'
                            : controller.dateIncome.value == 2
                                ? 'assets/icon/pendapatan1.png'
                                : controller.dateIncome.value == 3
                                    ? 'assets/icon/pendapatan2.png'
                                    : 'assets/icon/nurse.png',
                        width: 25,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: controller.dateIncome.value == 1
                                ? 'Pendapatan Harian'
                                : controller.dateIncome.value == 2
                                    ? 'Pendapatan Bulanan'
                                    : controller.dateIncome.value == 3
                                        ? 'Pendapatan Tahunan'
                                        : "Pendapatan Total",
                            size: 10,
                            weight: light,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Txt(
                            text: controller.dateIncome.value == 1
                                ? CurrencyFormat.convertToIdr(
                                    controller.incomeDay.value, 0)
                                : controller.dateIncome.value == 2
                                    ? CurrencyFormat.convertToIdr(
                                        controller.incomeMonth.value, 0)
                                    : controller.dateIncome.value == 3
                                        ? CurrencyFormat.convertToIdr(
                                            controller.incomeMonth.value, 0)
                                        : CurrencyFormat.convertToIdr(
                                            controller.incomeTotal.value, 0),
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
                        text:
                            "${controller.detailIncomeFromDate.length} Pesanan",
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.detailIncomeFromDate.length,
                itemBuilder: (context, index) => CardOrdeFromIncomerHospital(
                  date: controller.detailIncomeFromDate[index]['endDate'] ??
                      'null',
                  imageUrl: 'assets/icon/nurse.png',
                  // controller.detailIncomeFromDate[index]['nurse']
                  //                 ['image'] ==
                  //             "" ||
                  //         controller.detailIncomeFromDate[index]['nurse']
                  //                 ['image'] ==
                  //             null
                  //     ? "https://cdn.pnghd.pics/data/221/foto-profil-kosong-12.jpg"
                  //     : controller.detailIncomeFromDate[index]['nurse']
                  //         ['image'],
                  name: controller.detailIncomeFromDate[index]['nurse']['name'],
                  status: controller.detailIncomeFromDate[index]['status'],
                  pendatapan: controller.detailIncomeFromDate[index]
                      ['subtotal'],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
