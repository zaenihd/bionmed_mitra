import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_doctor_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_nurse_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/other/show_dialog.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme.dart';
import '../../../../widget/button/button_primary_withtext.dart';
import '../../../../widget/textform/input_primary1.dart';

// ignore: must_be_immutable
class PenarikanSaldo extends StatelessWidget {
  PenarikanSaldo({super.key});

  final controllerDoctor = Get.put(SaldoDanRekeningDoctorController());
  final controllerNurse = Get.put(SaldoDanRekeningNurseController());
  final loginC = Get.put(LoginController());
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Penarikan Saldo'),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ButtomGradient(
            label: 'Tarik Sekarang',
            onTap: () {
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
                          Text(
                            'Apakah anda yakin untuk melakukan\npenarikan saldo anda ?',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 46,
                          ),
                          ButtomGradient(
                              label: 'Konfirmasi',
                              onTap: () async {
                                if (Get.find<HomeController>()
                                        .pendapatan
                                        .value <
                                    controllerDoctor.saldoTarikCurren.value) {
                                  showPopUp(
                                      onTap: () {
                                        Get.back();
                                      },
                                      imageAction: 'assets/json/eror.json',
                                      description: "Saldo Anda\nTidak Cukup");
                                } else {
                                  if (loginC.role.value == "nurse") {
                                    await controllerNurse.sendWithDrawNurse(
                                        date: formatter
                                            .format(now.toLocal())
                                            .toString(),
                                        nurseBankId: 1,
                                        amount: controllerDoctor
                                            .saldoTarikCurren.value);
                                  } else {
                                    await controllerDoctor.sendWithDrawDoctor(
                                        date: formatter
                                            .format(now.toLocal())
                                            .toString(),
                                        doctorBankId: 1,
                                        amount: controllerDoctor
                                            .saldoTarikCurren.value);
                                    print(formatter.format(now.toLocal()));
                                    controllerDoctor.nominalSaldoTarikController
                                        .clear();
                                    final snackBar = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 1),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 24),
                                      content: const Text(
                                          'Berhasil Mengirim Permintaan Penarikan Saldo'),
                                      backgroundColor: (Colors.green),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Get.back();
                                    Get.back();
                                  }
                                }
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                          ButtonPrimary(title: "Batal", onPressed: () {})
                        ],
                      ),
                    );
                  });
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Nominal Saldo',
              style: blackTextStyle,
            ),
            InputPrimary(
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'id',
                  decimalDigits: 0,
                  symbol: '',
                ),
              ],
              keyboardType: TextInputType.number,
              hintText: "contoh : Rp 100.000",
              onChange: (p0) {
                controllerDoctor.saldoTarikCurren.value = int.parse(
                    controllerDoctor.nominalSaldoTarikController.text
                        .replaceAll(".", ""));
              },
              controller: controllerDoctor.nominalSaldoTarikController,
              onTap: () {},
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Note :',
              style: blackTextStyle,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 9,
                ),
                const Text('Penarikan maximal '),
                Text(
                  'Rp. 100.000',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
                const Text('/Hari'),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Penarikan maximal menunggu konfirmasi'),
                    Text(
                      '1x 24 jam',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
