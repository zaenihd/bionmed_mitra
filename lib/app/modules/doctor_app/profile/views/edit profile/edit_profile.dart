import 'dart:io';

import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/maps.dart';
import 'package:bionmed/app/modules/perawat_app/register_perawat/controllers/register_perawat_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../widget/button/button_gradien.dart';
import '../../../../../widget/textform/input_primary1.dart';
import '../../../jadwal_saya/controllers/jadwal_saya_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final myC = Get.put(ProfileController());
  final loginC = Get.put(LoginController());
  final loginCv2 = Get.put(JadwalSayaController());
  final registerC = Get.put(RegisterController());

  bool isButtonActive = false;

  @override
  void initState() {
    myC.controllerName.addListener(() {
      final isButtonActive = myC.controllerName.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    myC.controllerNomerStr.addListener(() {
      final isButtonActive = myC.controllerNomerStr.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    myC.controllerPengalaman.addListener(() {
      final isButtonActive = myC.controllerPengalaman.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    myC.controllerDate.addListener(() {
      final isButtonActive = myC.controllerDate.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // myC.controllerName.dispose();
    // myC.controllerDate.dispose();
    // myC.controllerNomerStr.dispose();
    // myC.controllerPengalaman.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;

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
                onTap: ()async {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Isi profile anda sesuai dengan identitas asli anda agar \nkami mudah menginformasikan',
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                    onTap: () {
                      pickerFilesImage(context);
                    },
                    child: files == null
                        ? Stack(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${loginCv2.profileImage}'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    color: AppColor.weak2Color),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    // Icon(
                                    //   Icons.add_a_photo_outlined,
                                    //   size: 42,
                                    //   color: AppColor.bodyColor[500],
                                    // ),
                                    // const SizedBox(height: 6),
                                    // Text(
                                    //   "Tambahkan foto",
                                    //   style: TextStyle(
                                    //     color: AppColor.bodyColor[500],
                                    //     fontSize: 11,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 80,
                                bottom: 5,
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 35,
                                  color: AppColor.bodyColor.shade500,
                                ),
                              ),
                            ],
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
                  height: 26.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Masukkan Nama',
                    textAlign: TextAlign.left,
                  ),
                ),
                InputPrimary(
                  // initialValue: 'hh',
                  // initialValue: "${loginC.name}",
                  hintText: "Masukkan nama lengkap",
                  onChange: (p0) {},
                  controller: myC.controllerName,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 12.0,
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
                  // initialValue: "${loginC.dataUser['doctor']['experience']}",
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
                      vertical: 10,
                      horizontal: 10,
                    ),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: textFieldC,
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Obx(() => registerC.city.isEmpty
                        ? Text(loginC.role.value == 'nurse'
                            ? '${loginC.dataUser['nurse']['districts']}, ${loginC.dataUser['nurse']['city']} ${loginC.dataUser['nurse']['country']}\n${loginC.dataUser['nurse']['address']}'
                            : '${loginC.dataUser['doctor']['districts']}, ${loginC.dataUser['doctor']['city']} ${loginC.dataUser['doctor']['country']}\n${loginC.dataUser['doctor']['address']}')
                        : registerC.isLoadingMaps.isTrue
                            ? Text(
                                "Memuat Maps....",
                                style: greyTextStyle.copyWith(
                                    color: registerC.city.isEmpty
                                        ? greyColor
                                        : Colors.black),
                              )
                            : Text(
                                '${registerC.desa.value} ${registerC.kecamatan.value} ${registerC.city.value}, ${registerC.kabupaten.value}, ${registerC.kodePos.value} ${registerC.negara.value}')),
                  ),
                ),
                Visibility(
                  visible: loginC.role.value != 'nurse',
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Pengalaman',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      InputPrimary(
                        onChange: (p0) {},
                        controller: myC.controllerPengalaman,
                        onTap: () {},
                        hintText: 'contoh : 10 tahun',
                      ),
                    ],
                  ),
                ),
                // ignore: avoid_unnecessary_containers
                const SizedBox(height: 20),
                Visibility(
                  visible: loginC.role.value != 'nurse',
                  child: Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Nomer STR',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      InputPrimary(
                        // initialValue: "${loginC.dataUser['doctor']['strNumber']}",
                        onChange: (p0) {},
                        controller: myC.controllerNomerStr,
                        onTap: () {},
                        hintText: 'Masukkan nomer STR',
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: loginC.role.value != 'nurse',
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Nomer SIP',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      InputPrimary(
                        // initialValue: "${loginC.dataUser['doctor']['strNumber']}",
                        onChange: (p0) {},
                        controller: myC.controllerNomerSip,
                        onTap: () {},
                        hintText: 'Masukkan nomer SIP',
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            margin: const EdgeInsets.only(bottom: 24),
            height: 45,
            width: double.infinity,
            child: ButtomGradient(
                label: "Simpan",
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 270,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 18, top: 14),
                              width: Get.width / 1.9,
                              height: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffEDEDED)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Anda yakin ingin mengubah biodata ini ?',
                              style:
                                  blackTextStyle.copyWith(fontWeight: medium),
                            ),
                            const SizedBox(
                              height: 36.0,
                            ),
                            Obx(
                              () => ButtomGradient(
                                  label: myC.loading.isFalse
                                      ? "Simpan"
                                      : "Loading....",
                                  onTap: () async {
                                   
                                    if (myC.loading.isFalse) {
                                      if (Get.find<LoginController>()
                                              .role
                                              .value ==
                                          'nurse') {
                                        await myC.updateProfilNurse(
                                          name: myC.controllerName.value.text,
                                          brithdayDate:
                                              myC.controllerDate.value.text,
                                          address:
                                              '${registerC.desa.value} ${registerC.kecamatan.value} ${registerC.city.value}, ${registerC.kabupaten.value}, ${registerC.kodePos.value} ${registerC.negara.value}',
                                        );
                                        if (files != null) {
                                          await Get.put(
                                                  RegisterPerawatController())
                                              .updateImage(
                                                  files,
                                                  Get.find<LoginController>()
                                                      .userIdLogin
                                                      .toString());
                                        }
                                      } else {
                                        await myC.updateProfil(
                                          address: loginC.address.value,
                                          gender: loginC.jenisKelamin.value,
                                          // phoneNumber: loginC.phoneNumberUser.value,
                                          name: myC.controllerName.value.text,
                                          brithdayDate:
                                              myC.controllerDate.value.text,
                                          experience: myC
                                              .controllerPengalaman.value.text,
                                          strNumber:
                                              myC.controllerNomerStr.value.text,
                                          sipNumber:
                                              myC.controllerNomerSip.value.text,
                                              lat: registerC.lat.value.toString(),
                                              long: registerC.long.value.toString(),
                                          files: files,
                                        );
                                      }
                                      final box = GetStorage();
                                      // ignore: unused_local_variable
                                      var phone = await box.read('phone');
                                       if (loginC.role.value == 'nurse') {
                                      Get.find<JadwalSayaController>()
                                          .loginDataNurse(
                                              phoneNumber:
                                                  Get.find<LoginController>()
                                                      .phoneNumberUser
                                                      .value);
                                    } else {
                                      Get.find<JadwalSayaController>()
                                          .loginData(
                                              phoneNumber:
                                                  Get.find<LoginController>()
                                                      .phoneNumberUser
                                                      .value);
                                    }
                                      // if (phone != null) {
                                      //   await Get.put(JadwalSayaController())
                                      //       .loginData(phoneNumber: phone);
                                      // }
                                      Get.back();
                                      Get.back();
                                    }

                                    // Get.off( ()=>PengaturanAkun());
                                    // Get.offNamed(Routes.PROFILE);
                                    // myC.controllerDate.clear();
                                    // myC.controllerName.clear();
                                    // myC.controllerPengalaman.clear();
                                    // myC.controllerNomerStr.clear();
                                  }),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              height: 45,
                              width: Get.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      backgroundColor: buttonColor),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Batal")),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })
            // Get.toNamed(Routes.LAYANAN);),
            ));
  }
}
