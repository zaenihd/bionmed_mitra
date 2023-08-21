import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/sukses.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/edit_jadwal.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LengkapiListJadwal extends StatelessWidget {

  final myC = Get.put(JadwalSayaController());

   LengkapiListJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    myC.listService();
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom :20.0),
        child: ButtomGradient(
                      label:
                          'Selesai',
                      onTap: ()  {
                          Get.to(() => const Sukses());

                      }),
      ),
      appBar: appbarGradient('Jadwal Layanan'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 26),
        child:Obx(()=> myC.isloading.isTrue ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              myC.serviceId.value = myC.listServiceData[index]['id'];
                Get.to(() => const EditJadwal());
                    // Get.to(() => LengkapiJamPraktek());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical : 20, horizontal: 10),
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 24,
                        offset: Offset(0, 11),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        '${myC.listServiceData[index]['image']}',width: 50,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myC.listServiceData[index]['name']}",
                            // title,
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                  width: Get.width /2,
                              child: Text(
                                  "Tentukan jadwal layanan praktik anda",
                                  style: TextStyles.small1)),
                        ],
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
          ),))
         
        //  Column(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         Get.to(() => EditJadwal());
        //       },
        //       child:
        //        Container(
        //         alignment: Alignment.center,
        //         padding: const EdgeInsets.symmetric(vertical : 20, horizontal: 10),

        //         width: Get.width,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: whiteColor,
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Color(0x19000000),
        //               blurRadius: 24,
        //               offset: Offset(0, 11),
        //             ),
        //           ],
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Image.asset(
        //               'assets/icon/iconJadwal.png',
        //             ),
        //             const SizedBox(
        //               width: 20.0,
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Telemedicine",
        //                   // title,
        //                   style: blackTextStyle.copyWith(
        //                       fontSize: 16, fontWeight: bold),
        //                 ),
        //                 const SizedBox(
        //                   height: 4,
        //                 ),
        //                 SizedBox(
        //         width: Get.width /2,

        //                     child: Text(
        //                         "Tentukan jadwal layanan praktik anda",
        //                         style: TextStyles.small1)),
        //               ],
        //             ),
        //             const SizedBox(
        //               width: 15.0,
        //             ),
        //             const Icon(Icons.arrow_forward_ios)
        //           ],
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 10.0,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         myC.serviceId.value = 17;
        //         showPopUp(
        //             onTap: () {
        //               Get.back();
        //             },
        //             imageAction: 'assets/json/eror.json',
        //             description: "Under Development");
        //       },
        //       child: Container(
        //         alignment: Alignment.center,
        //         padding: const EdgeInsets.symmetric(vertical : 20, horizontal: 10),
        //         width: Get.width,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: whiteColor,
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Color(0x19000000),
        //               blurRadius: 24,
        //               offset: Offset(0, 11),
        //             ),
        //           ],
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Image.asset(
        //               'assets/icon/iconJadwal2.png',
        //             ),
        //             const SizedBox(
        //               width: 20.0,
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Home Visit Doctor",
        //                   // title,
        //                   style: blackTextStyle.copyWith(
        //                       fontSize: 16, fontWeight: bold),
        //                 ),
        //                 const SizedBox(
        //                   height: 4,
        //                 ),
        //                 SizedBox(
        //         width: Get.width /2,
        //                     child: Text(
        //                         "Tentukan jadwal praktik anda, untuk layanan",
        //                         style: TextStyles.small1)),
        //               ],
        //             ),
        //             const SizedBox(
        //               width: 15.0,
        //             ),
        //             const Icon(Icons.arrow_forward_ios)
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
