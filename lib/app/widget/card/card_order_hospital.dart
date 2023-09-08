import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme.dart';
import '../../modules/doctor_app/detail/views/detail_view.dart';

class CardOrderHospital extends StatelessWidget {
  const CardOrderHospital({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cntr(
      radius: BorderRadius.circular(6),
       boxShadow: const [
                  BoxShadow(
    blurRadius: 6,
    spreadRadius: 0.4,
    color: Color.fromARGB(255, 222, 221, 221),
                  )
                ],
      margin: const EdgeInsets.symmetric(vertical: 7),
      width: Get.width,
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 30,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Tim Home Visit Dokter 1',
                    weight: bold,
                  ),
                  Txt(
                    text: "Home Visit Dokter",
                    color: Colors.grey,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: "Total Pembayaran",
                    color: Colors.black,
                  ),
                  Txt(
                    text: CurrencyFormat.convertToIdr(10000, 0),
                    weight: bold,
                  ),
                ],
              ),
              Cntr(
                radius: BorderRadius.circular(5),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5),
                color: const Color(0xff2B95DD),
                child: Txt(
                  text: 'Berlangsung',
                  size: 12,
                  weight: bold,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}