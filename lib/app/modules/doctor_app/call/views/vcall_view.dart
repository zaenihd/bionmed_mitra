import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/call_controller.dart';

class VCallView extends GetView<CallController> {
  const VCallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/vcall_bc.png'),fit: BoxFit.cover)),
            // child: Image.asset('')))
          ),
          Padding(
            padding: const EdgeInsets.only(left :24.0, right: 24, top: 48, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.amber
                  ),
                  child: Row(children: [
                    const Icon(Icons.fiber_manual_record, color: Colors.red, size: 8,),
                    const SizedBox(width: 12,),
                    Text('03 : 11', style: blackTextStyle.copyWith(fontWeight: bold),),
                  ],),
                ),
                Stack(
                  children: [
                    Container(
                      width: 94,
                      height: 132,
                      decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(image: AssetImage('assets/images/doctor1.png'), fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 89, left: 8),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(100),),
                      child: Image.asset('assets/icon/icon_flipcamera.png'),
                      )
                  ],
                )
              ],),
              SizedBox(child: Column(
                children: [
                  Text('Dr.Paul Castelo', style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 20),),
                  const SizedBox(height: 8,),
                  Text('Dr.Paul Castelo', style: whiteTextStyle.copyWith(fontWeight: normal, fontSize: 16),),

                ],
              ),)
            ],),
          )
        ],
      ),
    );
  }
}