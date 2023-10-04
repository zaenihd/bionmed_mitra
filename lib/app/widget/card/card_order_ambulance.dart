import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme.dart';
import '../../modules/doctor_app/detail/views/detail_view.dart';

class CardOrderAmbulance extends StatelessWidget {
  CardOrderAmbulance({
    Key? key,
    required this.name,
    required this.service,
    required this.price,
    required this.imageUrl,
    required this.status,
    required this.onTap
  }) : super(key: key);

  String name, service, imageUrl;
  int status, price;
  Function()onTap;

  @override
  Widget build(BuildContext context) {
    return Cntr(
      onTap: onTap,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Cntr(
                height: 50,
                width: 50,
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: name,
                    weight: bold,
                  ),
                  Txt(
                    text: service,
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
                    text: CurrencyFormat.convertToIdr(price, 0),
                    weight: bold,
                  ),
                ],
              ),
              Cntr(
                radius: BorderRadius.circular(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color:status == 4
            ? blueColor!
            : status == 6 || status == 5
                ? greenColor!
                : status == 0
                    ? buttonColor!
                    : status == 3
                        // ||
                        //         dataService ==
                        //             'Telemedicine'
                        ? blueColor!
                        : status == 1
                            ? greenColor!
                            : status == 2
                                ? Colors.amber
                                : Colors.red,
                child: Txt(
                  text: status == 4
            ? 'Sedang berlangsung'
            : status == 6
                ? "Konfirmasi selesai"
                : status == 5
                    ? 'Selesai'
                    : status == 0
                        ? "Belum bayar"
                        : status == 3
                            //  ||
                            // dataService == 'Telemedicine'
                            ? 'Mulai sekarang'
                            : status == 2
                                // ||
                                // dataService == 'Dokter on Call'
                                ? "Terjadwalkan"
                                : status == 99
                                    ? "Terlewatkan"
                                    : status == 1
                                        ? "Sudah bayar"
                                        : '',
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
