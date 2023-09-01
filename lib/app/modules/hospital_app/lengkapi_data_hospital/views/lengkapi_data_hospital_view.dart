import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/tambah_harga_paket_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_lengkapi_data.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lengkapi_data_hospital_controller.dart';

class LengkapiDataHospitalView extends GetView<LengkapiDataHospitalController> {
  const LengkapiDataHospitalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderLengkapiDataHospital(
                  imageUrl: 'assets/icon/icon_praktek.png',
                  title: 'Layanan',
                  subtitle:
                      'Pilih layanan yang tersedia di Rumah\nSakit dan buat paket layanan',
                  stepper: 'assets/icon/steper1.png'),
              const SizedBox(
                height: 30.0,
              ),
              listTimLayanan()
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom:24.0),
          child: ButtomGradient(label: 'Lanjutkan', onTap: (){
            Get.to(()=>TambahHargaPaketHospital());
          },),
        ),
        );
  }

  Cntr listTimLayanan() {
    return Cntr(
                height: Get.height/2,
                width: Get.width,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Cntr(
                    onTap: () {
                      Get.to(() => const TambahTimLayanan());
                    },
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 0.4,
                        color: Color.fromARGB(255, 222, 221, 221),
                      )
                    ],
                    radius: BorderRadius.circular(10),
                    color: Colors.white,
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 24, right: 24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/icon/cekon.png'),
                              const SizedBox(
                                width: 15.0,
                              ),
                              const Icon(
                                Icons.person,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Txt(
                                    text: 'Hospital',
                                    weight: bold,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Txt(
                                    text: 'Buat tim layanan',
                                    weight: medium,
                                    size: 11,
                                    color: Colors.grey,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ]),
                  ),
                ),
              );
  }
}

class TambahTimLayanan extends StatelessWidget {
  const TambahTimLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Tim Layanan'),
      bottomSheet:
       InkWell(
        onTap: () {
          popUpActionTambahTimLayanan(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          width: Get.width,
          height: 55,
          decoration: DottedDecoration(
              shape: Shape.box,
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffCCCCCC)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: blueColor,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                'Buat tim layanan',
                style: greyTextStyle,
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
        itemCount: 1,
        itemBuilder: (context, index) => 
       cardTimLayanan(),
              ),
    );
  }

  Cntr cardTimLayanan() {
    return Cntr(
                margin: const EdgeInsets.only(bottom: 10),
                radius: BorderRadius.circular(10),
                width: Get.width,
                gradient: gradient1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 30,),
                            const SizedBox(
                            width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt(
                                  text: "Home Visit Dokter",
                                  weight: bold,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Txt(
                                  text: "RS Dedari Kupang",
                                  weight: light,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                              },
                              child: const Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            // INIEDIT
                            InkWell(
                              onTap: () {
                              },
                              child: const Icon(
                                Icons.edit_note_rounded,
                                color: Color(0xFF0B9444),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Cntr(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      color: AppColor.bgForm,
                      radius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: "Tim Home Visit Dokter 1",
                            color: Colors.black,
                            weight: bold,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Cntr(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      color: AppColor.bgForm,
                      radius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            text: " 0882 1456 3928",
                            color: Colors.black,
                            weight: bold,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Cntr(
                      
                      padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                      height: 70,
                      alignment: Alignment.topLeft,
                      width: Get.width,
                      color: AppColor.bgForm,
                      radius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                      child: Txt(
                        text: "Tersedia 1 Dokter umum, 1 perawat dan 1 Dokter spesialis",
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              );
  }

  Future<dynamic> popUpActionTambahTimLayanan(BuildContext context) {
    return Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: 500,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Cntr(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 10,
                    width: 200,
                    color: Colors.grey[300],
                    radius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Txt(
                  text: 'Buat tim layanan',
                  weight: bold,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputPrimary(
                    hintText: "Masukan nama tim",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                InputPrimary(
                    hintText: "No. handphone / akses login PIC",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                Cntr(
                  
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  height: 120,
                  color: AppColor.bgForm,
                  border: Border.all(color: Colors.grey[350]!),
                  child:  TextFormField(
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Alamat Tidak Boleh Kosong";
                        }
                      },
                      onTap: () async {
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText:
                              "Deskripsi\n\nContoh : tersedia 1 Dokter umum, 1 perawat dan 1\nDokter spesialis",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtomGradient(
                    margin: 0, label: 'Tambahkan', onTap: () async {Get.back();}),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }
}
