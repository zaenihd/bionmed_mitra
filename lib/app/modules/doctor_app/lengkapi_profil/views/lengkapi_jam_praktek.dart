// import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/widget/time_mulai.dart';
// import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/widget/time_selesai.dart';
// import 'package:bionmed/app/widget/appbar/appbar_back.dart';
// import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
// import 'package:bionmed/theme.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../../../../widget/button/button_gradien.dart';
// import '../controllers/lengkapi_profil_controller.dart';

// class LengkapiJamPraktek extends GetView<LengkapiProfilController> {
//   const LengkapiJamPraktek({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbarBack(),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: SingleChildScrollView(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Image.asset('assets/icon/icon_jadwal.png'),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Text(
//               'Jadwal Praktek',
//               style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 14.0,
//             ),
//             Text(
//               'Jadwal',
//               style: subtitleTextStyle,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             Image.asset('assets/icon/stepper3.png'),
//             const SizedBox(
//               height: 23.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Jadwal Anda',
//                   textAlign: TextAlign.left,
//                   style: blackTextStyle.copyWith(fontWeight: bold),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16.0,
//             ),
//             //SENIN
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Senin",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.active.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.active.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.active.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.active.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Row(
//                                   // mainAxisAlignment:
//                                   //     MainAxisAlignment.spaceAround,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         showModalBottomSheet(
//                                             isDismissible: false,
//                                             context: context,
//                                             builder: (context) {
//                                               return Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: <Widget>[
//                                                   buildTimePickerMulai(),
//                                                   ElevatedButton(
//                                                     onPressed: () {
//                                                       Get.back();
//                                                     },
//                                                     child: const Text('Ok'),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10.0,
//                                                   ),
//                                                 ],
//                                               );
//                                             });
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: 40,
//                                         width: Get.width / 3.5,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: buttonColor!)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.access_time_outlined,
//                                               color: buttonColor,
//                                             ),
//                                             const SizedBox(
//                                               width: 5.0,
//                                             ),
//                                             Obx(() => Text(
//                                                   controller
//                                                           .timesMulaiUI.isEmpty
//                                                       ? "Mulai"
//                                                       : "${controller.timesMulaiUI}",
//                                                   style:
//                                                       blackTextStyle.copyWith(
//                                                           color: controller
//                                                                   .timesMulaiUI
//                                                                   .isEmpty
//                                                               ? buttonColor
//                                                               : blackColor),
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 10.0,
//                                     ),
//                                     Text(':'),
//                                     const SizedBox(
//                                       width: 10.0,
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         if (controller
//                                             .timesMulaiUI.isNotEmpty) {
//                                           showModalBottomSheet(
//                                               isDismissible: false,
//                                               context: context,
//                                               builder: (context) {
//                                                 return Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: <Widget>[
//                                                     buildTimeSelesaiSenin(),
//                                                     ElevatedButton(
//                                                       onPressed: () {
//                                                         var timeMulai =
//                                                             controller
//                                                                 .timesMulaiUI
//                                                                 .substring(
//                                                                     0, 2);
//                                                         print('Cekkk' +
//                                                             timeMulai
//                                                                 .toString());
//                                                         var timesBerakhir =
//                                                             controller
//                                                                 .timesBerakhirUI
//                                                                 .substring(
//                                                                     0, 2);
//                                                         print('Cekkk' +
//                                                             timesBerakhir
//                                                                 .toString());
//                                                         if (int.parse(
//                                                                 timeMulai) <=
//                                                             int.parse(
//                                                                 timesBerakhir)) {
//                                                           // controller.listJadwal
//                                                           //     .add({
//                                                           //   "startTime":
//                                                           //       controller
//                                                           //           .timesMulaiUI
//                                                           //           .value,
//                                                           //   "endTime": controller
//                                                           //       .timesBerakhirUI
//                                                           //       .value,
//                                                           //   "day": "Senin",
//                                                           //   "isActive": true
//                                                           // });
//                                                           Get.back();
//                                                           print('data masuk');
//                                                           // Get.back();
//                                                         } else {
//                                                           Get.defaultDialog(
//                                                               title:
//                                                                   "Terjadi Kesalahan",
//                                                               middleText:
//                                                                   "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                         }
//                                                         // controller.listJadwal
//                                                         //     .add({
//                                                         //   "startTime":
//                                                         //       controller
//                                                         //           .timesMulaiUI
//                                                         //           .value,
//                                                         //   "endTime": controller
//                                                         //       .timesBerakhirUI
//                                                         //       .value,
//                                                         //   "day": "Senin",
//                                                         //   "isActive": true
//                                                         // });

//                                                         // print(controller
//                                                         //     .listJadwal
//                                                         //     .toString());
//                                                       },
//                                                       child: const Text('Ok'),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 10.0,
//                                                     ),
//                                                   ],
//                                                 );
//                                               });
//                                         }
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: 40,
//                                         width: Get.width / 3.5,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: buttonColor!)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.access_time_outlined,
//                                               color: buttonColor,
//                                             ),
//                                             const SizedBox(
//                                               width: 5.0,
//                                             ),
//                                             Obx(() => Text(
//                                                   controller.timesBerakhirUI
//                                                           .isEmpty
//                                                       ? "Selesai"
//                                                       : "${controller.timesBerakhirUI}",
//                                                   style: blackTextStyle.copyWith(
//                                                       color: controller
//                                                               .timesBerakhirUI
//                                                               .isEmpty
//                                                           ? buttonColor
//                                                           : blackColor),
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         onPressed: () {
//                                           if (controller.timesMulaiUI.isEmpty ||
//                                               controller
//                                                   .timesBerakhirUI.isEmpty) {
//                                             Get.defaultDialog(
//                                                 title: "Terjadi Kesalahan",
//                                                 middleText:
//                                                     "Mohon Lengkapi Jam Terlebih Dahulu");
//                                           } else {
//                                             controller.jadwalSenin.add({
//                                               "startTime":
//                                                   controller.timesMulaiUI.value,
//                                               "endTime": controller
//                                                   .timesBerakhirUI.value,
//                                               "day": "Senin",
//                                               "isActive": true
//                                             });

//                                             // controller.jadwalSenin
//                                             //     .add(controller.listJadwal);
//                                             controller.timesMulaiUI.value = '';
//                                             controller.timesBerakhirUI.value =
//                                                 '';
//                                           }
//                                           print('object' +
//                                               controller.jadwalSenin
//                                                   .toString());
//                                         },
//                                         icon: Icon(Icons.add))
//                                   ]),
//                               const SizedBox(
//                                 height: 10.0,
//                               ),
//                               Obx(
//                                 () => controller.jadwalSenin.isEmpty
//                                     ? const SizedBox(
//                                         height: 1.0,
//                                       )
//                                     : SizedBox(
//                                         height: 100.0,
//                                         child: ListView.builder(
//                                           itemCount:
//                                               controller.jadwalSenin.length,
//                                           itemBuilder: (context, index) =>
//                                               Row(children: [
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 40,
//                                               width: Get.width / 3.5,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: buttonColor!)),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.access_time_outlined,
//                                                     color: buttonColor,
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 5.0,
//                                                   ),
//                                                   Obx(() => Text(
//                                                         '${controller.jadwalSenin[index]['startTime']}',
//                                                         style: blackTextStyle
//                                                             .copyWith(
//                                                                 color:
//                                                                     blackColor),
//                                                       ))
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 10.0,
//                                             ),
//                                             Text(':'),
//                                             const SizedBox(
//                                               width: 10.0,
//                                             ),
//                                             Container(
//                                               alignment: Alignment.center,
//                                               height: 40,
//                                               width: Get.width / 3.5,
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: buttonColor!)),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.access_time_outlined,
//                                                     color: buttonColor,
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 5.0,
//                                                   ),
//                                                   Obx(() => Text(
//                                                         '${controller.jadwalSenin[index]['endTime']}',
//                                                         // controller
//                                                         //         .timesBerakhirUI
//                                                         //         .isEmpty
//                                                         //     ? "Selesai"
//                                                         //     : "${controller.timesBerakhirUI}",
//                                                         style: blackTextStyle
//                                                             .copyWith(
//                                                                 color:
//                                                                     blackColor),
//                                                       )),
//                                                 ],
//                                               ),
//                                             ),
//                                             IconButton(
//                                                 onPressed: () {
//                                                   controller.jadwalSenin
//                                                       .removeAt(index);
//                                                   // controller.listJadwal.removeAt(index);
//                                                 },
//                                                 icon: Icon(Icons.remove))
//                                           ]),
//                                         )),
//                               )
//                             ],
//                           ),
//                         )
//                       : const SizedBox(),
//                 )
//               ],
//             ),
//             //SELASA
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Selasa",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeSelasa.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeSelasa.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeSelasa.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeSelasa.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiSelasa(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesMulaiUISelasa
//                                                       .isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUISelasa}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUISelasa
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUISelasa.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiSelasa(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUISelasa
//                                                         .substring(0, 2);
//                                                     // print( 'Cekkk' + timeMulai.toString());
//                                                     var timesBerakhir = controller
//                                                         .timesBerakhirUISelasa
//                                                         .substring(0, 2);
//                                                     // print( 'Cekkk' + timesBerakhir.toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUISelasa
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUISelasa
//                                                       //       .value,
//                                                       //   "day": "Selasa",
//                                                       //   "isActive": true
//                                                       // });
//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                     print(controller.listJadwal
//                                                         .toString());
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUISelasa
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUISelasa}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUISelasa
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller
//                                               .timesMulaiUISelasa.isEmpty ||
//                                           controller
//                                               .timesBerakhirUISelasa.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalSelasa.add({
//                                           "startTime": controller
//                                               .timesMulaiUISelasa.value,
//                                           "endTime": controller
//                                               .timesBerakhirUISelasa.value,
//                                           "day": "Selasa",
//                                           "isActive": true
//                                         });
//                                         controller.timesMulaiUISelasa.value =
//                                             '';
//                                         controller.timesBerakhirUISelasa.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalSelasa.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Obx(
//                   () => controller.jadwalSelasa.isEmpty
//                       ? const SizedBox(
//                           height: 1.0,
//                         )
//                       : SizedBox(
//                           height: 100.0,
//                           child: ListView.builder(
//                             itemCount: controller.jadwalSelasa.length,
//                             itemBuilder: (context, index) => Row(children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 19),
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalSelasa[index]['startTime']}',
//                                           // controller.timesMulaiUI
//                                           //         .isEmpty
//                                           //     ? "Mulai"
//                                           //     : "${controller.timesMulaiUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Text(':'),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalSelasa[index]['endTime']}',
//                                           // controller
//                                           //         .timesBerakhirUI
//                                           //         .isEmpty
//                                           //     ? "Selesai"
//                                           //     : "${controller.timesBerakhirUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     controller.jadwalSelasa.removeAt(index);
//                                     // controller.listJadwal.removeAt(index);
//                                   },
//                                   icon: Icon(Icons.remove))
//                             ]),
//                           )),
//                 )
//               ],
//             ),
//             //RABU
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Rabu",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeRabu.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeRabu.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeRabu.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeRabu.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiRabu(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller
//                                                       .timesMulaiUIRabu.isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUIRabu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUIRabu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUIRabu.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiRabu(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUIRabu
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timeMulai.toString());
//                                                     var timesBerakhir =
//                                                         controller
//                                                             .timesBerakhirUIRabu
//                                                             .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timesBerakhir
//                                                             .toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUIRabu
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUIRabu
//                                                       //       .value,
//                                                       //   "day": "Rabu",
//                                                       //   "isActive": true
//                                                       // });
//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                     print(controller.listJadwal
//                                                         .toString());
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUIRabu
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUIRabu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUIRabu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller.timesMulaiUIRabu.isEmpty ||
//                                           controller
//                                               .timesBerakhirUIRabu.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalRabu.add({
//                                           "startTime":
//                                               controller.timesMulaiUIRabu.value,
//                                           "endTime": controller
//                                               .timesBerakhirUIRabu.value,
//                                           "day": "Rabu",
//                                           "isActive": true
//                                         });

