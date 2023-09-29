import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme.dart';
import '../../../../constant/colors.dart';
import '../../../../widget/button/button_gradien.dart';
import '../../../../widget/button/button_primary_withtext.dart';
import '../../../../widget/txt/text.dart';
import '../../../doctor_app/login/controllers/login_controller.dart';
import '../../../doctor_app/register/controllers/register_controller.dart';
import '../../../doctor_app/register/views/maps.dart';
import '../controllers/paket_layanan_nurse_controller.dart';

class InputPaketAmbulance extends StatelessWidget {
  InputPaketAmbulance({super.key});

  final controller = Get.put(PaketLayananNurseController());
  final loginC = Get.put(LoginController());
  final typeAmbulance = ['Ambulance Gawat Darurat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: Container(
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
              InputPrimary(
                  hintText: "Masukan nama paket",
                  onChange: (p0) {
                    controller.namaPaket.value = controller.namaPaketC.text;
                  },
                  controller: controller.namaPaketC,
                  onTap: () {}),
              InputPrimary(
                  hintText: "Deskripsi",
                  onChange: (p0) {
                    controller.deskripsiPaket.value =
                        controller.deskripsiPaketC.text;
                  },
                  controller: controller.deskripsiPaketC,
                  onTap: () {}),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[350]!)),
                // dropdown below..
                child: DropdownButtonFormField(
                  hint: controller.selectedTypeAmbulance.isEmpty ? null : Txt(text: controller.selectedTypeAmbulance.value),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.bgForm,
                      filled: true,
                      hintText: "Pilih tipe ambulance",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (jKelamin) => jKelamin == null
                      ? "Pilih tipe ambulance tidak boleh kosong"
                      : null,
                  items: typeAmbulance
                      .map((e) => DropdownMenuItem(
                          onTap: () {
                            controller.selectedTypeAmbulance.value =
                                e.toString();
                          },
                          value: e,
                          child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputPrimary(
                  suffixIcon: Cntr(
                      color: Colors.transparent,
                      height: 50,
                      width: 20,
                      margin: const EdgeInsets.only(right: 4),
                      alignment: Alignment.center,
                      child: Txt(
                        text: '/ 1 km',
                      )),
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
                  hintText: "Harga Paket",
                  onChange: (p0) {
                    controller.hargaCurrens.value = int.parse(
                            controller.hargaPaketC.text.replaceAll(".", ""))
                        .toString();
                    controller.totalHargaPaket.value =
                        double.parse(controller.hargaCurrens.value);
                  },
                  controller: controller.hargaPaketC,
                  onTap: () {}),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => controller.tambahDiskon.isTrue
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width / 1.7,
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[400]!,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width: Get.width / 2,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.diskonPaket,
                                      onChanged: (value) {
                                        var harga = double.parse(
                                            controller.hargaCurrens.value);
                                        var diskonHome = double.parse(
                                            controller.diskonPaket.value.text);
                                        var persenDisko = diskonHome / 100;
                                        controller.totalHargaPaket.value =
                                            harga - (harga * persenDisko);
                                      },
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                      decoration: const InputDecoration(
                                        fillColor: AppColor.bgForm,
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.percent,
                                    color: yellowColor,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              onTap: () {
                                controller.tambahDiskon.value = false;
                                controller.diskonPaket.text = "";
                                controller.totalHargaPaket.value =
                                    double.parse(controller.hargaPaketC.text);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.disabled_by_default_outlined,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Txt(text: 'Hapus', color: Colors.red)
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          controller.tambahDiskon.value = true;
                          // Get.to(() => TambahScopeOfWork());
                        },
                        child: Container(
                          width: Get.width,
                          height: 45,
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
                                color: yellowColor,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Tambah Diskon',
                                style: greyTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () => controller.isCstActive.isFalse
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(() => ZonaCsr());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 45,
                          width: Get.width,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColor.bgForm,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[350]!)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Txt(
                                  text: controller.zonaCsr.isEmpty
                                      ? "Tambah Daerah"
                                      : '${controller.zonaCsr.length} Daerah terpilih'),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 19,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.isCstActive.value,
                        onChanged: (value) {
                          controller.isCstActive.value = value!;
                        },
                      )),
                  Txt(text: 'Aktifkan CSR (Layanan Gratis)')
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: Cntr(
        height: 110,
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Actual Prices',
                        style: blackTextStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                          width: Get.width / 4.5,
                          child: Txt(
                            text: NumberFormat.currency(
                              locale: 'id_IDR',
                              symbol: 'Rp. ',
                              decimalDigits: 0,
                            )
                                .format(controller.totalHargaPaket.value)
                                .toString(),
                            color: Colors.green,
                          )),
                    ],
                  ),
                )),
            const SizedBox(
              height: 15.0,
            ),
            controller.isEditPaketAmbulance.value == true
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ButtomGradient(
                        margin: 20,
                        label: controller.isEditPaketAmbulance.value == true
                            ? "Edit Paket"
                            : 'Tambahkan',
                        onTap: () async {
                          if (loginC.role.value == "hospital") {
                            if (controller.isEditPaketAmbulance.value == true) {
                              await controller.updatePaketLayananAmbulance();
                            } else {
                              await controller.tambahPaketLayananAmbulance();
                              controller.zonaCsr.clear();
                            }
                          }
                          controller.namaPaketC.clear();
                          controller.deskripsiPaketC.clear();
                          controller.selectedTypeAmbulance.value = "";
                          controller.hargaPaketC.clear();
                          controller.diskonPaket.clear();
                          controller.zonaCsr.value = [];
                          if (loginC.role.value == 'hospital') {
                            await controller.getTimAmbulan();
                          } else {
                            controller.getNursePket();
                          }
                          Get.back();
                          // controller.getNursePket();
                          controller.namaPaket.value = "";
                          controller.deskripsiPaket.value = "";
                          controller.totalHargaPaket.value = 0.0;
                          controller.tambahDiskon.value = false;
                          controller.dataActive.clear();
                          controller.packageNurseSops.value = [];
                        }),
                  )
                : Obx(
                    () => controller.namaPaket.isEmpty ||
                            controller.deskripsiPaket.isEmpty ||
                            controller.totalHargaPaket.value == 0.0 ||
                            controller.selectedTypeAmbulance.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ButtonPrimary(
                                marginLeft: 20,
                                marginRight: 20,
                                title: controller.isEditPaketAmbulance.value ==
                                        true
                                    ? "Edit Paket"
                                    : 'Tambahkan',
                                onPressed: () {}),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ButtomGradient(
                                margin: 20,
                                label: controller.isEditPaketAmbulance.value ==
                                        true
                                    ? "Edit Paket"
                                    : 'Tambahkan',
                                onTap: () async {
                                  if (loginC.role.value == "hospital") {
                                    if (controller.isEditPaketAmbulance.value ==
                                        true) {
                                      await controller
                                          .updatePaketLayananAmbulance();
                                    } else {
                                      await controller
                                          .tambahPaketLayananAmbulance();
                                    }
                                  }
                                  controller.namaPaketC.clear();
                                  controller.deskripsiPaketC.clear();
                                  controller.selectedTypeAmbulance.value = "";
                                  controller.hargaPaketC.clear();
                                  controller.diskonPaket.clear();
                                  controller.zonaCsr.value = [];
                                  if (loginC.role.value == 'hospital') {
                                    await controller.getTimAmbulan();
                                  } else {
                                    controller.getNursePket();
                                  }
                                  Get.back();
                                  // controller.getNursePket();
                                  controller.namaPaket.value = "";
                                  controller.deskripsiPaket.value = "";
                                  controller.totalHargaPaket.value = 0.0;
                                  controller.tambahDiskon.value = false;
                                  controller.dataActive.clear();
                                  controller.packageNurseSops.value = [];
                                }),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ZonaCsr extends StatelessWidget {
  ZonaCsr({super.key});
  final registerC = Get.put(RegisterController());
  final controller = Get.put(PaketLayananNurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(title: "Zona CSR"),
      body: Column(
        children: [
          Image.asset('assets/icon/csr.png'),
          const SizedBox(
            height: 10.0,
          ),
          Txt(text: 'Tentukan zona CSR anda'),
          const SizedBox(
            height: 20.0,
          ),
          Cntr(
            width: Get.width,
            color: Colors.transparent,
            height: 500,
            child: Obx(() => controller.zonaCsr.isEmpty
                ? Center(child: Txt(text: 'Tambahkan Zona CRS'))
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    itemCount: controller.zonaCsr.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 45,
                          width: Get.width / 1.3,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColor.bgForm,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[350]!)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Cntr(
                                width: Get.width / 1.6,
                                child: Txt(
                                    maxLines: 1,
                                    textOverFlow: TextOverflow.ellipsis,
                                    text: controller.zonaCsr.isEmpty
                                        ? ""
                                        : "${controller.zonaCsr[index]['districts']} , ${controller.zonaCsr[index]['city']}"),
                              ),
                              const Icon(
                                Icons.map,
                                size: 19,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                        Cntr(
                            onTap: () {
                              controller.zonaCsr.removeAt(index);
                            },
                            padding: const EdgeInsets.only(bottom: 13),
                            alignment: Alignment.center,
                            height: 45,
                            width: 20,
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )),
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 120,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                if(controller.isLoadingMaps.value == false){

                controller.isLoadingMaps.value = true;
                controller.isFromPaketAmbulance.value = true;
                await registerC.getCurrentLocation().then((value) {
                  registerC.lat.value = value.latitude;
                  registerC.long.value = value.longitude;
                });
                await registerC.getUserLocation();
                Get.to(() => MapSample(
                      lat: registerC.lat.value,
                      long: registerC.long.value,
                    ));
                controller.isLoadingMaps.value = false;
                }

                // controller.tambahDiskon.value = true;
                // Get.to(() => TambahScopeOfWork());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                width: Get.width,
                height: 45,
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
                      color: yellowColor,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Obx(() => Text(
                          controller.isLoadingMaps.isTrue
                              ? "Loading maps.."
                              : 'Tambah',
                          style: greyTextStyle,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ButtomGradient(
                label: 'Simpan',
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
