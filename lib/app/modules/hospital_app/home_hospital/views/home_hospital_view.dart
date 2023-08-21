import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../controllers/home_hospital_controller.dart';

class HomeHospitalView extends GetView<HomeHospitalController> {
  const HomeHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorC,
        body: Column(children: [
          Stack(
            children: [
              SizedBox(
                width: Get.width,
                child: Image.asset('assets/icon/Ellipse 179.png'),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamt Siang',
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 16, fontWeight: normal),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  // '${loginC.name}',
                                  "Rs Medika",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 20, fontWeight: bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/icon/icon_star.png'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  // '${loginC.rating}',
                                  '5',
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 20, fontWeight: bold),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          width: Get.width,
                          // height: 62,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 20,
                                    offset: Offset(0, 5),
                                    color: Colors.grey)
                              ],
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.asset('assets/icon/icon_wallet.png'),
                                    Text(
                                      'Pendapatan :',
                                      style:
                                          blackTextStyle.copyWith(fontSize: 11),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    Text(
                                      'Rp',
                                      style:
                                          greenTextStyle.copyWith(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '450.000',
                                      style:
                                          greenTextStyle.copyWith(fontSize: 24),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Txt(text: 'Layanan', size: 16, weight: bold),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                        SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom :20.0, right: 10,left: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 91,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    boxShadow: Shadows.universal,
                                    color: whiteColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          'assets/icon/icon_hospital/icon_antrian.png'),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Txt(
                                              text: 'Daftar Antrian',
                                              size: 12,
                                              weight: normal),
                                          Txt(text: '201', size: 32, weight: bold),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_outlined,
                                            color: blueColor,
                                          ),
                                          Txt(
                                            text: 'Lihat antrian',
                                            size: 10,
                                            weight: medium,
                                            color: blueColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                width: 20.0,
                                ),
                                 Container(
                                  height: 91,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    boxShadow: Shadows.universal,
                                    color: whiteColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          'assets/icon/icon_hospital/icon_antrian.png'),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Txt(
                                              text: 'Daftar Antrian',
                                              size: 12,
                                              weight: normal),
                                          Txt(text: '201', size: 32, weight: bold),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_outlined,
                                            color: blueColor,
                                          ),
                                          Txt(
                                            text: 'Lihat antrian',
                                            size: 10,
                                            weight: medium,
                                            color: blueColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ]));
  }
}
