import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../../../doctor_app/detail/views/detail_view.dart';
import '../controllers/pendapatan_tim_hospital_controller.dart';

class PendapatanTimHospitalView
    extends GetView<PendapatanTimHospitalController> {
  const PendapatanTimHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Pendapatan'),
      body:SafeArea(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: Get.width,
            height: 148,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 10,
                  color: Color.fromARGB(255, 225, 223, 223))
            ], color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [
              Container(
                alignment: Alignment.topRight,
                width: Get.width,
                height: 148,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: AssetImage('assets/icon/icon_side.png'),
                        alignment: Alignment.topRight)),
                // child: Image.asset('assets/icon/icon_side.png')
              ),
              Container(
                alignment: Alignment.topRight,
                width: Get.width,
                height: 148,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: AssetImage('assets/icon/icon_side1.png'),
                        alignment: Alignment.bottomLeft)),
                // child: Image.asset('assets/icon/icon_side.png')
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                width: Get.width,
                height: 148,
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Saldo pendapatan terkini :',
                      style: blackTextStyle.copyWith(
                          fontSize: 10, fontWeight: medium),
                    ),
                    // Image.asset('assets/icon/icon_wallet.png', height: 60,),
                    // Cntr(
                    //   height: 70,
                    //   width: 70,
                    //   image: const DecorationImage(
                    //       image: AssetImage('assets/icon/icon_wallet.png'),fit: BoxFit.cover),
                    // ),
                    AutoSizeText(
                      maxLines: 1,
                      CurrencyFormat.convertToIdr(
                          0, 0),
                      style: greenTextStyle.copyWith(
                          fontWeight: bold, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                width: Get.width,
                height: 148,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                      Row(
                        children: [
                          Image.asset('assets/icon/icon_wallet.png', height: 60,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Txt(text: 'Saldo Pendapatan', weight: bold,),
                            Txt(text: 'Pendapatan hari ini', weight: light, size: 10,),
                          ],)
                        ],
                      ),
                    
                    
                    // Cntr(
                    //   onTap: () {
                    //   },
                    //   radius: BorderRadius.circular(5),
                    //   padding: const EdgeInsets.all(10),
                    //   gradient: gradient1,
                    //   child: Txt(
                    //     text: 'Buat kode akses',
                    //     color: Colors.white,
                    //     weight: bold,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    // Image.asset('assets/icon/icon_wallet.png', height: 60,),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.security,
                    //       color: Colors.green,
                    //       size: 12,
                    //     ),
                    //     const SizedBox(
                    //       width: 5.0,
                    //     ),
                    //     Txt(
                    //       text: 'Untuk keamanan anda',
                    //       color: Colors.black,
                    //       weight: medium,
                    //       size: 10,
                    //     ),
                    //   ],
                    // ),
                    // Cntr(
                    //   height: 70,
                    //   width: 70,
                    //   image: const DecorationImage(
                    //       image: AssetImage('assets/icon/icon_wallet.png'),fit: BoxFit.cover),
                    // ),
                  ],
                ),
              )
            ]),
          ),
           for(var i=0; i< 2 ;i++)
              Cntr(
                
                onTap: () {
                  // Get.to(()=> DetailPendapatanHospital());
                },
                margin: const EdgeInsets.only(bottom: 10, left: 24, right: 24),
                radius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffE9E9E9)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                       Image.asset('assets/icon/kalender.png'),
                        const SizedBox(
                        width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                              text: 'Pendapatan Harian',
                              size: 10,
                              weight: light,
                            ),
                            const SizedBox(
                            height: 5.0,
                            ),
                            Txt(
                              text: 'Rp 600.000',
                              size: 12,
                              weight: bold,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Cntr(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      color: Colors.amber,
                      radius: BorderRadius.circular(5),
                      child: Txt(
                        text: 'Lihat rincian',
                        size: 10,
                        color: Colors.white,
                      ),
                    )
        ],))]),
      )
    );
  }
}
