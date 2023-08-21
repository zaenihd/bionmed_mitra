import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/views/sukses.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditJadwalNurse extends StatefulWidget {
  const EditJadwalNurse({Key? key}) : super(key: key);

  @override
  State<EditJadwalNurse> createState() => _EditJadwalNurseState();
}

class _EditJadwalNurseState extends State<EditJadwalNurse> {
  List dataSchedul = [];
  List dataTime = [];
  List<dynamic> dataSchedulSubmit = [];

  @override
  void initState() {
    // if(testC.role.value == 'nurse'){
      // schedulSetNurser();
    // }else{

    // }
    schedulSet();
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
          onTap: () async{
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
            if(testC.role.value == "nurse"){
           await controller.tambahJadwalNurse(scheduler: dataSchedulSubmit);
            }else{
            controller.tambahJadwal(scheduler: dataSchedulSubmit);
            }
            if(testC.isVerifikasiNurse.value == 1){
              Get.to(()=>const Sukses());
            }else{
            Get.back();
            }

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
                                                              timesBerakhirCek) || int.parse(
                                                              timeMulaiCek) ==
                                                          int.parse(
                                                              timesBerakhirCek) &&  int.parse(
                                                              timeMulai.substring(3,5)) >
                                                          int.parse(
                                                              timeSelesai.substring(3,5))) {
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
                        // Visibility(
                        //   visible: tambahJadwal == true,
                        //   child: InkWell(
                        //     onTap: () {
                        //       // if (timeMulai != "Mulai" &&
                        //       //     timeSelesai != "Selesai") {
                        //       //   for (var x in dataSchedul) {
                        //       //     if (x['days'] == i['days']) {
                        //       //       setState(() {
                        //       //         List dataJadwal = x['schedules'];
                        //       //         tambahJadwal = false;
                        //       //         dataJadwal.add({
                        //       //           "startTime": timeMulai,
                        //       //           "endTime": timeSelesai,
                        //       //           "isActive": true
                        //       //         });
                        //       //       });
                        //       //     }
                        //       //   }
                        //       // } else {
                        //       //   showPopUp(
                        //       //       description:
                        //       //           "Harap masukkan jam mulai dan selesai",
                        //       //       onTap: () {});
                        //       // }
                        //     },
                        //     child: Text(
                        //       "Simpan",
                        //       style: TextStyles.subtitle3
                        //           .copyWith(color: AppColor.bluePrimary),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      )),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 24),
      //   child: SingleChildScrollView(
      //     child:
      //         Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //       Image.asset('assets/icon/icon_jadwal.png'),
      //       const SizedBox(
      //         height: 10.0,
      //       ),
      //       Text(
      //         'Jadwal Praktek',
      //         style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
      //         textAlign: TextAlign.center,
      //       ),
      //       const SizedBox(
      //         height: 14.0,
      //       ),
      //       Text(
      //         'Jadwal',
      //         style: subtitleTextStyle,
      //         textAlign: TextAlign.center,
      //       ),
      //       const SizedBox(
      //         height: 30.0,
      //       ),
      //       const SizedBox(
      //         height: 23.0,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             'Jadwal Anda',
      //             textAlign: TextAlign.left,
      //             style: blackTextStyle.copyWith(fontWeight: bold),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(
      //         height: 16.0,
      //       ),
      //       //SENIN
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Senin",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.active.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.active.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.active.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.active.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.end,
      //                       children: [
      //                         Row(
      //                             // mainAxisAlignment:
      //                             //     MainAxisAlignment.spaceAround,
      //                             children: [
      //                               InkWell(
      //                                 onTap: () {
      //                                   showModalBottomSheet(
      //                                       isDismissible: false,
      //                                       context: context,
      //                                       builder: (context) {
      //                                         return Column(
      //                                           mainAxisSize: MainAxisSize.min,
      //                                           children: <Widget>[
      //                                             buildTimePickerMulai(),
      //                                             ElevatedButton(
      //                                               onPressed: () {
      //                                                 Get.back();
      //                                               },
      //                                               child: const Text('Ok'),
      //                                             ),
      //                                             const SizedBox(
      //                                               height: 10.0,
      //                                             ),
      //                                           ],
      //                                         );
      //                                       });
      //                                 },
      //                                 child: Container(
      //                                   alignment: Alignment.center,
      //                                   height: 40,
      //                                   width: Get.width / 3.5,
      //                                   decoration: BoxDecoration(
      //                                       border: Border.all(
      //                                           color: buttonColor!)),
      //                                   child: Row(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.center,
      //                                     children: [
      //                                       Icon(
      //                                         Icons.access_time_outlined,
      //                                         color: buttonColor,
      //                                       ),
      //                                       const SizedBox(
      //                                         width: 5.0,
      //                                       ),
      //                                       Obx(() => Text(
      //                                             controller
      //                                                     .timesMulaiUI.isEmpty
      //                                                 ? "Mulai"
      //                                                 : "${controller.timesMulaiUI}",
      //                                             style:
      //                                                 blackTextStyle.copyWith(
      //                                                     color: controller
      //                                                             .timesMulaiUI
      //                                                             .isEmpty
      //                                                         ? buttonColor
      //                                                         : blackColor),
      //                                           ))
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                               const SizedBox(
      //                                 width: 10.0,
      //                               ),
      //                               Text(':'),
      //                               const SizedBox(
      //                                 width: 10.0,
      //                               ),
      //                               InkWell(
      //                                 onTap: () {
      //                                   if (controller
      //                                       .timesMulaiUI.isNotEmpty) {
      //                                     showModalBottomSheet(
      //                                         isDismissible: false,
      //                                         context: context,
      //                                         builder: (context) {
      //                                           return Column(
      //                                             mainAxisSize:
      //                                                 MainAxisSize.min,
      //                                             children: <Widget>[
      //                                               buildTimeSelesaiSenin(),
      //                                               ElevatedButton(
      //                                                 onPressed: () {
      //                                                   var timeMulai =
      //                                                       controller
      //                                                           .timesMulaiUI
      //                                                           .substring(
      //                                                               0, 2);
      //                                                   print('Cekkk' +
      //                                                       timeMulai
      //                                                           .toString());
      //                                                   var timesBerakhir =
      //                                                       controller
      //                                                           .timesBerakhirUI
      //                                                           .substring(
      //                                                               0, 2);
      //                                                   print('Cekkk' +
      //                                                       timesBerakhir
      //                                                           .toString());
      //                                                   if (int.parse(
      //                                                           timeMulai) <=
      //                                                       int.parse(
      //                                                           timesBerakhir)) {
      //                                                     // controller.listJadwal
      //                                                     //     .add({
      //                                                     //   "startTime":
      //                                                     //       controller
      //                                                     //           .timesMulaiUI
      //                                                     //           .value,
      //                                                     //   "endTime": controller
      //                                                     //       .timesBerakhirUI
      //                                                     //       .value,
      //                                                     //   "day": "Senin",
      //                                                     //   "isActive": true
      //                                                     // });
      //                                                     Get.back();
      //                                                     print('data masuk');
      //                                                     // Get.back();
      //                                                   } else {
      //                                                     Get.defaultDialog(
      //                                                         title:
      //                                                             "Terjadi Kesalahan",
      //                                                         middleText:
      //                                                             "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                                   }
      //                                                   // controller.listJadwal
      //                                                   //     .add({
      //                                                   //   "startTime":
      //                                                   //       controller
      //                                                   //           .timesMulaiUI
      //                                                   //           .value,
      //                                                   //   "endTime": controller
      //                                                   //       .timesBerakhirUI
      //                                                   //       .value,
      //                                                   //   "day": "Senin",
      //                                                   //   "isActive": true
      //                                                   // });

      //                                                   // print(controller
      //                                                   //     .listJadwal
      //                                                   //     .toString());
      //                                                 },
      //                                                 child: const Text('Ok'),
      //                                               ),
      //                                               const SizedBox(
      //                                                 height: 10.0,
      //                                               ),
      //                                             ],
      //                                           );
      //                                         });
      //                                   }
      //                                 },
      //                                 child: Container(
      //                                   alignment: Alignment.center,
      //                                   height: 40,
      //                                   width: Get.width / 3.5,
      //                                   decoration: BoxDecoration(
      //                                       border: Border.all(
      //                                           color: buttonColor!)),
      //                                   child: Row(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.center,
      //                                     children: [
      //                                       Icon(
      //                                         Icons.access_time_outlined,
      //                                         color: buttonColor,
      //                                       ),
      //                                       const SizedBox(
      //                                         width: 5.0,
      //                                       ),
      //                                       Obx(() => Text(
      //                                             controller.timesBerakhirUI
      //                                                     .isEmpty
      //                                                 ? "Selesai"
      //                                                 : "${controller.timesBerakhirUI}",
      //                                             style: blackTextStyle.copyWith(
      //                                                 color: controller
      //                                                         .timesBerakhirUI
      //                                                         .isEmpty
      //                                                     ? buttonColor
      //                                                     : blackColor),
      //                                           ))
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                               IconButton(
      //                                   onPressed: () {
      //                                     if (controller.timesMulaiUI.isEmpty ||
      //                                         controller
      //                                             .timesBerakhirUI.isEmpty) {
      //                                       Get.defaultDialog(
      //                                           title: "Terjadi Kesalahan",
      //                                           middleText:
      //                                               "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                     } else {
      //                                       controller.jadwalSenin.add({
      //                                         "startTime":
      //                                             controller.timesMulaiUI.value,
      //                                         "endTime": controller
      //                                             .timesBerakhirUI.value,
      //                                         "day": "Senin",
      //                                         "isActive": true
      //                                       });

      //                                       // controller.jadwalSenin
      //                                       //     .add(controller.listJadwal);
      //                                       controller.timesMulaiUI.value = '';
      //                                       controller.timesBerakhirUI.value =
      //                                           '';
      //                                     }
      //                                     print('object' +
      //                                         controller.jadwalSenin
      //                                             .toString());
      //                                   },
      //                                   icon: Icon(Icons.add))
      //                             ]),
      //                         const SizedBox(
      //                           height: 10.0,
      //                         ),
      //                         Obx(
      //                           () => controller.jadwalSenin.isEmpty
      //                               ? const SizedBox(
      //                                   height: 1.0,
      //                                 )
      //                               : SizedBox(
      //                                   height: 100.0,
      //                                   child: ListView.builder(
      //                                     itemCount:
      //                                         controller.jadwalSenin.length,
      //                                     itemBuilder: (context, index) =>
      //                                         Row(children: [
      //                                       Container(
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
      //                                                   '${controller.jadwalSenin[index]['startTime']}',
      //                                                   style: blackTextStyle
      //                                                       .copyWith(
      //                                                           color:
      //                                                               blackColor),
      //                                                 ))
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       const SizedBox(
      //                                         width: 10.0,
      //                                       ),
      //                                       Text(':'),
      //                                       const SizedBox(
      //                                         width: 10.0,
      //                                       ),
      //                                       Container(
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
      //                                                   '${controller.jadwalSenin[index]['endTime']}',
      //                                                   // controller
      //                                                   //         .timesBerakhirUI
      //                                                   //         .isEmpty
      //                                                   //     ? "Selesai"
      //                                                   //     : "${controller.timesBerakhirUI}",
      //                                                   style: blackTextStyle
      //                                                       .copyWith(
      //                                                           color:
      //                                                               blackColor),
      //                                                 )),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       IconButton(
      //                                           onPressed: () {
      //                                             controller.jadwalSenin
      //                                                 .removeAt(index);
      //                                             // controller.listJadwal.removeAt(index);
      //                                           },
      //                                           icon: Icon(Icons.remove))
      //                                     ]),
      //                                   )),
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 : const SizedBox(),
      //           )
      //         ],
      //       ),
      //       //SELASA
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Selasa",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeSelasa.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeSelasa.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeSelasa.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeSelasa.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiSelasa(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesMulaiUISelasa
      //                                                 .isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUISelasa}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUISelasa
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUISelasa.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiSelasa(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUISelasa
      //                                                   .substring(0, 2);
      //                                               // print( 'Cekkk' + timeMulai.toString());
      //                                               var timesBerakhir = controller
      //                                                   .timesBerakhirUISelasa
      //                                                   .substring(0, 2);
      //                                               // print( 'Cekkk' + timesBerakhir.toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUISelasa
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUISelasa
      //                                                 //       .value,
      //                                                 //   "day": "Selasa",
      //                                                 //   "isActive": true
      //                                                 // });
      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                               print(controller.listJadwal
      //                                                   .toString());
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUISelasa
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUISelasa}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUISelasa
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller
      //                                         .timesMulaiUISelasa.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUISelasa.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalSelasa.add({
      //                                     "startTime": controller
      //                                         .timesMulaiUISelasa.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUISelasa.value,
      //                                     "day": "Selasa",
      //                                     "isActive": true
      //                                   });
      //                                   controller.timesMulaiUISelasa.value =
      //                                       '';
      //                                   controller.timesBerakhirUISelasa.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalSelasa.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           ),
      //           const SizedBox(
      //             height: 10.0,
      //           ),
      //           Obx(
      //             () => controller.jadwalSelasa.isEmpty
      //                 ? const SizedBox(
      //                     height: 1.0,
      //                   )
      //                 : SizedBox(
      //                     height: 100.0,
      //                     child: ListView.builder(
      //                       itemCount: controller.jadwalSelasa.length,
      //                       itemBuilder: (context, index) => Row(children: [
      //                         Container(
      //                           margin: EdgeInsets.only(left: 19),
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalSelasa[index]['startTime']}',
      //                                     // controller.timesMulaiUI
      //                                     //         .isEmpty
      //                                     //     ? "Mulai"
      //                                     //     : "${controller.timesMulaiUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   ))
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Text(':'),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Container(
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalSelasa[index]['endTime']}',
      //                                     // controller
      //                                     //         .timesBerakhirUI
      //                                     //         .isEmpty
      //                                     //     ? "Selesai"
      //                                     //     : "${controller.timesBerakhirUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                         IconButton(
      //                             onPressed: () {
      //                               controller.jadwalSelasa.removeAt(index);
      //                               // controller.listJadwal.removeAt(index);
      //                             },
      //                             icon: Icon(Icons.remove))
      //                       ]),
      //                     )),
      //           )
      //         ],
      //       ),
      //       //RABU
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Rabu",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeRabu.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeRabu.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeRabu.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeRabu.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiRabu(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller
      //                                                 .timesMulaiUIRabu.isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUIRabu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUIRabu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUIRabu.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiRabu(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUIRabu
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timeMulai.toString());
      //                                               var timesBerakhir =
      //                                                   controller
      //                                                       .timesBerakhirUIRabu
      //                                                       .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timesBerakhir
      //                                                       .toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUIRabu
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUIRabu
      //                                                 //       .value,
      //                                                 //   "day": "Rabu",
      //                                                 //   "isActive": true
      //                                                 // });
      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                               print(controller.listJadwal
      //                                                   .toString());
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUIRabu
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUIRabu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUIRabu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller.timesMulaiUIRabu.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUIRabu.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalRabu.add({
      //                                     "startTime":
      //                                         controller.timesMulaiUIRabu.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUIRabu.value,
      //                                     "day": "Rabu",
      //                                     "isActive": true
      //                                   });

      //                                   // controller.jadwalSenin
      //                                   //     .add(controller.listJadwal);
      //                                   controller.timesMulaiUIRabu.value = '';
      //                                   controller.timesBerakhirUIRabu.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalRabu.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           ),
      //           Obx(
      //             () => controller.jadwalRabu.isEmpty
      //                 ? const SizedBox(
      //                     height: 1.0,
      //                   )
      //                 : SizedBox(
      //                     height: 100.0,
      //                     child: ListView.builder(
      //                       itemCount: controller.jadwalRabu.length,
      //                       itemBuilder: (context, index) => Row(children: [
      //                         Container(
      //                           margin: EdgeInsets.only(left: 19),
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalRabu[index]['startTime']}',
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   ))
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Text(':'),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Container(
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalRabu[index]['endTime']}',
      //                                     // controller
      //                                     //         .timesBerakhirUI
      //                                     //         .isEmpty
      //                                     //     ? "Selesai"
      //                                     //     : "${controller.timesBerakhirUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                         IconButton(
      //                             onPressed: () {
      //                               controller.jadwalRabu.removeAt(index);
      //                               // controller.listJadwal.removeAt(index);
      //                             },
      //                             icon: Icon(Icons.remove))
      //                       ]),
      //                     )),
      //           )
      //         ],
      //       ),
      //       //KAMIS
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Kamis",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeKamis.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeKamis.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeKamis.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeKamis.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiKamis(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller
      //                                                 .timesMulaiUIKamis.isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUIKamis}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUIKamis
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUIKamis.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiKamis(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUIKamis
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timeMulai.toString());
      //                                               var timesBerakhir =
      //                                                   controller
      //                                                       .timesBerakhirUIKamis
      //                                                       .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timesBerakhir
      //                                                       .toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUIKamis
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUIKamis
      //                                                 //       .value,
      //                                                 //   "day": "Kamis",
      //                                                 //   "isActive": true
      //                                                 // });

      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUIKamis
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUIKamis}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUIKamis
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller
      //                                         .timesMulaiUIKamis.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUIKamis.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalKamis.add({
      //                                     "startTime": controller
      //                                         .timesMulaiUIKamis.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUIKamis.value,
      //                                     "day": "Kamis",
      //                                     "isActive": true
      //                                   });

      //                                   // controller.jadwalSenin
      //                                   //     .add(controller.listJadwal);
      //                                   controller.timesMulaiUIKamis.value = '';
      //                                   controller.timesBerakhirUIKamis.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalKamis.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           ),
      //           Obx(
      //             () => controller.jadwalKamis.isEmpty
      //                 ? const SizedBox(
      //                     height: 1.0,
      //                   )
      //                 : SizedBox(
      //                     height: 100.0,
      //                     child: ListView.builder(
      //                       itemCount: controller.jadwalKamis.length,
      //                       itemBuilder: (context, index) => Row(children: [
      //                         Container(
      //                           margin: EdgeInsets.only(left: 19),
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalKamis[index]['startTime']}',
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   ))
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Text(':'),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Container(
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalKamis[index]['endTime']}',
      //                                     // controller
      //                                     //         .timesBerakhirUI
      //                                     //         .isEmpty
      //                                     //     ? "Selesai"
      //                                     //     : "${controller.timesBerakhirUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                         IconButton(
      //                             onPressed: () {
      //                               controller.jadwalKamis.removeAt(index);
      //                               // controller.listJadwal.removeAt(index);
      //                             },
      //                             icon: Icon(Icons.remove))
      //                       ]),
      //                     )),
      //           )
      //         ],
      //       ),
      //       //JUMAT
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Jum'at",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeJumat.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeJumat.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeJumat.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeJumat.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiJumat(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller
      //                                                 .timesMulaiUIJumat.isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUIJumat}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUIJumat
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUIJumat.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiJumat(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUIJumat
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timeMulai.toString());
      //                                               var timesBerakhir =
      //                                                   controller
      //                                                       .timesBerakhirUIJumat
      //                                                       .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timesBerakhir
      //                                                       .toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUIJumat
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUIJumat
      //                                                 //       .value,
      //                                                 //   "day": "Jumat",
      //                                                 //   "isActive": true
      //                                                 // });
      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUIJumat
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUIJumat}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUIJumat
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller
      //                                         .timesMulaiUIJumat.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUIJumat.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalJumat.add({
      //                                     "startTime": controller
      //                                         .timesMulaiUIJumat.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUIJumat.value,
      //                                     "day": "Jum'at",
      //                                     "isActive": true
      //                                   });

      //                                   // controller.jadwalSenin
      //                                   //     .add(controller.listJadwal);
      //                                   controller.timesMulaiUIJumat.value = '';
      //                                   controller.timesBerakhirUIJumat.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalJumat.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           ),
      //           Obx(
      //             () => controller.jadwalJumat.isEmpty
      //                 ? const SizedBox(
      //                     height: 1.0,
      //                   )
      //                 : SizedBox(
      //                     height: 100.0,
      //                     child: ListView.builder(
      //                       itemCount: controller.jadwalJumat.length,
      //                       itemBuilder: (context, index) => Row(children: [
      //                         Container(
      //                           margin: EdgeInsets.only(left: 19),
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalJumat[index]['startTime']}',
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   ))
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Text(':'),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Container(
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalJumat[index]['endTime']}',
      //                                     // controller
      //                                     //         .timesBerakhirUI
      //                                     //         .isEmpty
      //                                     //     ? "Selesai"
      //                                     //     : "${controller.timesBerakhirUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                         IconButton(
      //                             onPressed: () {
      //                               controller.jadwalJumat.removeAt(index);
      //                               // controller.listJadwal.removeAt(index);
      //                             },
      //                             icon: Icon(Icons.remove))
      //                       ]),
      //                     )),
      //           )
      //           // SizedBox(height: 100,),
      //           // Text('sasa')
      //         ],
      //       ),
      //       // Text('sasasjkdhkjashdkjsah')
      //       //SABTU
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Sabtu",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeSabtu.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeSabtu.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeSabtu.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeSabtu.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiSabtu(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller
      //                                                 .timesMulaiUISabtu.isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUISabtu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUISabtu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUISabtu.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiSabtu(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUISabtu
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timeMulai.toString());
      //                                               var timesBerakhir =
      //                                                   controller
      //                                                       .timesBerakhirUISabtu
      //                                                       .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timesBerakhir
      //                                                       .toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUISabtu
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUISabtu
      //                                                 //       .value,
      //                                                 //   "day": "Sabtu",
      //                                                 //   "isActive": true
      //                                                 // });
      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUISabtu
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUISabtu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUISabtu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller
      //                                         .timesMulaiUISabtu.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUISabtu.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalSabtu.add({
      //                                     "startTime": controller
      //                                         .timesMulaiUISabtu.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUISabtu.value,
      //                                     "day": "Sabtu",
      //                                     "isActive": true
      //                                   });

      //                                   // controller.jadwalSenin
      //                                   //     .add(controller.listJadwal);
      //                                   controller.timesMulaiUISabtu.value = '';
      //                                   controller.timesBerakhirUISabtu.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalSabtu.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           ),
      //           Obx(
      //             () => controller.jadwalSabtu.isEmpty
      //                 ? const SizedBox(
      //                     height: 1.0,
      //                   )
      //                 : SizedBox(
      //                     height: 100.0,
      //                     child: ListView.builder(
      //                       itemCount: controller.jadwalSabtu.length,
      //                       itemBuilder: (context, index) => Row(children: [
      //                         Container(
      //                           margin: EdgeInsets.only(left: 19),
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalSabtu[index]['startTime']}',
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   ))
      //                             ],
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Text(':'),
      //                         const SizedBox(
      //                           width: 10.0,
      //                         ),
      //                         Container(
      //                           alignment: Alignment.center,
      //                           height: 40,
      //                           width: Get.width / 3.5,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: buttonColor!)),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Icon(
      //                                 Icons.access_time_outlined,
      //                                 color: buttonColor,
      //                               ),
      //                               const SizedBox(
      //                                 width: 5.0,
      //                               ),
      //                               Obx(() => Text(
      //                                     '${controller.jadwalSabtu[index]['endTime']}',
      //                                     // controller
      //                                     //         .timesBerakhirUI
      //                                     //         .isEmpty
      //                                     //     ? "Selesai"
      //                                     //     : "${controller.timesBerakhirUI}",
      //                                     style: blackTextStyle.copyWith(
      //                                         color: blackColor),
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                         IconButton(
      //                             onPressed: () {
      //                               controller.jadwalSabtu.removeAt(index);
      //                               // controller.listJadwal.removeAt(index);
      //                             },
      //                             icon: Icon(Icons.remove))
      //                       ]),
      //                     )),
      //           )
      //         ],
      //       ),
      //       //MINGGU
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Minggu",
      //                 style: blackTextStyle.copyWith(fontSize: 16),
      //               ),
      //               Obx(() => controller.activeMinggu.isFalse
      //                   ? InkWell(
      //                       onTap: () {
      //                         controller.activeMinggu.value = true;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_off.png'))
      //                   : InkWell(
      //                       onTap: () {
      //                         controller.activeMinggu.value = false;
      //                       },
      //                       child: Image.asset('assets/icon/jadwal_on.png')))
      //             ],
      //           ),
      //           Obx(
      //             () => controller.activeMinggu.isTrue
      //                 ? Padding(
      //                     padding: const EdgeInsets.only(left: 18.0),
      //                     child: Row(
      //                         // mainAxisAlignment:
      //                         //     MainAxisAlignment.spaceAround,
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               showModalBottomSheet(
      //                                   isDismissible: false,
      //                                   context: context,
      //                                   builder: (context) {
      //                                     return Column(
      //                                       mainAxisSize: MainAxisSize.min,
      //                                       children: <Widget>[
      //                                         buildTimePickerMulaiMinggu(),
      //                                         ElevatedButton(
      //                                           onPressed: () {
      //                                             Get.back();
      //                                           },
      //                                           child: const Text('Ok'),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 10.0,
      //                                         ),
      //                                       ],
      //                                     );
      //                                   });
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesMulaiUIMinggu
      //                                                 .isEmpty
      //                                             ? "Mulai"
      //                                             : "${controller.timesMulaiUIMinggu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesMulaiUIMinggu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(':'),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               if (controller
      //                                   .timesMulaiUIMinggu.isNotEmpty) {
      //                                 showModalBottomSheet(
      //                                     isDismissible: false,
      //                                     context: context,
      //                                     builder: (context) {
      //                                       return Column(
      //                                         mainAxisSize: MainAxisSize.min,
      //                                         children: <Widget>[
      //                                           buildTimeSelesaiMinggu(),
      //                                           ElevatedButton(
      //                                             onPressed: () {
      //                                               var timeMulai = controller
      //                                                   .timesMulaiUIMinggu
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timeMulai.toString());
      //                                               var timesBerakhir = controller
      //                                                   .timesBerakhirUIMinggu
      //                                                   .substring(0, 2);
      //                                               print('Cekkk' +
      //                                                   timesBerakhir
      //                                                       .toString());
      //                                               if (int.parse(timeMulai) <=
      //                                                   int.parse(
      //                                                       timesBerakhir)) {
      //                                                 // controller.listJadwal
      //                                                 //     .add({
      //                                                 //   "startTime": controller
      //                                                 //       .timesMulaiUIMinggu
      //                                                 //       .value,
      //                                                 //   "endTime": controller
      //                                                 //       .timesBerakhirUIMinggu
      //                                                 //       .value,
      //                                                 //   "day": "Minggu"
      //                                                 // });
      //                                                 Get.back();
      //                                               } else {
      //                                                 Get.defaultDialog(
      //                                                     title:
      //                                                         "Terjadi Kesalahan",
      //                                                     middleText:
      //                                                         "Mohon Pilih Jam\n Setelah Jam Mulai");
      //                                               }
      //                                             },
      //                                             child: const Text('Ok'),
      //                                           ),
      //                                           const SizedBox(
      //                                             height: 10.0,
      //                                           ),
      //                                         ],
      //                                       );
      //                                     });
      //                               }
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               height: 40,
      //                               width: Get.width / 3.5,
      //                               decoration: BoxDecoration(
      //                                   border:
      //                                       Border.all(color: buttonColor!)),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Icon(
      //                                     Icons.access_time_outlined,
      //                                     color: buttonColor,
      //                                   ),
      //                                   const SizedBox(
      //                                     width: 5.0,
      //                                   ),
      //                                   Obx(() => Text(
      //                                         controller.timesBerakhirUIMinggu
      //                                                 .isEmpty
      //                                             ? "Selesai"
      //                                             : "${controller.timesBerakhirUIMinggu}",
      //                                         style: blackTextStyle.copyWith(
      //                                             color: controller
      //                                                     .timesBerakhirUIMinggu
      //                                                     .isEmpty
      //                                                 ? buttonColor
      //                                                 : blackColor),
      //                                       ))
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           IconButton(
      //                               onPressed: () {
      //                                 if (controller
      //                                         .timesMulaiUIMinggu.isEmpty ||
      //                                     controller
      //                                         .timesBerakhirUIMinggu.isEmpty) {
      //                                   Get.defaultDialog(
      //                                       title: "Terjadi Kesalahan",
      //                                       middleText:
      //                                           "Mohon Lengkapi Jam Terlebih Dahulu");
      //                                 } else {
      //                                   controller.jadwalMinggu.add({
      //                                     "startTime": controller
      //                                         .timesMulaiUIMinggu.value,
      //                                     "endTime": controller
      //                                         .timesBerakhirUIMinggu.value,
      //                                     "day": "Minggu",
      //                                     "isActive": true
      //                                   });

      //                                   // controller.jadwalSenin
      //                                   //     .add(controller.listJadwal);
      //                                   controller.timesMulaiUIMinggu.value =
      //                                       '';
      //                                   controller.timesBerakhirUIMinggu.value =
      //                                       '';
      //                                 }
      //                                 print('object' +
      //                                     controller.jadwalMinggu.toString());
      //                               },
      //                               icon: Icon(Icons.add))
      //                         ]),
      //                   )
      //                 : const SizedBox(),
      //           )
      //         ],
      //       ),

      //       Obx(
      //         () => controller.jadwalMinggu.isEmpty
      //             ? const SizedBox(
      //                 height: 1.0,
      //               )
      //             : SizedBox(
      //                 height: 100.0,
      //                 child: ListView.builder(
      //                   itemCount: controller.jadwalMinggu.length,
      //                   itemBuilder: (context, index) => Row(children: [
      //                     Container(
      //                       margin: EdgeInsets.only(left: 19),
      //                       alignment: Alignment.center,
      //                       height: 40,
      //                       width: Get.width / 3.5,
      //                       decoration: BoxDecoration(
      //                           border: Border.all(color: buttonColor!)),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.access_time_outlined,
      //                             color: buttonColor,
      //                           ),
      //                           const SizedBox(
      //                             width: 5.0,
      //                           ),
      //                           Obx(() => Text(
      //                                 '${controller.jadwalMinggu[index]['startTime']}',
      //                                 style: blackTextStyle.copyWith(
      //                                     color: blackColor),
      //                               ))
      //                         ],
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 10.0,
      //                     ),
      //                     Text(':'),
      //                     const SizedBox(
      //                       width: 10.0,
      //                     ),
      //                     Container(
      //                       alignment: Alignment.center,
      //                       height: 40,
      //                       width: Get.width / 3.5,
      //                       decoration: BoxDecoration(
      //                           border: Border.all(color: buttonColor!)),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.access_time_outlined,
      //                             color: buttonColor,
      //                           ),
      //                           const SizedBox(
      //                             width: 5.0,
      //                           ),
      //                           Obx(() => Text(
      //                                 '${controller.jadwalMinggu[index]['endTime']}',
      //                                 // controller
      //                                 //         .timesBerakhirUI
      //                                 //         .isEmpty
      //                                 //     ? "Selesai"
      //                                 //     : "${controller.timesBerakhirUI}",
      //                                 style: blackTextStyle.copyWith(
      //                                     color: blackColor),
      //                               )),
      //                         ],
      //                       ),
      //                     ),
      //                     IconButton(
      //                         onPressed: () {
      //                           controller.jadwalMinggu.removeAt(index);
      //                           // controller.listJadwal.removeAt(index);
      //                         },
      //                         icon: Icon(Icons.remove))
      //                   ]),
      //                 )),
      //       ),
      //       const SizedBox(
      //         height: 100.0,
      //       ),
      //     ]),
      //   ),
      // ),
      // bottomSheet: Padding(
      //     padding: const EdgeInsets.only(bottom: 24.0),
      //     child: Obx(
      //       () => controller.jadwalSenin.isNotEmpty
      //           ? ButtomGradient(
      //               label: 'Selesai',
      //               onTap: () async {
      //                 controller.listJadwal.value = controller.jadwalSenin +
      //                     controller.jadwalSelasa +
      //                     controller.jadwalRabu +
      //                     controller.jadwalKamis +
      //                     controller.jadwalJumat +
      //                     controller.jadwalSabtu +
      //                     controller.jadwalMinggu;

      //                 print('object' + controller.listJadwal.toString());
      //                 // for(var i=0; i< controller.jadwalSenin.length ;i++){
      //                 // // var item = items[i];

      //                 await controller.tambahJadwal(
      //                     scheduler: controller.listJadwal);
      //                 // }
      //                 Get.to(() => Sukses());
      //                 // print("asooooy" + controller.listJadwal.toString());
      //               })
      //           : ButtonPrimary(
      //               title: "Selesai",
      //               onPressed: () {
      //                 // Get.to(() => LengkapiTepatPraktek());
      //               }),
      //     )),
    );
  }
}
