import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/views/status_penarikan_saldo.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/card/card_layanan.dart';
import '../controllers/saldo_dan_rekening_doctor_controller.dart';
import '../controllers/saldo_dan_rekening_nurse_controller.dart';

class RiwayatPenarikanSaldo extends StatelessWidget {
  RiwayatPenarikanSaldo({super.key});

  final loginC = Get.put(LoginController());
  final controllerDoctor = Get.put(SaldoDanRekeningDoctorController());
  final controllerNurse = Get.put(SaldoDanRekeningNurseController());

  @override
  Widget build(BuildContext context) {
    if (loginC.role.value == 'nurse') {
      controllerNurse.listWithDrawnurse();
      log('qwerty ' + controllerNurse.listDataWithDrawNurse.length.toString());
    } else {
      controllerDoctor.listWithDrawDoctor();
      log("CEEK" + controllerDoctor.listDataWithDrawDoctor.toString());
    }
    return Scaffold(
        appBar: appbarGradient('Riwayat Transaksi'),
        body: Obx(() => controllerDoctor.loading.isTrue
            ? loadingIndicator()
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemCount: loginC.role.value != 'nurse'
                    ? controllerDoctor.listDataWithDrawDoctor.length
                    : controllerNurse.listDataWithDrawNurse.length,
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // log( "hahaha" + controllerDoctor
                        //           .listDataWithDrawDoctor[index]['doctor_bank']['date'].toString());
                        if (loginC.role.value == 'nurse') {
                          Get.to(() => StatusPenarikanSaldo(
                            bank:   controllerNurse.listDataWithDrawNurse[index]
                                        ['nurse_bank']['bank']['bank'],
                                tarikSaldo: controllerNurse
                                    .listDataWithDrawNurse[index]['amount'],
                                namaBank:
                                    controllerNurse.listDataWithDrawNurse[index]
                                        ['nurse_bank']['bank']['name'],
                                norek:
                                    controllerNurse.listDataWithDrawNurse[index]
                                        ['nurse_bank']['no_rek'],
                                penerina:
                                    controllerNurse.listDataWithDrawNurse[index]
                                        ['nurse_bank']['name'],
                                tanggal: controllerNurse
                                    .listDataWithDrawNurse[index]['date'],
                                status: controllerNurse
                                    .listDataWithDrawNurse[index]['status'],
                              ));
                        } else {
                          Get.to(() => StatusPenarikanSaldo(
                               bank:   controllerDoctor.listDataWithDrawDoctor[index]
                                        ['doctor_bank']['bank']['bank'],
                                tarikSaldo: controllerDoctor
                                    .listDataWithDrawDoctor[index]['amount'],
                                namaBank: controllerDoctor
                                        .listDataWithDrawDoctor[index]
                                    ['doctor_bank']['bank']['name'],
                                norek: controllerDoctor
                                        .listDataWithDrawDoctor[index]
                                    ['doctor_bank']['no_rek'],
                                penerina: controllerDoctor
                                        .listDataWithDrawDoctor[index]
                                    ['doctor_bank']['name'],
                                tanggal: controllerDoctor
                                    .listDataWithDrawDoctor[index]['date'],
                                status: controllerDoctor
                                    .listDataWithDrawDoctor[index]['status'],
                              ));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Penarikan Saldo',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: bold),
                                ),
                                Text(
                                  CurrencyFormat.convertToIdr(
                                      loginC.role.value != 'nurse'
                                          ? controllerDoctor
                                                  .listDataWithDrawDoctor[index]
                                              ['amount']
                                          : controllerNurse
                                                  .listDataWithDrawNurse[index]
                                              ['amount'],
                                      0),
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16, fontWeight: bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_sharp,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      loginC.role.value != 'nurse'
                                          ? controllerDoctor
                                              .listDataWithDrawDoctor[index]
                                                  ['date']
                                              .toString()
                                          : controllerNurse
                                              .listDataWithDrawNurse[index]
                                                  ['date']
                                              .toString(),
                                      style: subtitleTextStyle.copyWith(
                                          fontSize: 12, fontWeight: normal),
                                    ),
                                  ],
                                ),
                                loginC.role.value != 'nurse'
                                          ?
                                controllerDoctor.listDataWithDrawDoctor[index]
                                                ['status'] ==
                                            1 
                                    ? Text(
                                        'Berhasil',
                                        style: greenTextStyle.copyWith(
                                            color: Colors.green),
                                      )
                                    : controllerDoctor.listDataWithDrawDoctor[
                                                    index]['status'] ==
                                                0 
                                        ? Text(
                                            'Menuggu',
                                            style: greenTextStyle.copyWith(
                                                color: Colors.amber),
                                          )
                                        : Text(
                                            'Ditolak',
                                            style: greenTextStyle.copyWith(
                                                color: Colors.red),
                                          )

                                           : 
                                            controllerNurse.listDataWithDrawNurse[index]
                                                ['status'] ==
                                            1 
                                    ? Text(
                                        'Berhasil',
                                        style: greenTextStyle.copyWith(
                                            color: Colors.green),
                                      )
                                    : controllerNurse.listDataWithDrawNurse[
                                                    index]['status'] ==
                                                0 
                                        ? Text(
                                            'Menuggu',
                                            style: greenTextStyle.copyWith(
                                                color: Colors.amber),
                                          )
                                        : Text(
                                            'Ditolak',
                                            style: greenTextStyle.copyWith(
                                                color: Colors.red),
                                          )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                // ListTile(
                //   title: Text(
                //     'Penarikan Saldo',
                //     style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                //   ),
                //   subtitle: Row(
                //     children: [
                //       Icon(Icons.access_time_sharp, size: 16,),
                //       const SizedBox(
                //       width: 5.0,
                //       ),
                //       Text(
                //         '02 Feb 2022, 9:45',
                //         style:
                //             subtitleTextStyle.copyWith(fontSize: 12, fontWeight: normal),
                //       ),
                //     ],
                //   ),
                //   trailing: Column(children: [
                //      Text(
                //     '- Rp200.000',
                //     style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                //   ),

                //   ],),
                // ),
                )));
  }
}
