import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/views/list_jadwal.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/views/riwayat_pesanan.dart';
import 'package:bionmed/app/modules/doctor_app/login/views/disclamer.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/edit%20profile/pengaturan_akun.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/paket_layanan.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_view.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/profil_login_required.dart';
import 'package:bionmed/app/modules/hospital_app/profile/pengaturan%20akun/pengaturan_akun_hospital.dart';
import 'package:bionmed/app/modules/perawat_app/list_service_nurse/controllers/list_service_nurse_controller.dart';
import 'package:bionmed/app/modules/perawat_app/paket_layanan_nurse/controllers/paket_layanan_nurse_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widget/card/card_layanan.dart';
import '../../../hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import '../../../perawat_app/list_service_nurse/views/list_service_nurse_edit.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final loginC = Get.put(LoginController());
  final loginCv2 = Get.put(JadwalSayaController());

  @override
  Widget build(BuildContext context) {
    if (loginC.role.value == 'nurse') {
      Get.find<JadwalSayaController>().loginDataNurse(
          phoneNumber: Get.find<LoginController>().phoneNumberUser.value);
    } else if (loginC.role.value == 'hospital') {
      Get.find<JadwalSayaController>().loginDataHospital(
          phoneNumber: Get.find<LoginController>().phoneNumberUser.value);
    } else {
      Get.find<JadwalSayaController>().loginData(
          phoneNumber: Get.find<LoginController>().phoneNumberUser.value);
    }
    Get.put(PaketLayananNurseController()).isTimHospital.value = false;

    // final box = GetStorage();
    // var phone = box.read('phone');
    // if (phone != null) {
    //   Get.put(JadwalSayaController()).loginData(phoneNumber: phone);
    // }
    return loginC.name.isEmpty
        ? const ProfilLoginRequired()
        : Scaffold(
            backgroundColor: backgroundColorC,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(children: [
                    // SizedBox(
                    //     width: Get.width,
                    //     child: Image.asset('assets/icon/Ellipse 179.png')),
                    Container(
                      width: Get.width,
                      height: 250,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icon/Ellipse 179.png'),
                              fit: BoxFit.cover)),
                      // child: Image.asset('assets/icon/Ellipse 179.png', )
                    ),
                    Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Container(
                              margin: const EdgeInsets.only(top: 100),
                              width: 142,
                              height: 142,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 6),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          // ignore: prefer_if_null_operators, unnecessary_null_comparison, unrelated_type_equality_checks
                                          '${loginCv2.profileImage == '' || loginCv2.profileImage == null ? "https://i.pinimg.com/564x/e1/77/47/e17747c78dd89a1d9522c5da154128b2.jpg" : loginCv2.profileImage}'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Text(
                              '${loginCv2.name}',
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: bold),
                            );
                          }),
                          const SizedBox(
                            height: 6,
                          ),
                          Obx(
                            () => SizedBox(
                              width: 200,
                              child: Text(
                                '${loginCv2.spesialis}',
                                textAlign: TextAlign.center,
                                style: blackTextStyle.copyWith(
                                    color: const Color(0xff292929)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Visibility(
                            visible: loginC.role.value == 'hospital' ||
                                loginC.inHospital.value == "",
                            child: cardNameOwnerHospital(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            width: Get.width,
                            // height: 100,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(4, 8),
                                      color: Color.fromARGB(255, 225, 223, 223))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => PendapatanView());
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/image 36.png'),
                                                fit: BoxFit.cover)),
                                        // child: Image.asset('assets/images/image 36.png')
                                      ),
                                    ),
                                    Text(
                                      'Pendapatan',
                                      style: subtitleTextStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                    AutoSizeText(
                                      maxLines: 1,
                                      CurrencyFormat.convertToIdr(
                                          Get.find<HomeController>()
                                              .pendapatan
                                              .value,
                                          0),
                                      style: greenTextStyle.copyWith(
                                          fontWeight: bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/icon_rating.png'),
                                              fit: BoxFit.cover)),
                                      // child: Image.asset('assets/images/image 36.png')
                                    ),
                                    Text(
                                      'Penilaian',
                                      style: subtitleTextStyle.copyWith(
                                          fontSize: 11),
                                    ),
                                    Text(
                                      '${loginC.rating}',
                                      style: greenTextStyle.copyWith(
                                          fontSize: 16, color: yellowColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 26),
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aktifitas',
                                  style: subtitleTextStyle.copyWith(
                                      fontSize: 16, fontWeight: bold),
                                ),
                                ListAktifitas(
                                  iconUrl: 'assets/icon/icon_ativitas.png',
                                  label: loginC.role.value == 'hospital' ||
                                          loginC.inHospital.value == ""
                                      ? "Pengaturan Akun"
                                      : 'Profil',
                                  onTap: () async {
                                    if (loginC.role.value != 'hospital') {
                                      Get.put(PaketLayananNurseController())
                                          .isTimHospital
                                          .value = true;
                                    }
                                    // final box = GetStorage();
                                    // var phone = await box.read('phone');
                                    // if (phone != null) {
                                    //   await Get.put(JadwalSayaController())
                                    //       .loginData(phoneNumber: phone);
                                    // }
                                    if (loginC.role.value == 'hospital' ||
                                        loginC.inHospital.value == "") {
                                      Get.to(() => PengaturanAkunHospital());
                                    } else {
                                      Get.to(() => PengaturanAkun());
                                    }
                                  },
                                ),
                                loginC.role.value == "hospital" ||
                                        loginC.inHospital.value == ""
                                    ? const SizedBox(
                                        height: 1.0,
                                      )
                                    : ListAktifitas(
                                        iconUrl:
                                            'assets/icon/icon_ativitas1.png',
                                        label: 'Jadwal saya',
                                        onTap: () async {
                                          if (Get.put(
                                                  ListServiceNurseController())
                                              .listServiceNurseData
                                              .isEmpty) {
                                            await Get.put(
                                                    ListServiceNurseController())
                                                .listServiceNurse();
                                          }
                                          // final box = GetStorage();
                                          // var phone = await box.read('phone');
                                          // if (phone != null) {
                                          //   await Get.put(JadwalSayaController())
                                          //       .loginData(phoneNumber: phone);
                                          // }
                                          // Get.toNamed(Routes.JADWAL_SAYA);
                                          Get.to(() => ListJadwal());

                                          // Get.to(()=> EditJadwal());
                                        },
                                      ),
                                loginC.role.value == "hospital"
                                    ? ListAktifitas(
                                        iconUrl:
                                            'assets/icon/icon_ativitas2.png',
                                        label: loginC.role.value == 'hospital'
                                            ? "Layanan"
                                            : 'Paket Layanan',
                                        onTap: () async {
                                          if (loginC.role.value == 'hospital') {
                                            log('message');
                                            await Get.find<
                                                    LengkapiDataHospitalController>()
                                                .serviceHospital();

                                            Get.toNamed(
                                                Routes.PAKET_LAYANAN_HOSPITAL);
                                            // Get.to(
                                            //     () => const PengaturanAkunHospital());
                                          } else {
                                            // Get.to(() => PengaturanAkun());
                                            Get.put(ListServiceNurseController())
                                                .listServiceNurse();
                                            // await Get.put(ListServiceNurseController())
                                            //   .listServiceNurse();
                                            loginC.role.value == "nurse"
                                                ? Get.to(() =>
                                                    ListServiceNurseViewEdit())
                                                : Get.to(() => PaketLayanan());
                                          }
                                        },
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                loginC.inHospital.value == "dokter" ||
                                        loginC.inHospital.value == "0"
                                    ? ListAktifitas(
                                        iconUrl:
                                            'assets/icon/icon_ativitas2.png',
                                        label: loginC.role.value == 'hospital'
                                            ? "Layanan"
                                            : 'Paket Layanan',
                                        onTap: () async {
                                          if (loginC.role.value == 'hospital') {
                                            // Get.to(
                                            //     () => const PengaturanAkunHospital());
                                          } else {
                                            // Get.to(() => PengaturanAkun());
                                            Get.put(ListServiceNurseController())
                                                .listServiceNurse();
                                            // await Get.put(ListServiceNurseController())
                                            //   .listServiceNurse();
                                            loginC.role.value == "nurse"
                                                ? Get.to(() =>
                                                    ListServiceNurseViewEdit())
                                                : Get.to(() => PaketLayanan());
                                          }
                                        },
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                ListAktifitas(
                                  iconUrl: 'assets/icon/icon_ativitas3.png',
                                  label: loginC.role.value == 'hospital' ||
                                          loginC.inHospital.value == ""
                                      ? "Transaksi & Tarik Saldo"
                                      : 'Riwayat Transaksi',
                                  onTap: () {
                                    Get.to(() => RiwayatPesanan());

                                    // showPopUp(
                                    //     onTap: () {
                                    //       Get.back();
                                    //     },
                                    //     imageAction: 'assets/json/eror.json',
                                    //     description: "Under Development");
                                  },
                                ),
                                ListAktifitas(
                                  iconUrl: 'assets/icon/icon_ativitas4.png',
                                  label: 'Kebijakan Privasi',
                                  onTap: () {
                                    Get.to(() => Disclamer());
                                    // Get.put(AccountController())
                                    //     .ketentuanPengguna();

                                    // showPopUp(
                                    //     onTap: () {
                                    //       Get.back();
                                    //     },
                                    //     imageAction: 'assets/json/eror.json',
                                    //     description: "Under Development");
                                  },
                                ),
                                InkWell(
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color(
                                                        0xffEDEDED)),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                'Anda yakin ingin keluar sekarang?',
                                                style: blackTextStyle.copyWith(
                                                    fontWeight: medium),
                                              ),
                                              const SizedBox(
                                                height: 36.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 312,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                        backgroundColor:
                                                            Colors.red),
                                                    onPressed: () {
                                                      Get.find<
                                                              LayananHomeController>()
                                                          .stopTimePeriodic();
                                                      Get.offAllNamed(
                                                          Routes.ACCOUNT);
                                                      final box = GetStorage();
                                                      box.remove('phone');
                                                      box.remove('rememberme');
                                                      box.remove(
                                                          'dontShowAgain');
                                                      box.remove('idAccount');
                                                      box.remove('popUp');
                                                    },
                                                    child:
                                                        const Text("Keluar")),
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 312,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                        backgroundColor:
                                                            buttonColor),
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
                                    Get.find<LoginController>()
                                        .controllerPhone
                                        .clear();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    height: 60,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/icon/icon_keluar.png'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Keluar',
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ));
  }

  Cntr cardNameOwnerHospital() {
    return Cntr(
      radius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      gradient: gradient1,
      child: Row(
        children: [
          Cntr(
            height: 35,
            width: 35,
            radius: BorderRadius.circular(100),
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(loginCv2.profileImagePic.value)),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                text: 'Pemilik / Owner',
                size: 10,
                color: Colors.white,
              ),
              Txt(
                text: loginCv2.namePic.value,
                size: 14,
                color: Colors.white,
                weight: bold,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListAktifitas extends StatelessWidget {
  ListAktifitas(
      {Key? key,
      required this.iconUrl,
      required this.label,
      required this.onTap})
      : super(key: key);

  String iconUrl;
  String label;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      width: Get.width,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: textFieldC),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(iconUrl),
        title: Text(
          label,
          style: subtitleTextStyle.copyWith(),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
