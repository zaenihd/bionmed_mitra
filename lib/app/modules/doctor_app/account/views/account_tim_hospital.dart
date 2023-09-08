import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/account/controllers/account_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../theme.dart';
import '../../../../widget/container/container.dart';

class AccountTimHospital extends StatelessWidget {
  AccountTimHospital({super.key});
  final myC = Get.put(AccountController());
  final loginC = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: Column(
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
            Cntr(
              margin: const EdgeInsets.only(bottom: 50),
              height: Get.height / 1.3,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  itemCount: loginBy.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // print(loginC.idAccount.value.toString());

                        // myC.selected = 1;
                        // '${loginBy[index]['subtitle']}' = index
                        // setState(() {
                        myC.selected.value = index + 1;
                        if (myC.selected.value == 3 ||
                            myC.selected.value == 4) {
                          loginC.idAccount.value = 2;
                        } else if (myC.selected.value == 1) {
                          loginC.idAccount.value = 3;
                        } else {
                          loginC.idAccount.value = myC.selected.value;
                        }
                        if (myC.selected.value == 3 ||
                            myC.selected.value == 4 ||
                            myC.selected.value == 1) {
                          Get.toNamed(Routes.LOGIN);
                          // showPopUp(
                          //   onTap: () {\
                          //   Get.back();
                          // },
                          //     imageAction: 'assets/json/eror.json',
                          //     description: "Sedang dalam proses\npengembangan");
                        } else {
                          showPopUp(
                              onTap: () {
                                Get.back();
                              },
                              imageAction: 'assets/json/eror.json',
                              description: "Sedang dalam proses\npengembangan");
                        }
                        // });
                        GetStorage().write('idAccount', loginC.idAccount.value);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(23),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: Colors.grey)
                              ],
                              border: Border.all(
                                  color: 
                                       whiteColor!,
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
                        
                      ))),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> loginBy = [
  {
    "imageUrl": "assets/icon/akun.png",
    "title": "Housepital",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun1.png",
    "title": "Home Visit Doctor",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun2.png",
    "title": "Baby Care",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun3.png",
    "title": "Mother Care",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun4.png",
    "title": "Clinic Laboratory",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun6.png",
    "title": "Ambulance",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun7.png",
    "title": "Ambulance",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun8.png",
    "title": "Online Registration",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun9.png",
    "title": "Apotek",
    "subtitle": "Masuk sebagai tim",
  },
  {
    "imageUrl": "assets/icon/akun10.png",
    "title": "Stunting",
    "subtitle": "Masuk sebagai tim",
  },
];
