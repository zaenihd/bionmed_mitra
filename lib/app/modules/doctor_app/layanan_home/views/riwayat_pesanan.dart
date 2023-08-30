import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/views/widget/card_layanan_tab.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../../../../widget/button/button_gradien.dart';

class RiwayatPesanan extends StatelessWidget {
  RiwayatPesanan({super.key});
  final myC = Get.put(LayananHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18, top: 14),
                          width: Get.width / 1.9,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffEDEDED)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Apakah Anda yakin ?',
                          style: blackTextStyle.copyWith(fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        ButtomGradient(
                            label: "Hapus Semua",
                            onTap: () async {
                              showPopUp(
                                  onTap: () {},
                                  imageAction: 'assets/json/eror.json',
                                  description: "Sedang dalam proses\npengembangan");
                            }),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          height: 45,
                          width: Get.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  backgroundColor: buttonColor),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Batal")),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: 
              Row(
                children: const [
                  // Icon(
                  //   Icons.delete_forever,
                  //   size: 20,
                  // ),
                  // SizedBox(
                  //   width: 5.0,
                  // ),
                  // Text(
                  //   'Delete All',
                  // )
                ],
              ),
            ),
          ),
        ],
        // titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: Get.find<LoginController>().role.value == 'nurse'
          ? CardServiceNurse(
              myC: myC,
              statusList:5,
              statusList1:6,
              statusList2: 99,
            )
          : CardService1(
              myC: myC,
              statusList: 5,
              statusList1: 6,
              statusList2: 99,
            ),
    );
  }
}