//                                         // controller.jadwalSenin
//                                         //     .add(controller.listJadwal);
//                                         controller.timesMulaiUIRabu.value = '';
//                                         controller.timesBerakhirUIRabu.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalRabu.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 ),
//                 Obx(
//                   () => controller.jadwalRabu.isEmpty
//                       ? const SizedBox(
//                           height: 1.0,
//                         )
//                       : SizedBox(
//                           height: 100.0,
//                           child: ListView.builder(
//                             itemCount: controller.jadwalRabu.length,
//                             itemBuilder: (context, index) => Row(children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 19),
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalRabu[index]['startTime']}',
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Text(':'),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalRabu[index]['endTime']}',
//                                           // controller
//                                           //         .timesBerakhirUI
//                                           //         .isEmpty
//                                           //     ? "Selesai"
//                                           //     : "${controller.timesBerakhirUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     controller.jadwalRabu.removeAt(index);
//                                     // controller.listJadwal.removeAt(index);
//                                   },
//                                   icon: Icon(Icons.remove))
//                             ]),
//                           )),
//                 )
//               ],
//             ),
//             //KAMIS
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Kamis",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeKamis.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeKamis.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeKamis.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeKamis.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiKamis(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller
//                                                       .timesMulaiUIKamis.isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUIKamis}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUIKamis
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUIKamis.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiKamis(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUIKamis
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timeMulai.toString());
//                                                     var timesBerakhir =
//                                                         controller
//                                                             .timesBerakhirUIKamis
//                                                             .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timesBerakhir
//                                                             .toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUIKamis
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUIKamis
//                                                       //       .value,
//                                                       //   "day": "Kamis",
//                                                       //   "isActive": true
//                                                       // });

