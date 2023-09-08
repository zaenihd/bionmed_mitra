import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/maps.dart';
import 'package:bionmed/app/modules/hospital_app/register_hospital/controllers/register_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/register_hospital/views/register_hospital_lanjutan_view.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class RegisterHospitalView extends StatefulWidget {
  const RegisterHospitalView({Key? key}) : super(key: key);

  @override
  State<RegisterHospitalView> createState() => _RegisterHospitalViewState();
}

class _RegisterHospitalViewState extends State<RegisterHospitalView> {
  final myC = Get.put(RegisterHospitalController());
  final registerC = Get.put(RegisterController());
  final loginC = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  bool isButtonActive = false;
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _pickerStr = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  // ignore: prefer_typing_uninitialized_variables
  var filesStr;

  @override
  void initState() {
    myC.namaOwnerC.addListener(() {
      final isButtonActive = myC.namaOwnerC.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myC.namaOwnerC.dispose();
    super.dispose();
  }

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    myC.files == file;
    myC.files = File(image.path);

    log('zezeze $myC.files');

    setState(() => myC.files = File(image.path));
    return file;
  }

  Future<File?> takePhotoStr(ImageSource source) async {
    final XFile? image = await _pickerStr.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    filesStr == file;
    filesStr = File(image.path);

    myC.imageUrlStr.value = filesStr.toString();
    log('zezeze ${myC.imageUrlStr}');
    setState(() => filesStr = File(image.path));
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

  void pickerFilesImageStr(BuildContext context) {
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
                  takePhotoStr(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  takePhotoStr(ImageSource.camera);
                  Get.back();
                },
              )
            ],
          );
        });
  }

  final status = ['Owner'];
  final jenisKelamin = ['Laki - laki', "Perempuan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: appbarBack(),
      body:
          // Obx(()=>
          // LoadingOverlay(
          //         isLoading: myC.isloading.value,
          //         progressIndicator: loadingIndicator(),
          //         color: Colors.transparent,
          //         opacity: 0.2,
          //         child:
          Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // myC.updateDokumenPendukung(myC.fileDokumenPendukung, "53");
                      },
                      child: HeaderWidget(
                          imageUrl: 'assets/icon/icon_biodata.png',
                          title: "Biodata Hospital",
                          subtitle:
                              "Isi data ini dengan lengkap untuk membuat \nakun anda"),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                        onTap: () {
                          pickerFilesImage(context);
                        },
                        child: myC.files == null
                            ? Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.weak2Color),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 42,
                                      color: AppColor.bodyColor[500],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Tambahkan foto",
                                      style: TextStyle(
                                        color: AppColor.bodyColor[500],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 120,
                                width: 120,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(
                                                48), // Image radius
                                            child: Image.file(myC.files,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned(
                                          left: 55,
                                          bottom: 5,
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 35,
                                            color: AppColor.bodyColor.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                    const SizedBox(height: 6),
                    const Text(
                      "Foto Profil",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // color: AppColor.bodyColor,
                          ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),

                    // const Text(
                    //   "Foto dokter wajib pakai jas dokter\nsaat foto dengan backround Putih",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(

                    //     fontSize: 10,
                    //       color: Colors.red,
                    //       ),
                    // ),

                    const SizedBox(height: 24),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Pemilik / Owner',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    InputPrimary(
                      onChange: (p0) {},
                      controller: myC.namaOwnerC,
                      onTap: () {},
                      hintText: 'Masukkan nama',
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Status',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: BorderStyles.borderGrey),
                      // dropdown below..
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: AppColor.bgForm,
                            filled: true,
                            hintText: "Pilih Status",
                            hintStyle: TextStyle(color: Colors.grey[500]!),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                        validator: (jKelamin) => jKelamin == null
                            ? "Status tidak boleh kosong"
                            : null,
                        items: status
                            .map((e) => DropdownMenuItem(
                                onTap: () {
                                  myC.selectedStatus.value = e.toString();
                                },
                                value: e,
                                child: Text(e.toString())))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'No KTP',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () async {
                        myC.pickerDokumenKtp();
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
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
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
                                    myC.dokumenKtp.isEmpty
                                        ? "Upload dokumen"
                                        : myC.dokumenKtp.value.substring(51),
                                    style: greyTextStyle.copyWith(
                                        color: myC.dokumenKtp.isNotEmpty
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
                    // InputPrimary(
                    //   onChange: (p0) {},
                    //   controller: myC.controllerNomerKTP,
                    //   onTap: () {},
                    //   hintText: 'Masukkan No KTP',
                    //   validate: (alamat) => alamat.toString().isEmpty
                    //       ? "Email tidak boleh kosong"
                    //       : null,
                    // ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Tanggal Lahir',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    InputPrimary(
                      controller: myC.tanggalLahirC,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          // ignore: avoid_print
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          // ignore: avoid_print
                          print(formattedDate);

                          setState(() {
                            myC.tanggalLahirC.text = formattedDate;
                          });
                        } else {
                          // ignore: avoid_print
                          print("Date is not selected");
                        }
                      },
                      hintText: "Masukkan tanggal lahir",
                      onChange: (val) {},
                      validate: (value) {
                        if (value.toString().isNotEmpty) {
                          return null;
                        }
                        return "Tanggal lahir tidak boleh kosong";
                      },
                      prefixIcon: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Jenis Kelamin',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: BorderStyles.borderGrey),
                      // dropdown below..
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: AppColor.bgForm,
                            filled: true,
                            hintText: "Pilih Jenis kelamin",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                        validator: (jKelamin) => jKelamin == null
                            ? "Jenis kelamin tidak boleh kosong"
                            : null,
                        items: jenisKelamin
                            .map((e) => DropdownMenuItem(
                                onTap: () {
                                  myC.selectedGender.value = e.toString();
                                },
                                value: e,
                                child: Text(e.toString())))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Alamat',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () async {
                        registerC.isHospital.value = false;

                        await registerC.getCurrentLocation().then((value) {
                          registerC.lat.value = value.latitude;
                          registerC.long.value = value.longitude;
                        });
                       await registerC.getUserLocation();

                        Get.to(() => MapSample(
                              lat: registerC.lat.value,
                              long: registerC.long.value,
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
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Obx(() => registerC.city.isNotEmpty
                            ? Text(
                                '${registerC.desa.value} ${registerC.kecamatan.value} ${registerC.city.value}, ${registerC.kabupaten.value}, ${registerC.kodePos.value}, ${registerC.negara.value}')
                            : registerC.isLoadingMaps.isTrue
                                ? Text(
                                    "Memuat Maps....",
                                    style: greyTextStyle.copyWith(
                                        color: registerC.city.isEmpty
                                            ? greyColor
                                            : Colors.black),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        "Masukkan Lokasi anda",
                                        style: greyTextStyle.copyWith(
                                            color: registerC.city.isEmpty
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
                    // InputPrimary(
                    //   validate: (kota) => kota.toString().isEmpty
                    //       ? "Kota tidak boleh kosong"
                    //       : null,
                    //   onChange: (p0) {},
                    //   controller: myC.controllerKota,
                    //   onTap: () {},
                    //   hintText: 'Isi kota anda',
                    // ),

                    const SizedBox(height: 16),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Detail Alamat',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    InputPrimary(
                      validate: (alamat) => alamat.toString().isEmpty
                          ? "Alamat tidak boleh kosong"
                          : null,
                      onChange: (p0) {},
                      controller: myC.alamatOwnerC,
                      onTap: () {},
                      hintText: 'Deskripsi alamat lengkap',
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  height: 45,
                  width: double.infinity,
                  child: isButtonActive
                      ? Obx(() => ButtomGradient(
                          label: myC.isLoading.isFalse
                              ? "Lanjutkan"
                              : "Loading...",
                          onTap: () async {
                            if (myC.namaOwnerC.text == "" ||
                                myC.selectedStatus.value == "" ||
                                myC.fileDokumenKtp == null ||
                                myC.tanggalLahirC.text == "" ||
                                myC.selectedGender.value == "" ||
                                registerC.city.value == "" ||
                                myC.alamatOwnerC.text == "") {
                              final snackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 24),
                                content:
                                    const Text('Mohon Lengkapi Semua Data!'),
                                backgroundColor: (Colors.red),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(Get.context!)
                                  .showSnackBar(snackBar);
                            } else if (myC.files == null) {
                              final snackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 24),
                                content:
                                    const Text('Foto Profil Tidak Boleh Kosong!'),
                                backgroundColor: (Colors.red),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(Get.context!)
                                  .showSnackBar(snackBar);
                            } else {
                              Get.to(() => const RegisterHospitalLanjutanView());
                            }

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
                            //         name: myC.namaOwnerC.text,
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
                          }))
                      // Get.toNamed(Routes.LAYANAN);
                      : ButtonPrimary(
                          title: "Lanjutkan",
                          onPressed: () {
                            log(
                              registerC.lat.value.toString(),
                            );
                            log(
                              registerC.long.value.toString(),
                            );
                            // Get.toNamed(Routes.LAYANAN);
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
