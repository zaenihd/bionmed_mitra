import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../lengkapi_profil/views/sukses.dart';

class EditJadwal extends StatefulWidget {
  const EditJadwal({Key? key}) : super(key: key);

  @override
  State<EditJadwal> createState() => _EditJadwalState();
}

class _EditJadwalState extends State<EditJadwal> {
  List dataSchedul = [];
  List dataTime = [];
  List<dynamic> dataSchedulSubmit = [];

  @override
  void initState() {
    if (testC.role.value == 'nurse') {
      schedulSetNurser();
    } else if (testC.role.value == 'hospital') {
      schedulSetHospital();
    } else {
      schedulSet();
    }
    super.initState();
  }

  final controller = Get.put(LengkapiProfilController());
  final loginC = Get.put(JadwalSayaController());
  final testC = Get.put(LoginController());

  bool active = false;
  bool tambahJadwal = false;

  String timeMulai = "Mulai";
  String timeSelesai = "Selesai";
  String tambahJadwalHari = "";

  DateTime? startTime;
  DateTime? endTime;

  schedulSet() async {
    var data = await loginC.checkJadwal();
    setState(() {
      dataSchedul = data;
    });
  }

  schedulSetNurser() async {
    var data = await loginC.checkJadwalNurse();
    setState(() {
      dataSchedul = data;
    });
  }

  schedulSetHospital() async {
    var data = await loginC.checkJadwalTimHospital();
    setState(() {
      dataSchedul = data;
    });
  }

