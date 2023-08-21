import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/call_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xffE3E3E3),),
                    // image: DecorationImage(image: AssetImage('assets/images/doctor1.png'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(100), color: Colors.white),
                ),
                Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),

                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    // border: Border.all(width: 5),
                    image: const DecorationImage(image: AssetImage('assets/images/doctor1.png'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(100)),
                ),
              ],
            ),
            
          ),
          const SizedBox(height:  25,),
          Text('Dr. Paul Castelo', style: blackTextStyle.copyWith( fontSize: 20, fontWeight: bold),),
          const SizedBox(height:  6,),
          Text('Dr. Paul Castelo', style: greyTextStyle.copyWith( fontSize: 14, fontWeight: light),),
          const SizedBox(height:  63,),
          Text('12 : 30 minutes', style: greyTextStyle.copyWith( fontSize: 16, fontWeight: light),),
          const SizedBox(height:  56,),
          Text('Missed Call !', style: GoogleFonts.ubuntu( fontSize: 16, fontWeight: medium, color: Colors.red),),
          const SizedBox(height:  44,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)),
                  child: Image.asset('assets/icon/reject_call.png'),
                ),
          const SizedBox(height:  16,),
          Text('Cancel', style: greyTextStyle.copyWith( fontSize: 16, fontWeight: light),),

              ],
            ),
            Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: const Color(0xff00B9A3), borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.call_end_rounded, color: whiteColor,),
                ),
                const SizedBox(height:  16,),
          Text('Calling', style: greyTextStyle.copyWith( fontSize: 16, fontWeight: light),),
              ],
            )
          ],)







          
          // Image.asset('assets/images/doctor1.png')
        ],
      ),
    );
  }
}
