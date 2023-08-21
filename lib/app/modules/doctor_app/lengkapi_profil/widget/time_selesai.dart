// import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// Widget buildTimeSelesaiSenin() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUI.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
//   //Selasa
// Widget buildTimeSelesaiSelasa() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUISelasa.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
// Widget buildTimeSelesaiRabu() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUIRabu.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
// Widget buildTimeSelesaiKamis() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUIKamis.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
// Widget buildTimeSelesaiJumat() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUIJumat.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
// Widget buildTimeSelesaiSabtu() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUISabtu.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }
// Widget buildTimeSelesaiMinggu() {
//     return Container(
//       height: Get.height / 3,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime newdate) {
//           String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
//           String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
//           print("biasa" + dates);
//           print("tampilan" + datesUi);
//           // controller.timesMulai.value = dates.toString();
//           Get.find<LengkapiProfilController>().timesBerakhirUIMinggu.value = datesUi.toString();
//         },
//         use24hFormat: true,
//         // maximumDate: new DateTime(2050, 12, 30),
//         // minimumYear: 2010,
//         // maximumYear: 2018,
//         // minuteInterval: 1,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }