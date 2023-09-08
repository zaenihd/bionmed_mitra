import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/account/controllers/account_controller.dart';
import 'package:bionmed/app/modules/doctor_app/account/views/account_hospital.dart';
import 'package:bionmed/app/modules/doctor_app/account/widget/skpengguna_widget.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../widget/button/button_primary_withtext.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final myC = Get.put(AccountController());
  final loginC = Get.put(LoginController());
  // int? myC.selected.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(23),
                height: 100,
                child: Row(
                  children: [
                     Cntr(
                          height: 70,
                          width: 70,
                          image: const DecorationImage(
                              image: AssetImage('assets/icon/icon.png'),fit: BoxFit.cover),
                        ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.put(LayananHomeController()).addOrder();
                          },
                          // onTap: () {
                          //   Get.bottomSheet(
                          //       shape: const RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(30),
                          //               topRight: Radius.circular(30))),
                          //       Container(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 20),
                          //           decoration: const BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.only(
                          //                   topLeft: Radius.circular(30),
                          //                   topRight: Radius.circular(30))),
                          //           height: Get.height / 1.5,
                          //           width: Get.width,
                          //           child: SingleChildScrollView(
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Center(
                          //                   child: Cntr(
                          //                     margin: const EdgeInsets.symmetric(
                          //                         vertical: 10),
                          //                     height: 10,
                          //                     width: 200,
                          //                     color: Colors.grey[300],
                          //                     radius: BorderRadius.circular(20),
                          //                   ),
                          //                 ),
                          //                 Cntr(
                          //                   alignment: Alignment.centerLeft,
                          //                   height: 90,
                          //                   width: Get.width,
                          //                   color: Colors.grey[200],
                          //                   radius: BorderRadius.circular(10),
                          //                   child: ListTile(
                          //                     title: Txt(
                          //                       text: 'Nama ku',
                          //                       size: 16,
                          //                       weight: bold,
                          //                     ),
                          //                     subtitle: Txt(
                          //                       text: 'Nama ku',
                          //                       size: 12,
                          //                       weight: medium,
                          //                       color: Colors.grey[600],
                          //                     ),
                          //                     leading: Cntr(
                          //                       height: 60,
                          //                       width: 60,
                          //                       radius:
                          //                           BorderRadius.circular(100),
                          //                       image: const DecorationImage(
                          //                           image: AssetImage(
                          //                               'assets/images/banner1.png'),
                          //                           fit: BoxFit.cover),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 16.0,
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(
                          //                         width: 100,
                          //                         child:
                          //                             Txt(text: 'Nama Pasien')),
                          //                     Txt(text: ':   '),
                          //                     SizedBox(
                          //                         width: 150,
                          //                         child: Txt(
                          //                           text: 'Joni Hermawan',
                          //                           weight: bold,
                          //                         )),
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 16.0,
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(
                          //                         width: 100,
                          //                         child:
                          //                             Txt(text: 'Jenis Kelamin')),
                          //                     Txt(text: ':   '),
                          //                     SizedBox(
                          //                         width: 150,
                          //                         child: Txt(
                          //                           text: 'Laki - Laki',
                          //                           weight: bold,
                          //                         )),
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 16.0,
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(
                          //                         width: 100,
                          //                         child: Txt(text: 'Umur')),
                          //                     Txt(text: ':   '),
                          //                     SizedBox(
                          //                         width: 150,
                          //                         child: Txt(
                          //                           text: '99++',
                          //                           weight: bold,
                          //                         )),
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 16.0,
                          //                 ),
                          //                 Txt(
                          //                   text: 'Foto Pasien',
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 10.0,
                          //                 ),
                          //                 Cntr(
                          //                     height: 52,
                          //                     padding: const EdgeInsets.symmetric(
                          //                         horizontal: 10),
                          //                     alignment: Alignment.center,
                          //                     radius: BorderRadius.circular(10),
                          //                     width: Get.width,
                          //                     border: Border.all(
                          //                         color: Colors.grey[400]!),
                          //                     child: Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         Row(
                          //                           children: [
                          //                             Icon(
                          //                               Icons.image,
                          //                               color: Colors.grey[400],
                          //                             ),
                          //                             const SizedBox(
                          //                               width: 10.0,
                          //                             ),
                          //                             Txt(text: 'image'),
                          //                           ],
                          //                         ),
                          //                         Icon(
                          //                           Icons
                          //                               .arrow_forward_ios_rounded,
                          //                           color: Colors.grey[400],
                          //                         ),
                          //                       ],
                          //                     )),
                          //                 ExpansionTile(
                          //                   initiallyExpanded: true,
                          //                   tilePadding: EdgeInsets.zero,
                          //                   title: Txt(
                          //                     text: 'Kebutuhan Pasien',
                          //                   ),
                          //                   children: [
                          //                     SizedBox(
                          //                       height: 230,
                          //                       child: ListView.builder(
                          //                         itemCount: 4,
                          //                         itemBuilder: (context, index) =>
                          //                             ListTile(
                          //                           title: Text('data $index'),
                          //                           leading: Cntr(
                          //                             height: 50,
                          //                             width: 50,
                          //                             image: const DecorationImage(
                          //                                 image: AssetImage(
                          //                                     'assets/images/banner1.png'),
                          //                                 fit: BoxFit.cover),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 15.0,
                          //                 ),
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Row(
                          //                       children: [
                          //                         SizedBox(
                          //                             width: 100,
                          //                             child: Txt(text: 'Total')),
                          //                         Txt(text: ':   '),
                          //                       ],
                          //                     ),
                          //                     Txt(
                          //                         text: 'Rp.150.000',
                          //                         weight: bold,
                          //                         size: 20,
                          //                         color: Colors.green),
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 20.0,
                          //                 ),
                          //                 ButtomGradient(
                          //                     margin: 0,
                          //                     label: 'Setujui',
                          //                     onTap: () {}),
                          //                 const SizedBox(
                          //                   height: 10.0,
                          //                 ),
                          //                 ButtonPrimary(
                          //                   marginLeft: 0,
                          //                   marginRight: 0,
                          //                   onPressed: () {
                          //                     Get.bottomSheet(
                          //                         shape:
                          //                             const RoundedRectangleBorder(
                          //                                 borderRadius:
                          //                                     BorderRadius.only(
                          //                                         topLeft: Radius
                          //                                             .circular(
                          //                                                 30),
                          //                                         topRight: Radius
                          //                                             .circular(
                          //                                                 30))),
                          //                         Container(
                          //                           padding: const EdgeInsets
                          //                                   .symmetric(
                          //                               horizontal: 20),
                          //                           decoration: const BoxDecoration(
                          //                               color: Colors.white,
                          //                               borderRadius:
                          //                                   BorderRadius.only(
                          //                                       topLeft: Radius
                          //                                           .circular(30),
                          //                                       topRight: Radius
                          //                                           .circular(
                          //                                               30))),
                          //                           height: 270,
                          //                           width: Get.width,
                          //                           child: SingleChildScrollView(
                          //                             child: Column(
                          //                               children: [
                          //                                 Center(
                          //                                   child: Cntr(
                          //                                     margin:
                          //                                         const EdgeInsets
                          //                                                 .symmetric(
                          //                                             vertical: 10),
                          //                                     height: 10,
                          //                                     width: 200,
                          //                                     color:
                          //                                         Colors.grey[300],
                          //                                     radius: BorderRadius
                          //                                         .circular(20),
                          //                                   ),
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   height: 40.0,
                          //                                 ),
                          //                                 Txt(
                          //                                   text:
                          //                                       'Apakah Anda yakin ingin menolak\npesanan tersebut ?',size: 16,
                          //                                   textAlign:
                          //                                       TextAlign.center,
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   height: 40.0,
                          //                                 ),
                          //                                 ButtonPrimary(
                          //                                   backgroundColor:
                          //                                       Colors.red,
                          //                                   marginLeft: 0,
                          //                                   marginRight: 0,
                          //                                   onPressed: () {},
                          //                                   title: 'Tolak Pesanan',
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   height: 10.0,
                          //                                 ),
                          //                                 ButtonPrimary(
                          //                                   marginLeft: 0,
                          //                                   marginRight: 0,
                          //                                   onPressed: () {
                          //                                     Get.back();
                          //                                     Get.back();
                          //                                   },
                          //                                   title: 'Tolak Pesanan',
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         ));
                          //                   },
                          //                   title: 'Tolak Pesanan',
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 20.0,
                          //                 ),
                          //               ],
                          //             ),
                          //           )));
                          // },
                          child: Text(
                            'Pilih Akun Untuk Masuk',
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: Get.width / 1.9,
                          child: Text(
                            'Pilih akun anda sebagai berikut untuk melanjutkan login kedalam aplikasi',
                            style: blackTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 11,
                                color: const Color(0xff555555)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: loginBy.length,
                    itemBuilder: (context, index) => 
                    InkWell(
                          onTap: () {
                            // print(loginC.idAccount.value.toString());
        
                            // myC.selected.value = 1;
                            // '${loginBy[index]['subtitle']}' = index
                            // setState(() {
                              myC.selected.value = index + 1;
                            // });
                             loginC.idAccount.value = myC.selected.value;
                            loginC.idAccount.value = myC.selected.value;
                           GetStorage().write('idAccount', myC.selected.value);
                          },
                          child:Obx(()=> Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(23),
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      color: Colors.grey)
                                ],
                                border: Border.all(
                                    color: myC.selected.value == index + 1
                                        ? blueColor!
                                        : whiteColor!,
                                    width: 2),
                                borderRadius: BorderRadius.circular(12),
                                color: textFieldC),
                            child: Row(
                              children: [
                                Image.asset("${loginBy[index]['imageUrl']}"),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      // width: 200,
                                      width: Get.width / 1.8,
                                      // color: Colors.amber,
                                      child: AutoSizeText(
                                        '${loginBy[index]['title']}',
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontWeight: semiBold, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    SizedBox(
                                      width: Get.width / 1.8,
                                      child: AutoSizeText(
                                        '${loginBy[index]['subtitle']}',
                                        style: blackTextStyle.copyWith(
                                            fontWeight: medium,
                                            fontSize: 11,
                                            color: const Color(0xff555555)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),),
                        )
                        ),
              ),
              // const SkPengguna()
              const SizedBox(
                height: 130,
              )
            ],
          ),
        ),
        bottomSheet: SizedBox(
          height: 130,
          width: Get.width,
          child: Column(
            children: [
              const SkPengguna(),
              const SizedBox(
                height: 24,
              ),
              myC.selected.value != null
                  ? ButtomGradient(
                      label: "Lanjutkan",
                      onTap: () {
                        if (myC.selected.value == 2) {
                          Get.toNamed(Routes.LOGIN);
                          // showPopUp(
                          //   onTap: () {
                          //   Get.back();
                          // },
                          //     imageAction: 'assets/json/eror.json',
                          //     description: "Sedang dalam proses\npengembangan");
                        } 
                        // else if (myC.selected.value == 3) {
                        //   showPopUp(
                        //       onTap: () {},
                        //       imageAction: 'assets/json/eror.json',
                        //       description: "Sedang dalam proses\npengembangan");
                        // } else if (myC.selected.value == 4) {
                        //   showPopUp(
                        //       onTap: () {
                        //         Get.back();
                        //       },
                        //       imageAction: 'assets/json/eror.json',
                        //       description: "Sedang dalam proses\npengembangan");
                        // } 
                        else if (myC.selected.value == 3) {
                          // Get.toNamed(Routes.LOGIN);
                          Get.to(()=> AccountHospital());

                          // showPopUp(
                          //     onTap: () {
                          //       Get.back();
                          //     },
                          //     imageAction: 'assets/json/eror.json',
                          //     description: "Sedang dalam proses\npengembangan");
                        // } 
                        // else if (myC.selected.value == 6) {
                        //   showPopUp(
                        //       onTap: () {
                        //         Get.back();
                        //       },
                        //       imageAction: 'assets/json/eror.json',
                        //       description: "Sedang dalam proses\npengembangan");
                        } else {
                          Get.toNamed(Routes.LOGIN);
                        }
                        // myC.selected.value == 2 ? Get.defaultDialog() :
                      },
                    )
                  : ButtonPrimary(title: "Lanjutkan", onPressed: () {}),
            ],
          ),
        )
        );
  }
}

List<Map<String, dynamic>> loginBy = [
  {
    "imageUrl": "assets/icon/icon1.png",
    "title": "Dokter Umum / Spesialis",
    "subtitle": "Masuk kedalam aplikasi sebagai dokter",
    "index": 1
  },
  {
    "imageUrl": "assets/icon/icon2.png",
    "title": "Perawat",
    "subtitle": "Masuk kedalam aplikasi sebagai Perawat",
    "index": 2
  },
  // {
  //   "imageUrl": "assets/icon/icon3.png",
  //   "title": "Apotek",
  //   "subtitle": "Masuk kedalam aplikasi sebagai Mitra Apotek",
  //   "index": 3
  // },
  // {
  //   "imageUrl": "assets/icon/icon4.png",
  //   "title": "Laboratorium Klinik",
  //   "subtitle": "Masuk kedalam aplikasi sebagai Laboratorium Klinik",
  //   "index": 4
  // },
  {
    "imageUrl": "assets/icon/icon5.png",
    "title": "Rumah Sakit",
    "subtitle": "Masuk kedalam aplikasi sebagai Rumah Sakit",
    "index": 5
  },
  // {
  //   "imageUrl": "assets/icon/icon6.png",
  //   "title": "Ambulance",
  //   "subtitle": "Masuk kedalam aplikasi sebagai Ambulance",
  //   "index": 6
  // },
];
