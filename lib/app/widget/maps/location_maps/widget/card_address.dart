
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

class CardAddress extends StatelessWidget {
  final String label;
  final String desc;
  final bool isDefault;
  const CardAddress({
    Key? key,
    this.label = '',
    this.desc = '',
    this.isDefault = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: Get.height*0.025),
      decoration: BoxDecoration(
        color: AppColor.weak2Color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.location_on,
                size: 18,
              ),
              const SizedBox(width: 3),
              Text(
                label,
                style: const TextStyle(
                  color: AppColor.bodyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                isDefault ? 'Utama' : '',
                style: const TextStyle(
                  color: Color(0xff0B9444),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              desc,
              style: const TextStyle(
                color: AppColor.bodyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Text(
          //   '...',
          //   style: const TextStyle(
          //     color: AppColor.bodyColor,
          //     fontSize: 12,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }
}