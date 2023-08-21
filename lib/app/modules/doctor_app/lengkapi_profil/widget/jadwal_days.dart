import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme.dart';

// ignore: must_be_immutable
class JadwalDaysWidget extends StatelessWidget {
  JadwalDaysWidget({
    super.key,
    required this.day,
    required this.textMulai,
    required this.textSelesai,
    required this.timeMulai,
    required this.timeSelesai,
  });

  String day;
  Widget textMulai;
  Widget textSelesai;
  Function() timeMulai;
  Function() timeSelesai;

  final controller = Get.put(LengkapiProfilController());

  Widget buildTimePickerMulai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          // ignore: unused_local_variable
          String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
          String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
          // controller.timesMulai.value = dates.toString();
          controller.timesMulaiUI.value = datesUi.toString();
          controller.timesMulaiUISelasa.value = datesUi.toString();
          controller.timesMulaiUIRabu.value = datesUi.toString();
          controller.timesMulaiUIKamis.value = datesUi.toString();
          controller.timesMulaiUIJumat.value = datesUi.toString();
          controller.timesMulaiUISabtu.value = datesUi.toString();
          controller.timesMulaiUIMinggu.value = datesUi.toString();
        },
        use24hFormat: false,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  Widget buildTimePickerSelesai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          // ignore: unused_local_variable
          String dates = DateFormat("HH:mm:ss", "en_US").format(newdate);
          String datesUi = DateFormat("HH:mm", "en_US").format(newdate);
          // controller.timesBerakhir.value = dates.toString();
          controller.timesBerakhirUI.value = datesUi.toString();
          controller.timesBerakhirUISelasa.value = datesUi.toString();
          controller.timesBerakhirUIRabu.value = datesUi.toString();
          controller.timesBerakhirUIKamis.value = datesUi.toString();
          controller.timesBerakhirUIJumat.value = datesUi.toString();
          controller.timesBerakhirUISabtu.value = datesUi.toString();
          controller.timesBerakhirUIMinggu.value = datesUi.toString();
        },
        use24hFormat: false,
        // maximumDate: new DateTime(2050, 12, 30),
        // minimumYear: 2010,
        // maximumYear: 2018,
        // minuteInterval: 1,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            Obx(() => controller.active.isFalse
                ? InkWell(
                    onTap: () {
                      controller.active.value = true;
                    },
                    child: Image.asset('assets/icon/jadwal_off.png'))
                : InkWell(
                    onTap: () {
                      controller.active.value = false;
                    },
                    child: Image.asset('assets/icon/jadwal_on.png')))
          ],
        ),
        Obx(
          () => controller.active.isTrue
              ? Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: timeMulai,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Get.width / 3.5,
                            decoration: BoxDecoration(
                                border: Border.all(color: buttonColor!)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: buttonColor,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                textMulai
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(':'),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: timeSelesai,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Get.width / 3.5,
                            decoration: BoxDecoration(
                                border: Border.all(color: buttonColor!)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: buttonColor,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                textSelesai
                              ],
                            ),
                          ),
                        ),
                      ]),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