//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUIKamis
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUIKamis}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUIKamis
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller
//                                               .timesMulaiUIKamis.isEmpty ||
//                                           controller
//                                               .timesBerakhirUIKamis.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalKamis.add({
//                                           "startTime": controller
//                                               .timesMulaiUIKamis.value,
//                                           "endTime": controller
//                                               .timesBerakhirUIKamis.value,
//                                           "day": "Kamis",
//                                           "isActive": true
//                                         });

//                                         // controller.jadwalSenin
//                                         //     .add(controller.listJadwal);
//                                         controller.timesMulaiUIKamis.value = '';
//                                         controller.timesBerakhirUIKamis.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalKamis.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 ),
//                 Obx(
//                   () => controller.jadwalKamis.isEmpty
//                       ? const SizedBox(
//                           height: 1.0,
//                         )
//                       : SizedBox(
//                           height: 100.0,
//                           child: ListView.builder(
//                             itemCount: controller.jadwalKamis.length,
//                             itemBuilder: (context, index) => Row(children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 19),
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalKamis[index]['startTime']}',
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Text(':'),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalKamis[index]['endTime']}',
//                                           // controller
//                                           //         .timesBerakhirUI
//                                           //         .isEmpty
//                                           //     ? "Selesai"
//                                           //     : "${controller.timesBerakhirUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     controller.jadwalKamis.removeAt(index);
//                                     // controller.listJadwal.removeAt(index);
//                                   },
//                                   icon: Icon(Icons.remove))
//                             ]),
//                           )),
//                 )
//               ],
//             ),
//             //JUMAT
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Jum'at",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeJumat.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeJumat.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeJumat.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeJumat.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiJumat(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller
//                                                       .timesMulaiUIJumat.isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUIJumat}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUIJumat
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUIJumat.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiJumat(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUIJumat
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timeMulai.toString());
//                                                     var timesBerakhir =
//                                                         controller
//                                                             .timesBerakhirUIJumat
//                                                             .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timesBerakhir
//                                                             .toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUIJumat
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUIJumat
//                                                       //       .value,
//                                                       //   "day": "Jumat",
//                                                       //   "isActive": true
//                                                       // });
//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUIJumat
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUIJumat}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUIJumat
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller
//                                               .timesMulaiUIJumat.isEmpty ||
//                                           controller
//                                               .timesBerakhirUIJumat.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalJumat.add({
//                                           "startTime": controller
//                                               .timesMulaiUIJumat.value,
//                                           "endTime": controller
//                                               .timesBerakhirUIJumat.value,
//                                           "day": "Jum'at",
//                                           "isActive": true
//                                         });

