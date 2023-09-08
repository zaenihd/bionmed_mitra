import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/maps.dart';
import 'package:bionmed/app/modules/hospital_app/profile/edit_profile_hospital/controllers/edit_profile_hospital_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileHospital extends StatefulWidget {
  const EditProfileHospital({super.key});

  @override
  State<EditProfileHospital> createState() => _EditProfileHospitalState();
}

class _EditProfileHospitalState extends State<EditProfileHospital> {
  final registerC = Get.put(RegisterController());
  final myC = Get.put(EditProfileHospitalController());
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _pickerStr = ImagePicker();
  final box = GetStorage();

  // ignore: prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables
  var filesStr;

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    myC.filesHospital == file;
    myC.filesHospital = File(image.path);

    myC.imageUrlHospital.value = myC.filesHospital.toString();
    log(myC.imageUrlHospital.value.toString());

    setState(() => myC.filesHospital = File(image.path));
    return file;
  }

  void pickerFilesImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Photo"),
                onTap: () async {
                  //    if (await Permission.storage.request().isGranted) {
                  // }
                  takePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  takePhoto(ImageSource.camera);
                  Get.back();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: HeaderWidget(
                      imageUrl: 'assets/icon/icon_biodata.png',
                      title: "Biodata Hospital",
                      subtitle:
                          "Isi data ini dengan lengkap untuk membuat \nakun anda"),
                ),
                const SizedBox(
                  height: 39.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Foto rumah sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () async {
                    pickerFilesImage(context);
                    // Get.to(()=>MapSample());
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 46,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: textFieldC,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Cntr(
                            color: Colors.transparent,
                            width: Get.width / 1.5,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              myC.imageUrlHospital.isEmpty
                                  ? Get.find<JadwalSayaController>()
                                      .dataHospital['image']
                                      .toString()
                                  : myC.imageUrlHospital.value.substring(46),
                              style: greyTextStyle.copyWith(
                                  color: myC.imageUrlHospital.isNotEmpty
                                      ? blackColor
                                      : greyColor),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.upload,
                            color: Colors.grey[400],
                            size: 18,
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Nama Rumah Sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                InputPrimary(
                  onChange: (p0) {},
                  controller: myC.namaHopitalC,
                  onTap: () {},
                  hintText: 'Masukkan nama',
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Email rumah sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                InputPrimary(
                  onChange: (p0) {},
                  controller: myC.emailHopitalC,
                  onTap: () {},
                  hintText: 'Masukkan email',
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'No. Telephone',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                InputPrimary(
                  onChange: (p0) {},
                  controller: myC.nomerHospitalC,
                  onTap: () {},
                  hintText: 'Masukkan No telephone',
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Tahun berdiri rumah sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                InputPrimary(
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.date_range_rounded),
                  validate: (alamat) => alamat.toString().isEmpty
                      ? "Tahun tidak boleh kosong"
                      : null,
                  onChange: (p0) {},
                  controller: myC.tahunBerdiriHospitalC,
                  onTap: () {},
                  hintText: 'Masukkan tahun',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Dokumen Surat Ijin Operasional ',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    myC.pickerDokumenSuratIjinOperasinal();
                    // Get.to(()=>MapSample());
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 46,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: textFieldC,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Cntr(
                              color: Colors.transparent,
                              width: Get.width / 1.5,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                myC.dokumenSuratIjinOperasional.isEmpty
                                    ? Get.find<JadwalSayaController>()
                                        .dataHospital['fileLicense']
                                        .toString()
                                    : myC.dokumenSuratIjinOperasional.value
                                        .substring(51),
                                style: greyTextStyle.copyWith(
                                    color: myC.dokumenSuratIjinOperasional
                                            .isNotEmpty
                                        ? blackColor
                                        : greyColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.upload,
                            color: Colors.grey[400],
                            size: 18,
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Dokumen Pendukung',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () async {
                    myC.pickerDokumenPendukung();
                    // Get.to(()=>MapSample());
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 46,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: textFieldC,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Cntr(
                              color: Colors.transparent,
                              width: Get.width / 1.5,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                myC.dokumenPendukung.isEmpty
                                    ? Get.find<JadwalSayaController>()
                                                .dataHospital['fileSupport']
                                                .toString() ==
                                            ""
                                        ? "Contoh : ISO, KARS, etc"
                                        : Get.find<JadwalSayaController>()
                                            .dataHospital['fileSupport']
                                            .toString()
                                    : myC.dokumenPendukung.value.substring(51),
                                style: greyTextStyle.copyWith(
                                    color: myC.dokumenPendukung.isNotEmpty
                                        ? blackColor
                                        : greyColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.upload,
                            color: Colors.grey[400],
                            size: 18,
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Alamat rumah sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                InkWell(
                  onTap: () async {
                    registerC.isHospital.value = true;
                    await registerC.getCurrentLocation().then((value) {
                      registerC.latHospital.value = value.latitude;
                      registerC.longHospital.value = value.longitude;
                    });
                    log(registerC.latHospital.value.toString());
                   await registerC.getUserLocation();

                    Get.to(() => MapSample(
                          lat: registerC.latHospital.value,
                          long: registerC.longHospital.value,
                        ));
                    // Get.to(()=>MapSample());
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 46,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: textFieldC,
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Obx(() => registerC.cityHospital.isNotEmpty
                        ? Text(
                            '${registerC.desaHospital.value} ${registerC.kecamatanHospital.value} ${registerC.cityHospital.value}, ${registerC.kabupatenHospital.value}, ${registerC.kodePosHospital.value}, ${registerC.negaraHospital.value}')
                        : registerC.isLoadingMaps.isTrue
                            ? Text(
                                "Memuat Maps....",
                                style: greyTextStyle.copyWith(
                                    color: registerC.cityHospital.isEmpty
                                        ? greyColor
                                        : Colors.black),
                              )
                            :
                            Get.find<JadwalSayaController>()
                                        .dataHospital
                                        .isNotEmpty
                                    ? Txt(
                                        text: Get.find<JadwalSayaController>()
                                                .dataHospital['district'] +
                                            " " +
                                            Get.find<JadwalSayaController>()
                                                .dataHospital['city'])
                                    : Row(
                                children: [
                                  Text(
                                    "Masukkan Lokasi anda",
                                    style: greyTextStyle.copyWith(
                                        color: registerC.cityHospital.isEmpty
                                            ? greyColor
                                            : Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    'Buka Maps',
                                    style: blueTextStyle.copyWith(
                                        fontWeight: bold),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Icon(
                                    Icons.open_in_new,
                                    color: blueColor,
                                    size: 18,
                                  )
                                ],
                              )),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Detail Alamat',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Cntr(
                    radius: BorderRadius.circular(10),
                    width: Get.width,
                    height: 120,
                    color: AppColor.bgForm,
                    border: Border.all(color: Colors.grey[350]!),
                    child: TextFormField(
                      controller: myC.alamatHospitalC,
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Alamat Tidak Boleh Kosong";
                        }
                      },
                      onTap: () async {},
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Deskripsi alamat lengkap",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Deskripsi rumah sakit',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Cntr(
                    radius: BorderRadius.circular(10),
                    width: Get.width,
                    height: 120,
                    color: AppColor.bgForm,
                    border: Border.all(color: Colors.grey[350]!),
                    child: TextFormField(
                      controller: myC.deskripsiHospitalC,
                      // ignore: body_might_complete_normally_nullable
                      validator: (alamat) {
                        if (alamat.toString().isEmpty) {
                          return "Alamat Tidak Boleh Kosong";
                        }
                      },
                      onTap: () async {},
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Deskripsi rumah sakit",
                          hintStyle:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    height: 45,
                    width: double.infinity,
                    child: Obx(() => ButtomGradient(
                        margin: 0,
                        label: myC.isLoading.isFalse
                            ? "Simpan Perubahan"
                            : "Loading...",
                        onTap: () async {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 290,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 18, top: 14),
                                        width: Get.width / 1.9,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffEDEDED)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Simpan perubahan?',
                                        style: subtitleTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 46,
                                      ),
                                      ButtomGradient(
                                          label: 'Simpan', onTap: () async {
                                            myC.updateProfileHospital();
                                          }),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ButtonPrimary(
                                          title: "Batal",
                                          onPressed: () {
                                            Get.back();
                                          })
                                    ],
                                  ),
                                );
                              });
                          // if (filesHospital == null ||
                          //     myC.namaHopitalC.text == "" ||
                          //     myC.emailHopitalC.text == "" ||
                          //     myC.nomerHospitalC.text == "" ||
                          //     myC.tahunBerdiriHospitalC.text == "" ||
                          //     myC.fileDokumenIjinOperasional == null ||
                          //     myC.fileDokumenPendukung == null ||
                          //     registerC.cityHospital.value == "" ||
                          //     myC.alamatHospitalC.text == "" ||
                          //     myC.deskripsiHospitalC.text == "") {
                          //   final snackBar = SnackBar(
                          //     behavior: SnackBarBehavior.floating,
                          //     duration: const Duration(seconds: 2),
                          //     margin: const EdgeInsets.symmetric(
                          //         vertical: 20, horizontal: 24),
                          //     content: const Text('Mohon Lengkapi Semua Data!'),
                          //     backgroundColor: (Colors.red),
                          //     action: SnackBarAction(
                          //       label: '',
                          //       onPressed: () {},
                          //     ),
                          //   );
                          //   ScaffoldMessenger.of(Get.context!)
                          //       .showSnackBar(snackBar);
                          // } else {

                          // myC.registerHospital(
                          //   latit: registerC.latHospital.value.toString(),
                          //   longin: registerC.longHospital.value.toString(),
                          //   districts: registerC.kecamatanHospital.value,
                          //   city: registerC.city.value,
                          //   country: registerC.negaraHospital.value,
                          //   deviceId: box.read('deviceId'),
                          //   picLat: registerC.lat.value.toString(),
                          //   picLong: registerC.long.value.toString(),
                          //   picDistrict: registerC.kecamatan.value,
                          //   picCity: registerC.city.value,
                          //   picCountry: registerC.negara.value,
                          //   filesPhoto: myC.files,
                          //   filesPhotoKtp: myC.fileDokumenKtp,
                          //   filesPhotoHospital: filesHospital,
                          //   filesPhotoDocumentLicence:
                          //       myC.fileDokumenIjinOperasional,
                          //   filesPhotoDocumentSupport:
                          //       myC.fileDokumenPendukung,
                          // );
                          // }

                          // Get.to(()=> EditProfileHospital());
                          // ignore: unused_local_variable
                          // File? image;
                          // final isValiForm = formKey.currentState!.validate();
                          // if (isValiForm) {
                          //   if (myC.isLoading.isFalse) {
                          //     if (files == null) {
                          //       showPopUp(
                          //           onTap: () {
                          //             Get.back();
                          //           },
                          //           imageAction: 'assets/json/eror.json',
                          //           description:
                          //               "Foto Profil\nTidak Boleh Kosong",
                          //           onPress: () {
                          //             Get.back();
                          //           });
                          //     } else if (registerC.city.isEmpty) {
                          //       final snackBar = SnackBar(
                          //         behavior: SnackBarBehavior.floating,
                          //         duration: const Duration(seconds: 1),
                          //         margin: const EdgeInsets.symmetric(
                          //             vertical: 10, horizontal: 24),
                          //         content: const Text(
                          //             'Mohon Masukkan Lokasi Anda Terlebih Dahulu!'),
                          //         backgroundColor: (Colors.red),
                          //         action: SnackBarAction(
                          //           label: '',
                          //           onPressed: () {},
                          //         ),
                          //       );
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackBar);
                          //     } else {
                          //       await myC.registerHospital(
                          //         name: myC.namaHospitalC.text,
                          //         email: myC.emailHospitalC.text,
                          //         phoneNumber: myC.nomerHospitalC.text,
                          //         description: myC.informasiHospitalC.text,
                          //         city: registerC.city.value,
                          //         country: registerC.negara.value,
                          //         districts: registerC.kecamatan.value,
                          //         latit: registerC.lat.value.toString(),
                          //         longin: registerC.long.value.toString(),
                          //         deviceId: box.read('deviceId'),
                          //         address: myC.alamatHospitalC.text,
                          //         files: files
                          //       );
                          //     }
                          //   }
                          // }
                        })))
                // Get.toNamed(Routes.LAYANAN);
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
