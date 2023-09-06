import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme.dart';

class TimLayananProfile extends StatelessWidget {
   TimLayananProfile({super.key});
  final loginCv2 = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal :24.0),
        child: Column(
          children: [
            cardTimLayanan(),
          ],
        ),
      ),
    );
  }
  Cntr cardTimLayanan() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 10),
      radius: BorderRadius.circular(10),
      width: Get.width,
      gradient: gradient1,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Cntr(
                    color: Colors.transparent,
                    height: 40,
                    width: 40,
                    image: DecorationImage(
                        image: NetworkImage(loginCv2.imageService.value),
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: loginCv2.nameService.value,
                        weight: bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Txt(
                        text: loginCv2.nameHospital.value,
                        weight: light,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Cntr(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            alignment: Alignment.centerLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: loginCv2.name.value,
                  color: Colors.black,
                  weight: bold,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Cntr(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            alignment: Alignment.centerLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: loginCv2.phoneNumberUser.value,
                  color: Colors.black,
                  weight: bold,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Cntr(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 70,
            alignment: Alignment.topLeft,
            width: Get.width,
            color: AppColor.bgForm,
            radius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
            child: Txt(
              text: loginCv2.descriptionNurse.value,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}