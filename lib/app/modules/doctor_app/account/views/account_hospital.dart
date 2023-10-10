import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/account/controllers/account_controller.dart';
import 'package:bionmed/app/modules/doctor_app/account/views/account_tim_hospital.dart';
import 'package:bionmed/app/modules/doctor_app/account/widget/skpengguna_widget.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../theme.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widget/button/button_gradien.dart';
import '../../../../widget/container/container.dart';

class AccountHospital extends StatelessWidget {
  AccountHospital({super.key});
  final myC = Get.put(AccountController());
  final loginC = Get.put(LoginController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: Column(
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(23),
              height: 100,
              child: Row(
                children: [
                  Cntr(
                    height: 70,
                    width: 70,
                    image: const DecorationImage(
                        image: AssetImage('assets/icon/hospital.png'),
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Pilih Tim Rumah Sakit',
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: Get.width / 1.9,
                        child: Text(
                          'Pilih salah satu tim anda yang sudah terdaftar di rumah sakit',
                          style: blackTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 11,
                              color: const Color(0xff555555)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: loginBy.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // print(loginC.idAccount.value.toString());

                        // myC.selected = 1;
                        // '${loginBy[index]['subtitle']}' = index
                        // setState(() {
                        myC.selected.value = index + 1;
                        if (myC.selected.value == 1) {
                          loginC.idAccount.value = 3;
                        } else {
                          loginC.idAccount.value = myC.selected.value;
                        }
                        // });
                        log('zenn ========================== zen${loginC.idAccount.value}');
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(23),
                          height: 100,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.grey)
                              ],
                              border: Border.all(
                                  color: myC.selected.value == index + 1
                                      ? blueColor!
                                      : whiteColor!,
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: textFieldC),
                          child: Row(
                            children: [
                              Image.asset("${loginBy[index]['imageUrl']}"),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // width: 200,
                                    width: Get.width / 1.8,
                                    // color: Colors.amber,
                                    child: AutoSizeText(
                                      '${loginBy[index]['title']}',
                                      maxLines: 1,
                                      style: blackTextStyle.copyWith(
                                          fontWeight: semiBold, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    width: Get.width / 1.8,
                                    child: AutoSizeText(
                                      '${loginBy[index]['subtitle']}',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: medium,
                                          fontSize: 11,
                                          color: const Color(0xff555555)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))),
            ),
          ],
        ),
        bottomSheet: SizedBox(
          height: 130,
          width: Get.width,
          child: Column(
            children: [
              const SkPengguna(),
              const SizedBox(
                height: 24,
              ),
              myC.selected.value != null
                  ? ButtomGradient(
                      label: "Lanjutkan",
                      onTap: () {
                        if (myC.selected.value == 1) {
                          box.write('idAccount', loginC.idAccount.value);

                          Get.toNamed(Routes.LOGIN);
                          // showPopUp(
                          //   onTap: () {
                          //   Get.back();
                          // },
                          //     imageAction: 'assets/json/eror.json',
                          //     description: "Sedang dalam proses\npengembangan");
                        } else {
                          box.write('idAccount', loginC.idAccount.value);
                          Get.to(() => AccountTimHospital());
                        }
                        // myC.selected == 2 ? Get.defaultDialog() :
                      },
                    )
                  : ButtonPrimary(title: "Lanjutkan", onPressed: () {}),
            ],
          ),
        ));
  }
}

List<Map<String, dynamic>> loginBy = [
  {
    "imageUrl": "assets/icon/owner.png",
    "title": "Owner / Pemilik",
    "subtitle": "Masuk sebagai pemilik rumah sakit",
    "index": 1
  },
  {
    "imageUrl": "assets/icon/tim_hospital.png",
    "title": "Tim Rumah Sakit",
    "subtitle": "Masuk sebagai tim dari rumah sakit",
    "index": 2
  },
];