//                                         // controller.jadwalSenin
//                                         //     .add(controller.listJadwal);
//                                         controller.timesMulaiUIJumat.value = '';
//                                         controller.timesBerakhirUIJumat.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalJumat.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 ),
//                 Obx(
//                   () => controller.jadwalJumat.isEmpty
//                       ? const SizedBox(
//                           height: 1.0,
//                         )
//                       : SizedBox(
//                           height: 100.0,
//                           child: ListView.builder(
//                             itemCount: controller.jadwalJumat.length,
//                             itemBuilder: (context, index) => Row(children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 19),
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalJumat[index]['startTime']}',
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Text(':'),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalJumat[index]['endTime']}',
//                                           // controller
//                                           //         .timesBerakhirUI
//                                           //         .isEmpty
//                                           //     ? "Selesai"
//                                           //     : "${controller.timesBerakhirUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     controller.jadwalJumat.removeAt(index);
//                                     // controller.listJadwal.removeAt(index);
//                                   },
//                                   icon: Icon(Icons.remove))
//                             ]),
//                           )),
//                 )
//                 // SizedBox(height: 100,),
//                 // Text('sasa')
//               ],
//             ),
//             // Text('sasasjkdhkjashdkjsah')
//             //SABTU
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Sabtu",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeSabtu.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeSabtu.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeSabtu.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeSabtu.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiSabtu(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller
//                                                       .timesMulaiUISabtu.isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUISabtu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUISabtu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUISabtu.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiSabtu(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUISabtu
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timeMulai.toString());
//                                                     var timesBerakhir =
//                                                         controller
//                                                             .timesBerakhirUISabtu
//                                                             .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timesBerakhir
//                                                             .toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUISabtu
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUISabtu
//                                                       //       .value,
//                                                       //   "day": "Sabtu",
//                                                       //   "isActive": true
//                                                       // });
//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUISabtu
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUISabtu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUISabtu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller
//                                               .timesMulaiUISabtu.isEmpty ||
//                                           controller
//                                               .timesBerakhirUISabtu.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalSabtu.add({
//                                           "startTime": controller
//                                               .timesMulaiUISabtu.value,
//                                           "endTime": controller
//                                               .timesBerakhirUISabtu.value,
//                                           "day": "Sabtu",
//                                           "isActive": true
//                                         });

