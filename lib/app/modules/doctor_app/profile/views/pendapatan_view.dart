import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_doctor_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_nurse_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/penarikan_saldo_view.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/buat_kode_akses.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/edit_kode_pin.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/riwayat_transaksi.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/tambah_rekening_view.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/card/card_layanan.dart';
import '../../../../widget/container/container.dart';
import '../controllers/profile_controller.dart';

class PendapatanView extends GetView<ProfileController> {
  PendapatanView({Key? key}) : super(key: key);

  final loginC = Get.put(LoginController());
  final controllerDoctor = Get.put(SaldoDanRekeningDoctorController());
  final controllerNurse = Get.put(SaldoDanRekeningNurseController());
  final loginCv2 = Get.put(JadwalSayaController());

  @override
  Widget build(BuildContext context) {
    if (loginC.role.value == 'nurse') {
      controllerNurse.listBanknurse();
    } else if (loginC.role.value == 'hospital') {
      controllerNurse.listBankHospital();
    } else {
      controllerDoctor.listBankDoctor();
    }
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => RiwayatPenarikanSaldo());
              },
              icon: const Icon(
                Icons.history,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: greyColor,
            )),
        backgroundColor: backgroundColorC,
        title: Text(
          'Pendapatan',
          style: blueTextStyle.copyWith(fontSize: 20, fontWeight: bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              width: Get.width,
              height: 148,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Color.fromARGB(255, 225, 223, 223))
              ], color: whiteColor, borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                Container(
                  alignment: Alignment.topRight,
                  width: Get.width,
                  height: 148,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/icon/icon_side.png'),
                          alignment: Alignment.topRight)),
                  // child: Image.asset('assets/icon/icon_side.png')
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: Get.width,
                  height: 148,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/icon/icon_side1.png'),
                          alignment: Alignment.bottomLeft)),
                  // child: Image.asset('assets/icon/icon_side.png')
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  width: Get.width,
                  height: 148,
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Saldo pendapatan terkini :',
                        style: blackTextStyle.copyWith(
                            fontSize: 10, fontWeight: medium),
                      ),
                      // Image.asset('assets/icon/icon_wallet.png', height: 60,),
                      // Cntr(
                      //   height: 70,
                      //   width: 70,
                      //   image: const DecorationImage(
                      //       image: AssetImage('assets/icon/icon_wallet.png'),fit: BoxFit.cover),
                      // ),
                      AutoSizeText(
                        maxLines: 1,
                        CurrencyFormat.convertToIdr(
                            Get.find<HomeController>().pendapatan.value, 0),
                        style: greenTextStyle.copyWith(
                            fontWeight: bold, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  width: Get.width,
                  height: 148,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      loginCv2.codeAccess.value != "null" &&
                                  loginC.role.value == "hospital" ||
                              loginCv2.codeAccess.value == ""
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon/icon_wallet.png',
                                      height: 60,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Txt(
                                          text: loginC.name.value,
                                          weight: bold,
                                        ),
                                        Txt(
                                          text: '',
                                          weight: light,
                                          size: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                loginC.role.value == "hospital"
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30.0),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => EditKodeAkses());
                                          },
                                          child: const Icon(
                                            Icons.edit_note_sharp,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 1.0,
                                      ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Cntr(
                                  onTap: () {
                                    Get.to(() => BuatKodeAkses());
                                  },
                                  radius: BorderRadius.circular(5),
                                  padding: const EdgeInsets.all(10),
                                  gradient: gradient1,
                                  child: Txt(
                                    text: 'Buat kode akses',
                                    color: Colors.white,
                                    weight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7.0,
                                ),
                                // Image.asset('assets/icon/icon_wallet.png', height: 60,),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.security,
                                      color: Colors.green,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Txt(
                                      text: 'Untuk keamanan anda',
                                      color: Colors.black,
                                      weight: medium,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ],
                            )
                      // Cntr(
                      //   height: 70,
                      //   width: 70,
                      //   image: const DecorationImage(
                      //       image: AssetImage('assets/icon/icon_wallet.png'),fit: BoxFit.cover),
                      // ),
                    ],
                  ),
                )
                // Container(
                //   margin: const EdgeInsets.only(top: 20, left: 20),
                //   width: Get.width,
                //   height: 148,
                //   alignment: Alignment.topLeft,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Cntr(
                //         onTap: () {
                //           Get.to(() => const BuatKodeAkses());
                //         },
                //         radius: BorderRadius.circular(5),
                //         padding: const EdgeInsets.all(10),
                //         gradient: gradient1,
                //         child: Txt(
                //           text: 'Buat kode akses',
                //           color: Colors.white,
                //           weight: bold,
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 7.0,
                //       ),
                //       // Image.asset('assets/icon/icon_wallet.png', height: 60,),
                //       Row(
                //         children: [
                //           const Icon(
                //             Icons.security,
                //             color: Colors.green,
                //             size: 12,
                //           ),
                //           const SizedBox(
                //             width: 5.0,
                //           ),
                //           Txt(
                //             text: 'Untuk keamanan anda',
                //             color: Colors.black,
                //             weight: medium,
                //             size: 10,
                //           ),
                //         ],
                //       ),
                //       // Cntr(
                //       //   height: 70,
                //       //   width: 70,
                //       //   image: const DecorationImage(
                //       //       image: AssetImage('assets/icon/icon_wallet.png'),fit: BoxFit.cover),
                //       // ),
                //     ],
                //   ),
                // )
              ]),
            ),

            //LIST BANK DOKTER
            loginCv2.codeAccess.value != "null" &&
                        loginC.role.value == "hospital" ||
                    loginCv2.codeAccess.value == ""
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (controllerDoctor.bankId.value == 0) {
                            showPopUp(
                                onTap: () {
                                  Get.back();
                                },
                                imageAction: 'assets/json/eror.json',
                                description:
                                    "Mohon Piilih Atau\nMasukkan Rekening Anda");
                          } else {
                            Get.to(() => PenarikanSaldo());
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 26),
                          width: Get.width,
                          height: 56,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(4, 8),
                                    color: Color.fromARGB(255, 225, 223, 223))
                              ],
                              borderRadius: BorderRadius.circular(4),
                              color: whiteColor),
                          child: ListTile(
                            leading:
                                Image.asset('assets/icon/icon_tariksaldo.png'),
                            title: Text(
                              'Tarik Saldo',
                              style: blackTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 16),
                            ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ),
                      ),
                      Obx(
                        () => controllerNurse.listDataBankNurse.isNotEmpty
                            ? SizedBox(
                                height: Get.height / 2.3,
                                child: ListView.builder(
                                    itemCount: loginC.role.value == 'nurse' ||
                                            loginC.role.value == "hospital"
                                        ? controllerNurse
                                            .listDataBankNurse.length
                                        : controllerDoctor
                                            .listDataBankDoctor.length,
                                    itemBuilder: (context, index) => Obx(
                                          () => Cntr(
                                            // ignore: unrelated_type_equality_checks
                                            border: Border.all(
                                                color:
                                                    controllerDoctor.selected ==
                                                            index
                                                        ? Colors.blue
                                                        : Colors.transparent),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 5),
                                            radius: BorderRadius.circular(10),
                                            height: 122,
                                            width: Get.width,
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/icon/card_bank.png'),
                                                fit: BoxFit.cover),
                                            child: ListTile(
                                              title: Txt(
                                                text: loginC.role.value ==
                                                            'nurse' ||
                                                        loginC.role.value ==
                                                            "hospital"
                                                    ? controllerNurse
                                                            .listDataBankNurse[
                                                        index]['name']
                                                    : controllerDoctor
                                                            .listDataBankDoctor[
                                                        index]['name'],
                                              ),
                                              subtitle: Txt(
                                                size: 12,
                                                color: Colors.grey,
                                                text: loginC.role.value ==
                                                            'nurse' ||
                                                        loginC.role.value ==
                                                            "hospital"
                                                    ? controllerNurse
                                                            .listDataBankNurse[
                                                        index]['no_rek']
                                                    : controllerDoctor
                                                            .listDataBankDoctor[
                                                        index]['no_rek'],
                                              ),
                                              onTap: () {
                                                controllerDoctor
                                                    .bankId.value = loginC
                                                                .role.value ==
                                                            'nurse' ||
                                                        loginC.role.value ==
                                                            "hospital"
                                                    ? controllerNurse
                                                            .listDataBankNurse[
                                                        index]['id']
                                                    : controllerDoctor
                                                            .listDataBankDoctor[
                                                        index]['id'];
                                                controllerDoctor
                                                    .selected.value = index;
                                              },
                                              // trailing: Container(
                                              //   height: 20,
                                              //   width: 20,
                                              //   decoration: BoxDecoration(
                                              //     image: DecorationImage(
                                              //         // ignore: unrelated_type_equality_checks
                                              //         image: controllerDoctor.selected ==
                                              //                 index
                                              //             ? const AssetImage(
                                              //                 'assets/icon/checkboxon.png')
                                              //             : const AssetImage(
                                              //                 'assets/icon/checkboxoff.png')),
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        )),
                              )
                            : controllerDoctor.listDataBankDoctor.isEmpty
                                ? const SizedBox(
                                    height: 1.0,
                                  )
                                : SizedBox(
                                    height: Get.height / 2.3,
                                    child: ListView.builder(
                                        itemCount: loginC.role.value == 'nurse'
                                            ? controllerNurse
                                                .listDataBankNurse.length
                                            : controllerDoctor
                                                .listDataBankDoctor.length,
                                        itemBuilder: (context, index) =>
                                            Obx(() => Cntr(
                                                  // ignore: unrelated_type_equality_checks
                                                  border: Border.all(
                                                      color: controllerDoctor
                                                                  .selected ==
                                                              index
                                                          ? Colors.blue
                                                          : Colors.transparent),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24,
                                                      vertical: 5),
                                                  radius:
                                                      BorderRadius.circular(10),
                                                  height: 122,
                                                  width: Get.width,
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/icon/card_bank.png'),
                                                      fit: BoxFit.cover),
                                                  child: ListTile(
                                                    isThreeLine: true,
                                                    title: Txt(
                                                      weight: bold,
                                                      text: loginC.role.value ==
                                                              'nurse'
                                                          ? controllerNurse
                                                                  .listDataBankNurse[
                                                              index]['name']
                                                          : controllerDoctor
                                                                  .listDataBankDoctor[
                                                              index]['name'],
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Txt(
                                                          size: 12,
                                                          text: loginC.role
                                                                      .value ==
                                                                  'nurse'
                                                              ? controllerNurse
                                                                          .listDataBankNurse[
                                                                      index]['bank']
                                                                  ['name']
                                                              : controllerDoctor
                                                                          .listDataBankDoctor[
                                                                      index][
                                                                  'bank']['name'],
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Txt(
                                                          size: 12,
                                                          color: Colors.grey,
                                                          text: loginC.role
                                                                      .value ==
                                                                  'nurse'
                                                              ? controllerNurse
                                                                          .listDataBankNurse[
                                                                      index]
                                                                  ['no_rek']
                                                              : controllerDoctor
                                                                      .listDataBankDoctor[
                                                                  index]['no_rek'],
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      controllerDoctor
                                                          .bankId.value = loginC
                                                                  .role.value ==
                                                              'nurse'
                                                          ? controllerNurse
                                                                  .listDataBankNurse[
                                                              index]['id']
                                                          : controllerDoctor
                                                                  .listDataBankDoctor[
                                                              index]['id'];
                                                      controllerDoctor.selected
                                                          .value = index;
                                                    },
                                                    // trailing: Container(
                                                    //   height: 20,
                                                    //   width: 20,
                                                    //   decoration: BoxDecoration(
                                                    //     image: DecorationImage(
                                                    //         // ignore: unrelated_type_equality_checks
                                                    //         image: controllerDoctor
                                                    //                     .selected ==
                                                    //                 index
                                                    //             ? const AssetImage(
                                                    //                 'assets/icon/checkboxon.png')
                                                    //             : const AssetImage(
                                                    //                 'assets/icon/checkboxoff.png')),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ))),
                                  ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 150.0,
                      ),
                      Image.asset('assets/icon/gembok.png'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Txt(
                        text: 'Akses terkunci',
                        size: 16,
                        weight: bold,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text:
                            'Untuk melakukan withdraw, diharuskan\nmembuat kode akses anda agar lebih aman',
                        size: 12,
                        weight: medium,
                        color: Colors.grey,
                      ),
                    ],
                  ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          Get.to(() => const TambahRekening());
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(24),
          // width: Get.width,
          padding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
          decoration: DottedDecoration(
              shape: Shape.box,
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffEDEDED)),
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
              const Text('Masukkan Rekening anda untuk penarikan'),
            ],
          ),
        ),
      ),
    );
  }
}
