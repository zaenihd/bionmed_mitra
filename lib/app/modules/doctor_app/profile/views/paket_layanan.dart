import 'package:bionmed/app/modules/doctor_app/profile/controllers/paket_layanan_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/pengaturan_akun.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaketLayanan extends StatelessWidget {
  final myC = Get.put(PaketLayananController());

   PaketLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    myC.getDataService();
    return Scaffold(
        appBar: appbarGradient('Paket Layanan'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child:Obx(()=>
            myC.isLoading.isTrue ? loadingIndicator() : 
             ListView.builder(
              itemCount: myC.datService.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom : 10.0),
                child: EditProfileWidget(
                  imageUrl: Image.network(myC.datService[index]['icon'], width: 40,height: 50,),
                  title: '${myC.datService[index]['name']}',
                  subtitle:
                      'Tambahkan paket baru, atau ubah\npaket yang sudah ada',
                  onTap: () {
                    myC.idService.value = myC.datService[index]['id'];
                    // myC.nameService.value = myC.datService[index]['name'];
                    myC.serviceName.value = myC.datService[index]['service']['name'];
                    
                    Get.toNamed(Routes.PROFILE_PAKET_LAYANAN);

                    // Get.to(() => const EditProfile());
                  },
                ),)
              ),
            )
            // Column(
            //       children: [
            //         EditProfileWidget(
            //           imageUrl: 'assets/icon/icon_chat.png',
            //           title: 'Paket Layanan Chat',
            //           subtitle: 'Tambahkan paket baru, atau ubah\npaket yang sudah ada',
            //           onTap: () {
            //             Get.toNamed(Routes.PROFILE_PAKET_LAYANAN);
            //           },
            //         ),
            //         const SizedBox(
            //         height: 16.0,
            //         ),

            //         const SizedBox(
            //         height: 16.0,
            //         ),
            //         EditProfileWidget(
            //           imageUrl: 'assets/icon/icon_vcall.png',
            //           title: 'Paket Layanan Video Call',
            //           subtitle: 'Tambahkan paket baru, atau ubah\npaket yang sudah ada',
            //           onTap: () {
            //             Get.toNamed(Routes.PROFILE_PAKET_LAYANAN_VCALL);

            //           },
            //         ),
            //         const SizedBox(
            //         height: 16.0,
            //         ),
            //         ]),
            ));
  }
}
