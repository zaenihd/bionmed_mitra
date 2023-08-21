// import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// Widget buildTimePickerMulai() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUI.value = datesUi.toString();
//           // Get.find<LengkapiProfilController>().timeStart.add(datesUi.toString());
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
// Widget buildTimePickerMulaiSelasa() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUISelasa.value = datesUi.toString();
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
// Widget buildTimePickerMulaiRabu() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUIRabu.value = datesUi.toString();
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
// Widget buildTimePickerMulaiKamis() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUIKamis.value = datesUi.toString();
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
// Widget buildTimePickerMulaiJumat() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUIJumat.value = datesUi.toString();
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
// Widget buildTimePickerMulaiSabtu() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUISabtu.value = datesUi.toString();
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
// Widget buildTimePickerMulaiMinggu() {
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
//           Get.find<LengkapiProfilController>().timesMulaiUIMinggu.value = datesUi.toString();
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