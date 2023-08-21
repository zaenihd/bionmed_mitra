import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme.dart';

// ignore: must_be_immutable
class CardLayanan extends StatelessWidget {
  CardLayanan(
      {Key? key,
      required this.name,
      required this.onTap,
      required this.price,
      required this.imageUrl,
      required this.color,
      required this.service,
      required this.label,
      required this.tanggal,
      required this.iconService,
      required this.service1,
      required this.iconlayanan,

      
      })
      : super(key: key);

  Function() onTap;
  String name;
  int price;
  String imageUrl;
  String label;
  Color color;
  String service;
  String tanggal;
  String iconService;
  String service1;
  String iconlayanan;

  final layananC = Get.put(LayananHomeController());


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Header(
              iconService: iconService,
              service: service,
              imageUrl: imageUrl,
              name: name,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: blackTextStyle.copyWith(
                          fontSize: 12, color: const Color(0xff6C6C6C)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(price, 0),
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    // Container(
                    //   width: 18,
                    //   height: 18,
                    //   decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/image 5.png'), fit: BoxFit.cover)),
                    //   // child: Image.asset('assets/icon/image 5.png')
                    //   ),
                    Text(
                      tanggal,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, color: const Color(0xff6C6C6C)),
                    )
                  ],
                )
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(iconlayanan,width: 30,),
                    const SizedBox(width: 10),
                    Text(
                      service1,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, color: const Color(0xff6C6C6C)),
                    ),
                  ],
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // width: 120,
                    // height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: color,
                    ),
                    child: Text(
                      label,
                      style: whiteTextStyle.copyWith(
                          fontSize: 12, fontWeight: medium),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Header extends StatelessWidget {
  Header({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.service,
    required this.iconService,

  }) : super(key: key);

  String name;
  String imageUrl;
  String service;
  String iconService;

  final layananHomeC = Get.put(LayananHomeController());


  @override
  Widget build(BuildContext context) {
    return
     Row(
      children: [
        // layananHomeC.isloading.isTrue ? loadingIndicator() :
        Container(
          width: 72,
          height: 72,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),),
            const SizedBox(
            width: 10.0,
            ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF6F6F6)),
                  child: Image.network(iconService),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  // data order service name
                  service,
                  style: blackTextStyle.copyWith(
                      fontSize: 14, color: const Color(0xff6C6C6C)),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