  Widget buildTimePickerMulai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm", "en_US").format(newdate);
          setState(() {
            startTime = newdate;
            timeMulai = dates;
          });
        },
        use24hFormat: true,
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
          String dates = DateFormat("HH:mm", "en_US").format(newdate);
          // if(){}
          // if(startTime.difference(newdate).inHours){}
          setState(() {
            timeSelesai = dates;
          });
        },
        use24hFormat: true,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtomGradient(
          onTap: () async {
            dataSchedulSubmit.clear();
            for (var i in dataSchedul) {
              if (i['isActive'] == true) {
                for (var x in i['schedules']) {
                  dataSchedulSubmit.add({
                    "startTime": x['startTime'],
                    "endTime": x['endTime'],
                    "day": i['days'],
                    "isActive": i['isActive']
                  });
                }
              }
            }
            if (testC.role.value == "nurse") {
              await controller.tambahJadwalNurse(scheduler: dataSchedulSubmit);
            } else if (testC.role.value == "hospital") {
              await controller.tambahJadwalHospital(
                  scheduler: dataSchedulSubmit);
            } else {
              await controller.tambahJadwal(scheduler: dataSchedulSubmit);
            }
            if (testC.isVerifikasiNurse.value == 1) {
              await Get.put(LengkapiProfilController())
                  .updateProfilNurseVerifikasi();

              Get.to(() => const Sukses());
            } else {
              Get.back();
            }
            // Get.back();
          },
          label: "Simpan",
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          InkWell(
              onTap: () {
                loginC.checkJadwalNurse();
              },
              child: Center(child: Image.asset('assets/icon/icon_jadwal.png'))),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Jadwal Praktek',
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const SizedBox(
            height: 23.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jadwal Anda',
                  textAlign: TextAlign.left,
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ],
            ),
          ),
          for (var i in dataSchedul)
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(i['days']),
                    i['isActive'] != true
                        ? InkWell(
                            onTap: () {
                              for (var x in dataSchedul) {
                                if (x['days'] == i['days']) {
                                  setState(() {
                                    x['isActive'] = true;
                                  });
                                }
                              }
                            },
                            child: Image.asset('assets/icon/jadwal_off.png'))
                        : InkWell(
                            onTap: () {
                              for (var x in dataSchedul) {
                                if (x['days'] == i['days']) {
                                  setState(() {
                                    x['isActive'] = false;
                                  });
                                }
                              }
                            },
                            child: Image.asset('assets/icon/jadwal_on.png'))
                  ],
                ),
                children: [
                  for (var e in i['schedules'])
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.timer_sharp),
                                      horizontalSpace(5),
                                      Text(e['startTime']),
                                    ],
                                  ),
                                ),
                              ),
                              const Text(":"),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.timer_sharp),
                                          horizontalSpace(5),
                                          Text(e['endTime']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(10),
                                  InkWell(
                                    onTap: () {
                                      for (int s = 0;
                                          s < i['schedules'].length;
                                          s++) {
                                        setState(() {
                                          dataTime = i['schedules'];
                                          dataTime.remove(e);
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete_outlined,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  // ignore: prefer_const_constructors
                  Divider(
                    color: AppColor.bodyColor,
                  ),
                  if (i['days'] == tambahJadwalHari)
                    Visibility(
                      visible: tambahJadwal == true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              buildTimePickerMulai(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Pilih Jam'),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.timer_sharp),
                                          horizontalSpace(5),
                                          Text(timeMulai.isEmpty
                                              ? "Mulai"
                                              : timeMulai),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(":"),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  buildTimePickerSelesai(),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      var timeMulaiCek =
                                                          timeMulai.substring(
                                                              0, 2);
                                                      var timesBerakhirCek =
                                                          timeSelesai.substring(
                                                              0, 2);
                                                      if (int.parse(
                                                                  timeMulaiCek) >
                                                              int.parse(
                                                                  timesBerakhirCek) ||
                                                          int.parse(timeMulaiCek) ==
                                                                  int.parse(
                                                                      timesBerakhirCek) &&
                                                              int.parse(timeMulai
                                                                      .substring(
                                                                          3,
                                                                          5)) >
                                                                  int.parse(timeSelesai
                                                                      .substring(
                                                                          3,
                                                                          5))) {
                                                        Get.defaultDialog(
                                                            title:
                                                                "Terjadi Kesalahan",
                                                            middleText:
                                                                "Mohon Pilih Jam\n Setelah Jam Mulai");
                                                      } else {
                                                        // if(int.parse(
                                                        //       timeMulaiCek) <
                                                        //   int.parse(
                                                        //       timesBerakhirCek) ){

                                                        //       }
                                                        if (timeMulai !=
                                                                "Mulai" &&
                                                            timeSelesai !=
                                                                "Selesai") {
                                                          for (var x
                                                              in dataSchedul) {
                                                            if (x['days'] ==
                                                                i['days']) {
                                                              setState(() {
                                                                List
                                                                    dataJadwal =
                                                                    x['schedules'];
                                                                tambahJadwal =
                                                                    false;
                                                                dataJadwal.add({
                                                                  "startTime":
                                                                      timeMulai,
                                                                  "endTime":
                                                                      timeSelesai,
                                                                  "isActive":
                                                                      true
                                                                });
                                                              });
                                                            }
                                                          }
                                                        } else {
                                                          showPopUp(
                                                              description:
                                                                  "Harap masukkan jam mulai dan selesai",
                                                              onTap: () {});
                                                        }
                                                        Get.back();
                                                      }
                                                    },
                                                    child: const Text('Simpan'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.timer_sharp),
                                              horizontalSpace(5),
                                              Text(timeSelesai.isEmpty
                                                  ? 'Selesai'
                                                  : timeSelesai),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: tambahJadwal != true,
                          child: InkWell(
                            onTap: () {
                              for (var x in dataSchedul) {
                                if (x['days'] == i['days']) {
                                  setState(() {
                                    timeMulai = "Mulai";
                                    timeSelesai = "Selesai";
                                    tambahJadwalHari = i['days'];
                                    tambahJadwal = true;
                                  });
                                }
                              }
                            },
                            child: i['schedules'].toString() == "[]"
                                ? Text(
                                    "+  Buat jadwal",
                                    style: TextStyles.subtitle3
                                        .copyWith(color: AppColor.greenColor),
                                  )
                                : Text(
                                    "+  Tambah jadwal",
                                    style: TextStyles.subtitle3
                                        .copyWith(color: AppColor.greenColor),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      )),
    );
  }
}