//                                         // controller.jadwalSenin
//                                         //     .add(controller.listJadwal);
//                                         controller.timesMulaiUISabtu.value = '';
//                                         controller.timesBerakhirUISabtu.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalSabtu.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 ),
//                 Obx(
//                   () => controller.jadwalSabtu.isEmpty
//                       ? const SizedBox(
//                           height: 1.0,
//                         )
//                       : SizedBox(
//                           height: 100.0,
//                           child: ListView.builder(
//                             itemCount: controller.jadwalSabtu.length,
//                             itemBuilder: (context, index) => Row(children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 19),
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalSabtu[index]['startTime']}',
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Text(':'),
//                               const SizedBox(
//                                 width: 10.0,
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 40,
//                                 width: Get.width / 3.5,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: buttonColor!)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_outlined,
//                                       color: buttonColor,
//                                     ),
//                                     const SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Obx(() => Text(
//                                           '${controller.jadwalSabtu[index]['endTime']}',
//                                           // controller
//                                           //         .timesBerakhirUI
//                                           //         .isEmpty
//                                           //     ? "Selesai"
//                                           //     : "${controller.timesBerakhirUI}",
//                                           style: blackTextStyle.copyWith(
//                                               color: blackColor),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     controller.jadwalSabtu.removeAt(index);
//                                     // controller.listJadwal.removeAt(index);
//                                   },
//                                   icon: Icon(Icons.remove))
//                             ]),
//                           )),
//                 )
//               ],
//             ),
//             //MINGGU
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Minggu",
//                       style: blackTextStyle.copyWith(fontSize: 16),
//                     ),
//                     Obx(() => controller.activeMinggu.isFalse
//                         ? InkWell(
//                             onTap: () {
//                               controller.activeMinggu.value = true;
//                             },
//                             child: Image.asset('assets/icon/jadwal_off.png'))
//                         : InkWell(
//                             onTap: () {
//                               controller.activeMinggu.value = false;
//                             },
//                             child: Image.asset('assets/icon/jadwal_on.png')))
//                   ],
//                 ),
//                 Obx(
//                   () => controller.activeMinggu.isTrue
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         isDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               buildTimePickerMulaiMinggu(),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: const Text('Ok'),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10.0,
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesMulaiUIMinggu
//                                                       .isEmpty
//                                                   ? "Mulai"
//                                                   : "${controller.timesMulaiUIMinggu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesMulaiUIMinggu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(':'),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     if (controller
//                                         .timesMulaiUIMinggu.isNotEmpty) {
//                                       showModalBottomSheet(
//                                           isDismissible: false,
//                                           context: context,
//                                           builder: (context) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: <Widget>[
//                                                 buildTimeSelesaiMinggu(),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     var timeMulai = controller
//                                                         .timesMulaiUIMinggu
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timeMulai.toString());
//                                                     var timesBerakhir = controller
//                                                         .timesBerakhirUIMinggu
//                                                         .substring(0, 2);
//                                                     print('Cekkk' +
//                                                         timesBerakhir
//                                                             .toString());
//                                                     if (int.parse(timeMulai) <=
//                                                         int.parse(
//                                                             timesBerakhir)) {
//                                                       // controller.listJadwal
//                                                       //     .add({
//                                                       //   "startTime": controller
//                                                       //       .timesMulaiUIMinggu
//                                                       //       .value,
//                                                       //   "endTime": controller
//                                                       //       .timesBerakhirUIMinggu
//                                                       //       .value,
//                                                       //   "day": "Minggu"
//                                                       // });
//                                                       Get.back();
//                                                     } else {
//                                                       Get.defaultDialog(
//                                                           title:
//                                                               "Terjadi Kesalahan",
//                                                           middleText:
//                                                               "Mohon Pilih Jam\n Setelah Jam Mulai");
//                                                     }
//                                                   },
//                                                   child: const Text('Ok'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10.0,
//                                                 ),
//                                               ],
//                                             );
//                                           });
//                                     }
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: Get.width / 3.5,
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: buttonColor!)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_outlined,
//                                           color: buttonColor,
//                                         ),
//                                         const SizedBox(
//                                           width: 5.0,
//                                         ),
//                                         Obx(() => Text(
//                                               controller.timesBerakhirUIMinggu
//                                                       .isEmpty
//                                                   ? "Selesai"
//                                                   : "${controller.timesBerakhirUIMinggu}",
//                                               style: blackTextStyle.copyWith(
//                                                   color: controller
//                                                           .timesBerakhirUIMinggu
//                                                           .isEmpty
//                                                       ? buttonColor
//                                                       : blackColor),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       if (controller
//                                               .timesMulaiUIMinggu.isEmpty ||
//                                           controller
//                                               .timesBerakhirUIMinggu.isEmpty) {
//                                         Get.defaultDialog(
//                                             title: "Terjadi Kesalahan",
//                                             middleText:
//                                                 "Mohon Lengkapi Jam Terlebih Dahulu");
//                                       } else {
//                                         controller.jadwalMinggu.add({
//                                           "startTime": controller
//                                               .timesMulaiUIMinggu.value,
//                                           "endTime": controller
//                                               .timesBerakhirUIMinggu.value,
//                                           "day": "Minggu",
//                                           "isActive": true
//                                         });

