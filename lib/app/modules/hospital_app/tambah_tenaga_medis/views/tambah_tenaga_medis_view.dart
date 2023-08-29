import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../doctor_app/pilih_spesialis/views/pilih_spesialis_view.dart';
import '../controllers/tambah_tenaga_medis_controller.dart';

class TambahTenagaMedisView extends GetView<TambahTenagaMedisController> {
   TambahTenagaMedisView({Key? key}) : super(key: key);

  // ignore: annotate_overrides
  final controller = Get.put(TambahTenagaMedisController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: SingleChildScrollView(
        child: 
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center, children: [
            // headersTenagaMedis(),
            headersAmbulance(),
            Cntr(
              height: 300,
              width: Get.width,
              child: ListView.builder(
                  itemCount: 1, itemBuilder: (context, index) => namaPerawat()),
            ),
            InkWell(
              onTap: () {
                popUpActionTambahTenagaMedis(context);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 100),
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
                      'Tambah Perawat',
                      style: greyTextStyle,
                    )
                  ],
                ),
              ),
            )
          ]),
        )),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ButtomGradient(label: "Lanjutkan", onTap: () async {
            popUpActionTambahAmbulance(context);
          })),
    );
  }

  Column headersTenagaMedis() {
    return Column(children: [
            Image.asset('assets/icon/tenaga_medis.png'),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Tenaga Medis',
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Text(
            'Daftarkan tenaga medis yang\ntersedia di Rumah Sakit ',
            style: subtitleTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Image.asset('assets/icon/stepper2.png'),
          const SizedBox(
            height: 23.0,
          ),
          ],);
  }

  Column headersAmbulance() {
    return Column(children: [
            Image.asset('assets/icon/ambulance.png'),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Ambulance',
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Text(
            'Daftarkan Ambulance\nyang tersedia di Rumah Sakit ',
            style: subtitleTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Image.asset('assets/icon/stepper3.png'),
          const SizedBox(
            height: 23.0,
          ),
          ],);
  }

  Future<dynamic> popUpActionTambahTenagaMedis(BuildContext context){
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
                  text: 'Daftarkan Tenaga Medis',
                  weight: bold,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    // if (controller
                    //     .nurseScopeData.isEmpty) {
                    //   controller.getNurseWorkScope();
                    // }
                    controller.pickerFilesImage(context);
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Obx(
                        //   () =>
                        //    controller
                        //           .tampunganNurseId
                        //           .isNotEmpty
                        //       ? Txt(
                        //           text:
                        //               '${controller.tampunganNurseId.length} Dipilih')
                        //       :
                        Txt(
                          text: 'Upload foto dokter/perawat',
                          color: AppColor.bodyColor.shade500,
                        ),

                        Icon(
                          Icons.upload,
                          color: AppColor.bodyColor.shade500,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                InputPrimary(
                    hintText: "Masukkan Nama dokter/perawat",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                InputPrimary(
                    hintText: "Masukkan No. STR",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                InputPrimary(
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(
                      //     RegExp(r'^\d+\.?\d{0,1}')),
                      CurrencyTextInputFormatter(
                        locale: 'id',
                        decimalDigits: 0,
                        symbol: '',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: "Masukkan Umur",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    // if (controller
                    //     .nurseScopeData.isEmpty) {
                    //   controller.getNurseWorkScope();
                    // }
                    Get.to(() => const PilihSpesialisView());
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Obx(
                        //   () =>
                        //    controller
                        //           .tampunganNurseId
                        //           .isNotEmpty
                        //       ? Txt(
                        //           text:
                        //               '${controller.tampunganNurseId.length} Dipilih')
                        //       :
                        Txt(
                          text: 'Pilih Spesialis',
                          color: AppColor.bodyColor.shade500,
                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.bodyColor.shade500,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtomGradient(
                    margin: 0, label: 'Tambahkan', onTap: () async {}),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> popUpActionTambahAmbulance(BuildContext context){
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
                  text: 'Daftarkan Ambulance',
                  weight: bold,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    // if (controller
                    //     .nurseScopeData.isEmpty) {
                    //   controller.getNurseWorkScope();
                    // }
                    controller.pickerFilesImage(context);
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Obx(
                        //   () =>
                        //    controller
                        //           .tampunganNurseId
                        //           .isNotEmpty
                        //       ? Txt(
                        //           text:
                        //               '${controller.tampunganNurseId.length} Dipilih')
                        //       :
                        Txt(
                          text: 'Upload foto ambulance',
                          color: AppColor.bodyColor.shade500,
                        ),

                        Icon(
                          Icons.upload,
                          color: AppColor.bodyColor.shade500,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                height: 10.0,
                ),
                InputPrimary(
                    hintText: "Nama ambulance rumah sakit",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                InputPrimary(
                    hintText: "Masukkan No. kendaraan (contoh B 1234 UIX)",
                    onChange: (p0) {},
                    controller: TextEditingController(),
                    onTap: () {}),
                    const SizedBox(
                    height: 10.0,
                    ),
                InkWell(
                  onTap: () {
                    // if (controller
                    //     .nurseScopeData.isEmpty) {
                    //   controller.getNurseWorkScope();
                    // }
                    Get.to(() => const PilihSpesialisView());
                  },
                  child: Cntr(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: AppColor.bgForm,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Obx(
                        //   () =>
                        //    controller
                        //           .tampunganNurseId
                        //           .isNotEmpty
                        //       ? Txt(
                        //           text:
                        //               '${controller.tampunganNurseId.length} Dipilih')
                        //       :
                        Txt(
                          text: 'Pilih Spesialis',
                          color: AppColor.bodyColor.shade500,
                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.bodyColor.shade500,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtomGradient(
                    margin: 0, label: 'Tambahkan', onTap: () async {}),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }

  Cntr namaPerawat() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Detail Perawat',
                    size: 12,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Cntr(
                        height: 20,
                        width: 20,
                        color: Colors.white,
                        radius: BorderRadius.circular(5),
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Cntr(
                        margin: const EdgeInsets.only(right: 10),
                        height: 20,
                        width: 20,
                        color: Colors.white,
                        radius: BorderRadius.circular(5),
                        child: const Icon(
                          Icons.edit_note_sharp,
                          color: Colors.green,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Txt(
                        text: 'Dr. ni putu ani',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Umur    : 36 Tahun',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'No STR : 12345678',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Cntr(
                    radius: BorderRadius.circular(100),
                    height: 80,
                    width: 80,
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.white, width: 4),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
