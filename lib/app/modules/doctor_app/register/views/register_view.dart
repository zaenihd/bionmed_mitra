import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/maps.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/styles.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final myC = Get.put(RegisterController());
  final loginC = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  final jenisKelamin = ['Laki - laki', "Perempuan"];
  bool isButtonActive = false;
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;

  @override
  void initState() {
    myC.controllerName.addListener(() {
      final isButtonActive = myC.controllerName.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myC.controllerName.dispose();
    super.dispose();
  }

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    setState(() => files = File(image.path));
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
                  // if (await Permission.storage.request().isGranted) {
                  // Get.back();
                  // }
                  takePhoto(ImageSource.gallery);
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
                        title: "Biodata",
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

                    const Text(
                      "Foto dokter wajib pakai jas dokter\nsaat foto dengan backround Putih",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    ),

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
                      controller: myC.controllerName,
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
                      controller: myC.controllerDate,
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
                            myC.controllerDate.text = formattedDate;
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
                                  myC.selectedValue = e.toString();
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
                      controller: myC.controllerPengalaman,
                      onTap: () {},
                      hintText: 'contoh : 10 tahun',
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Nomer STR',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    InputPrimary(
                      validate: (nomerStr) => nomerStr.toString().isEmpty
                          ? "Nomer STR tidak boleh kosong"
                          : null,
                      onChange: (p0) {},
                      controller: myC.controllerNomerStr,
                      onTap: () {},
                      hintText: 'Masukkan nomer STR',
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Nomer SIP',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    InputPrimary(
                      validate: (nomerStr) => nomerStr.toString().isEmpty
                          ? "Nomer SIP tidak boleh kosong"
                          : null,
                      onChange: (p0) {},
                      controller: myC.controllerNomerSip,
                      onTap: () {},
                      hintText: 'Masukkan nomer SIP',
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
                        await myC.getCurrentLocation().then((value) {
                          myC.lat.value = value.latitude;
                          myC.long.value = value.longitude;
                        });
                        myC.getUserLocation();

                        Get.to(() => MapSample(
                              lat: myC.lat.value,
                              long: myC.long.value,
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
                        child: Obx(() => myC.city.isNotEmpty
                            ? Text(
                                '${myC.desa.value} ${myC.kecamatan.value} ${myC.city.value}, ${myC.kabupaten.value}, ${myC.kodePos.value}, ${myC.negara.value}')
                            : myC.isLoadingMaps.isTrue
                                ? Text(
                                    "Memuat Maps....",
                                    style: greyTextStyle.copyWith(
                                        color: myC.city.isEmpty
                                            ? greyColor
                                            : Colors.black),
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        "Masukkan Lokasi anda",
                                        style: greyTextStyle.copyWith(
                                            color: myC.city.isEmpty
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
                      controller: myC.controllerAlamat,
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
                                } else if (myC.city.isEmpty ||
                                    myC.lat.value == 0.0 ||
                                    myC.long.value == 0.0) {
                                  final snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 24),
                                    content: const Text(
                                        'Mohon Masukkan Lokasi Maps Anda Terlebih Dahulu!'),
                                    backgroundColor: (Colors.red),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  await myC.register(
                                      name: myC.controllerName.text,
                                      brithdayDate: myC.controllerDate.text,
                                      address: myC.controllerAlamat.text,
                                      gender: myC.selectedValue,
                                      phoneNumber: loginC.controllerPhone.text,
                                      experience: myC.controllerPengalaman.text,
                                      strNumber: myC.controllerNomerStr.text,
                                      sipNumber: myC.controllerNomerSip.text,
                                      city: myC.city.value,
                                      country: myC.negara.value,
                                      districts: myC.kecamatan.value,
                                      latit: myC.lat.value.toString(),
                                      longin: myC.long.value.toString(),
                                      deviceId: box.read('deviceId'),
                                      files: files);
                                  Get.toNamed(Routes.LAYANAN);
                                  // print(myC.lat.value.toString() + " .  "+ myC.long.value.toString());
                                }
                              }
                            }
                          }))
                      // Get.toNamed(Routes.LAYANAN);
                      : ButtonPrimary(
                          title: "Lanjutkan",
                          onPressed: () {
                            // ignore: prefer_interpolation_to_compose_strings
                            log('lat long ' +
                                myC.lat.value.toString() +
                                "  " +
                                myC.long.value.toString());
                            // Get.toNamed(Routes.LAYANAN);
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
