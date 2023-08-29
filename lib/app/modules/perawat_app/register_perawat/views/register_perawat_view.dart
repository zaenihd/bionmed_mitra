import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/maps.dart';
import 'package:bionmed/app/modules/perawat_app/register_perawat/controllers/register_perawat_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/styles.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class RegisterPerawatView extends StatefulWidget {
  const RegisterPerawatView({Key? key}) : super(key: key);

  @override
  State<RegisterPerawatView> createState() => _RegisterPerawatViewState();
}

class _RegisterPerawatViewState extends State<RegisterPerawatView> {
  final myC = Get.put(RegisterPerawatController());
  final registerC = Get.put(RegisterController());
  final loginC = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  final jenisKelamin = ['Laki - laki', "Perempuan"];
  bool isButtonActive = false;
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _pickerStr = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;
  // ignore: prefer_typing_uninitialized_variables
  var filesStr;

  @override
  void initState() {
    myC.nameNurseC.addListener(() {
      final isButtonActive = myC.nameNurseC.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myC.nameNurseC.dispose();
    super.dispose();
  }

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    files = File(image.path);

    log('zezeze $files');

    setState(() => files = File(image.path));
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
    setState(() => filesStr= File(image.path));
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
                onTap: () async{
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
                onTap: ()async {
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
                    HeaderWidget(
                        imageUrl: 'assets/icon/icon_biodata.png',
                        title: "Biodata Perawat",
                        subtitle:
                            "Isi data ini dengan lengkap untuk membuat \nakun anda"),
                    const SizedBox(height: 32),
                    GestureDetector(
                        onTap: () {
                          pickerFilesImage(context);
                        },
                        child: files == null
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
                                            child: Image.file(files,
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
                        'Nama Lengkap',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    InputPrimary(
                      onChange: (p0) {},
                      controller: myC.nameNurseC,
                      onTap: () {},
                      hintText: 'Masukkan nama lengkap',
                    ),
                    const SizedBox(height: 16),
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
                      controller: myC.tanggalLahirNurseC,
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
                            myC.tanggalLahirNurseC.text = formattedDate;
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
                    const SizedBox(height: 16),
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
                                  registerC.selectedValue = e.toString();
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
                        'Agama',
                        textAlign: TextAlign.left,
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    InputPrimary(
                      validate: (agama) {
                        if (agama.toString().isNotEmpty) {
                          return null;
                        }
                        return "agama tidak boleh kosong";
                      },
                      onChange: (p0) {},
                      controller: myC.controlleragama,
                      onTap: () {},
                      hintText: 'Masukkan agama anda',
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Pengalaman',
                        textAlign: TextAlign.left,
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    InputPrimary(
                      validate: (pengalaman) {
                        if (pengalaman.toString().isNotEmpty) {
                          return null;
                        }
                        return "Pengalaman tidak boleh kosong";
                      },
                      onChange: (p0) {},
                      controller: myC.pengalamanC,
                      onTap: () {},
                      hintText: 'Contoh : 10 Tahun',
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Nomer STR',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                    height: 10.0,
                    ),
                    InkWell(
                onTap: () async {
                  pickerFilesImageStr(context);
                },
                child: Cntr(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  height: 45,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.upload,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // Obx(() => 
                      SizedBox(
                            width: Get.width / 2,
                            child: Txt(
                              maxLines: 1,
                              textOverFlow: TextOverflow.ellipsis,
                              text: 
                               myC.imageUrlStr.value == ''
                                  ? 'Upload Dokumen STR'
                                  : myC.imageUrlStr.value,
                              color: myC.imageUrlStr.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          )
                          // )
                    ],
                  ),
                ),
              ),
                    InputPrimary(
                      validate: (nomerStr) => nomerStr.toString().isEmpty
                          ? "Nomer STR tidak boleh kosong"
                          : null,
                      onChange: (p0) {},
                      controller: myC.monerStrNurseC,
                      onTap: () {},
                      hintText: 'Masukkan nomer STR',
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Lokasi',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () async {
                        await registerC.getCurrentLocation().then((value) {
                          registerC.lat.value = value.latitude;
                          registerC.long.value = value.longitude;
                        });
                        registerC.getUserLocation();

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
                        'Alamat Lengkap',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    InputPrimary(
                      validate: (alamat) => alamat.toString().isEmpty
                          ? "Alamat tidak boleh kosong"
                          : null,
                      onChange: (p0) {},
                      controller: myC.alamatNurseC,
                      onTap: () {},
                      hintText:
                          'Masukkan detail lokasi *Contoh : Pinggir Apotik',
                    ),
                    const SizedBox(height: 10),
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
                            // ignore: unused_local_variable
                            File? image;
                            final isValiForm = formKey.currentState!.validate();
                            if (isValiForm) {
                              if (myC.isLoading.isFalse) {
                                if (files == null) {
                                  showPopUp(
                                      onTap: () {
                                        Get.back();
                                      },
                                      imageAction: 'assets/json/eror.json',
                                      description:
                                          "Foto Profil\nTidak Boleh Kosong",
                                      onPress: () {
                                        Get.back();
                                      });
                                } else if (registerC.city.isEmpty) {
                                  final snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 24),
                                    content: const Text(
                                        'Mohon Masukkan Lokasi Anda Terlebih Dahulu!'),
                                    backgroundColor: (Colors.red),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  await myC.registerNurse(
                                      name: myC.nameNurseC.text,
                                      pengalaman: myC.pengalamanC.text,
                                      brithdayDate: myC.tanggalLahirNurseC.text,
                                      address: myC.alamatNurseC.text,
                                      gender: registerC.selectedValue,
                                      phoneNumber: loginC.controllerPhone.text,
                                      strNumber: myC.monerStrNurseC.text,
                                      latit: registerC.lat.value.toString(),
                                      longin: registerC.long.value.toString(),
                                      districts:
                                          registerC.kecamatan.value.toString(),
                                      city: registerC.city.value.toString(),
                                      country:
                                          registerC.negara.value.toString(),
                                      deviceId: box.read('deviceId'),
                                      religion: myC.controlleragama.text,
                                      files: files,
                                      filesStr: filesStr);
                                  // await myC.register(
                                  //     // image: files.toString(),
                                  //     name: myC.controllerName.text,
                                  //     brithdayDate: myC.controllerDate.text,
                                  //     address: myC.controllerAlamat.text,
                                  //     gender: myC.selectedValue,
                                  //     phoneNumber: loginC.controllerPhone.text,
                                  //     experience: myC.controllerPengalaman.text,
                                  //     strNumber: myC.controllerNomerStr.text,
                                  //     sipNumber: myC.controllerNomerSip.text,
                                  //     city: myC.city.value,
                                  //     country: myC.negara.value,
                                  //     districts: myC.kecamatan.value,
                                  //     latit: myC.lat.value.toString(),
                                  //     longin: myC.long.value.toString(),
                                  //     deviceId: box.read('deviceId'),
                                  //     files: files);
                                  // Get.toNamed(Routes.LAYANAN);
                                  // Get.to(() => const LayananSucces());d
                                  popUpSelesai();
                                }
                              }
                            }
                          }))
                      // Get.toNamed(Routes.LAYANAN);
                      : ButtonPrimary(
                          title: "Lanjutkan",
                          onPressed: () {
                            log(registerC.lat.value.toString(),);
                            log(registerC.long.value.toString(),);
                            // Get.toNamed(Routes.LAYANAN);
                          })),
            ],
          ),
        ),
      ),
    );
  }
  popUpSelesai() {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/images/terkirim.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(
                            text: 'Berhasil Terkirim',
                            size: 16,
                            weight: bold,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Data anda sudah kami terima, dan saat ini masih dalam proses. waktu maksimal 3 Hari kerja akan kami konfirmasi kembali',
                            style: TextStyle(fontSize: 12, fontWeight: light),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Selesai",
                            onTap: () {
                              Get.back();
                              Get.offAllNamed(Routes.LOGIN);

                              //   loginC.controllerPhone.clear();
                            },
                          )
                        ])
                  ]));
        });
  }
}