//                                         // controller.jadwalSenin
//                                         //     .add(controller.listJadwal);
//                                         controller.timesMulaiUIMinggu.value =
//                                             '';
//                                         controller.timesBerakhirUIMinggu.value =
//                                             '';
//                                       }
//                                       print('object' +
//                                           controller.jadwalMinggu.toString());
//                                     },
//                                     icon: Icon(Icons.add))
//                               ]),
//                         )
//                       : const SizedBox(),
//                 )
//               ],
//             ),

//             Obx(
//               () => controller.jadwalMinggu.isEmpty
//                   ? const SizedBox(
//                       height: 1.0,
//                     )
//                   : SizedBox(
//                       height: 100.0,
//                       child: ListView.builder(
//                         itemCount: controller.jadwalMinggu.length,
//                         itemBuilder: (context, index) => Row(children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 19),
//                             alignment: Alignment.center,
//                             height: 40,
//                             width: Get.width / 3.5,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: buttonColor!)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.access_time_outlined,
//                                   color: buttonColor,
//                                 ),
//                                 const SizedBox(
//                                   width: 5.0,
//                                 ),
//                                 Obx(() => Text(
//                                       '${controller.jadwalMinggu[index]['startTime']}',
//                                       style: blackTextStyle.copyWith(
//                                           color: blackColor),
//                                     ))
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10.0,
//                           ),
//                           Text(':'),
//                           const SizedBox(
//                             width: 10.0,
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 40,
//                             width: Get.width / 3.5,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: buttonColor!)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.access_time_outlined,
//                                   color: buttonColor,
//                                 ),
//                                 const SizedBox(
//                                   width: 5.0,
//                                 ),
//                                 Obx(() => Text(
//                                       '${controller.jadwalMinggu[index]['endTime']}',
//                                       // controller
//                                       //         .timesBerakhirUI
//                                       //         .isEmpty
//                                       //     ? "Selesai"
//                                       //     : "${controller.timesBerakhirUI}",
//                                       style: blackTextStyle.copyWith(
//                                           color: blackColor),
//                                     )),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 controller.jadwalMinggu.removeAt(index);
//                                 // controller.listJadwal.removeAt(index);
//                               },
//                               icon: Icon(Icons.remove))
//                         ]),
//                       )),
//             ),
//             const SizedBox(
//               height: 100.0,
//             ),
//           ]),
//         ),
//       ),
//       bottomSheet: Padding(
//           padding: const EdgeInsets.only(bottom: 24.0),
//           child: Obx(
//             () => controller.jadwalSenin.isNotEmpty ||
//                     controller.jadwalSelasa.isNotEmpty ||
//                     controller.jadwalRabu.isNotEmpty ||
//                     controller.jadwalKamis.isNotEmpty ||
//                     controller.jadwalJumat.isNotEmpty ||
//                     controller.jadwalSabtu.isNotEmpty ||
//                     controller.jadwalMinggu.isNotEmpty
//                 ? ButtomGradient(
//                     label: controller.isloading.isFalse
//                         ? 'Selesai'
//                         : "Loading....",
//                     onTap: () async {
//                       if (controller.isloading.isFalse) {
//                         controller.listJadwal.value = controller.jadwalSenin +
//                             controller.jadwalSelasa +
//                             controller.jadwalRabu +
//                             controller.jadwalKamis +
//                             controller.jadwalJumat +
//                             controller.jadwalSabtu +
//                             controller.jadwalMinggu;

//                         print('object' + controller.listJadwal.toString());
//                         // for(var i=0; i< controller.jadwalSenin.length ;i++){
//                         // // var item = items[i];
//                         RxString timesMulaiUI = ''.obs;

//                         await controller.tambahJadwal(
//                             scheduler: controller.listJadwal);
//                         // controller.timesBerakhirUI.value = '';
//                         // controller.timesMulaiUISelasa.value = '';
//                         // controller.timesBerakhirUISelasa.value = '';
//                         // controller.timesMulaiUIRabu.value = '';
//                         // controller.timesBerakhirUIRabu.value = '';
//                         // controller.timesMulaiUIKamis.value = '';
//                         // controller.timesBerakhirUIKamis.value = '';
//                         // controller.timesMulaiUIJumat.value = '';
//                         // controller.timesBerakhirUIJumat.value = '';
//                         // controller.timesMulaiUISabtu.value = '';
//                         // controller.timesBerakhirUISabtu.value = '';
//                         // controller.timesMulaiUIMinggu.value = '';
//                         // controller.timesBerakhirUIMinggu.value = '';

//                         controller.jadwalSenin.value = [];
//                         controller.jadwalSelasa.value = [];
//                         controller.jadwalRabu.value = [];
//                         controller.jadwalKamis.value = [];
//                         controller.jadwalJumat.value = [];
//                         controller.jadwalSabtu.value = [];
//                         controller.jadwalMinggu.value = [];
//                         controller.active.value = false;
//                         // }
//                         // Get.to(() => Sukses());
//                         Get.back();
//                         // print("asooooy" + controller.listJadwal.toString());
//                       }
//                     })
//                 : ButtonPrimary(
//                     title: "Selesai",
//                     onPressed: () {
//                       // Get.to(() => LengkapiTepatPraktek());
//                     }),
//           )),
//     );
//   }
// }
