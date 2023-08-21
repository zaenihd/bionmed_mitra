import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../widget/card/card_layanan.dart';
import '../controllers/pesanan_masuk_perawat_controller.dart';

class PesananMasukPerawatView extends GetView<PesananMasukPerawatController> {
  PesananMasukPerawatView({Key? key}) : super(key: key);

  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    homeC.reminderNurse.value = true;
    controller.startCountingAcceptOrder();
    return Scaffold(
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Txt(
                    text: 'Pesanan Masuk',
                    weight: bold,
                  ),
                  Image.asset('assets/icon/icon_pesanbig.png'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Txt(
                    text: 'Konfirmasi pesanan masuk',
                    size: 12,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Cntr(
                    alignment: Alignment.centerLeft,
                    height: 60,
                    width: Get.width,
                    border: Border.all(color: Colors.grey[400]!),
                    radius: BorderRadius.circular(10),
                    child: ListTile(
                      title: Txt(
                        text: homeC.dataReminderNurse['customer']['name'],
                        size: 16,
                        weight: bold,
                      ),
                      leading: Cntr(
                        height: 40,
                        width: 40,
                        radius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage(homeC
                                    .dataReminderNurse['customer']['image'] ??
                                'https://divedigital.id/wp-content/uploads/2021/10/1-min.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Cntr(
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.centerLeft,
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    width: Get.width,
                    border: Border.all(color: Colors.grey[400]!),
                    radius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/icon/maps.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Txt(text: 'Detail Rumah Pasien'),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Txt(text: homeC.dataReminderNurse['address']),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: () async {
                            await MapsLauncher.launchCoordinates(
                                homeC.dataReminderNurse['lat'],
                                homeC.dataReminderNurse['long'],
                                homeC.dataReminderNurse['address']);
                          },
                          child: Cntr(
                            radius: BorderRadius.circular(10),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            height: 30,
                            width: Get.width,
                            color: Colors.blue,
                            child: Txt(
                              text: 'Lihat Lokasi Maps',
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Cntr(
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    border: Border.all(color: Colors.grey[400]!),
                    radius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/icon/pasien1.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Txt(text: 'Detail Pasien'),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Cntr(
                                height: 200,
                                width: 200,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      homeC.dataReminderNurse['patient_image'],
                                  placeholder: (context, url) => Center(
                                      child: Transform.scale(
                                    scale: 0.5,
                                    child: const CircularProgressIndicator(),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              // Image.network(
                              //     homeC.dataReminderNurse['patient_image']),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Txt(text: 'Nama Pasien')),
                                  Txt(text: ':   '),
                                  SizedBox(
                                      width: 150,
                                      child: Txt(
                                        text: homeC.dataReminderNurse['name'],
                                        weight: bold,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Txt(text: 'Jenis Kelamin')),
                                  Txt(text: ':   '),
                                  SizedBox(
                                      width: 150,
                                      child: Txt(
                                        text: homeC.dataReminderNurse['gender'],
                                        weight: bold,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100, child: Txt(text: 'Umur')),
                                  Txt(text: ':   '),
                                  SizedBox(
                                      width: 150,
                                      child: Txt(
                                        text: homeC.dataReminderNurse['old']
                                            .toString(),
                                        weight: bold,
                                      )),
                                ],
                              ),
                              Cntr(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                radius: BorderRadius.circular(10),
                                height: 120,
                                width: Get.width,
                                color: Colors.grey[200],
                                child: Txt(
                                    text:
                                        homeC.dataReminderNurse['description']),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Cntr(
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    border: Border.all(color: Colors.grey[400]!),
                    radius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/icon/kebutuhan.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Txt(text: 'Kebutuhan Pasien'),
                        ],
                      ),
                      children: [
                        Cntr(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 230,
                            child: ListView.builder(
                              itemCount: homeC
                                  .dataReminderNurse['service_price_nurse']
                                      ['package_nurse_sops']
                                  .length,
                              itemBuilder: (context, index) => ListTile(
                                leading: Cntr(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(homeC.dataReminderNurse[
                                              'service_price_nurse']
                                          ['package_nurse_sops'][index]
                                      ['nurse_work_scope']['icon']),
                                ),
                                title: Text(homeC.dataReminderNurse[
                                            'service_price_nurse']
                                        ['package_nurse_sops'][index]
                                    ['nurse_work_scope']['name']),
                                // leading: Cntr(
                                //   height: 50,
                                //   width: 50,
                                //   image: const DecorationImage(
                                //       image:
                                //           AssetImage('assets/images/banner1.png'),
                                //       fit: BoxFit.cover),
                                // ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Cntr(
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          const BoxShadow(color: Colors.grey, spreadRadius: 5, blurRadius: 10)
        ],
        height: 160,
        width: Get.width,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 100, child: Txt(text: 'Total')),
                      Txt(text: ':   '),
                    ],
                  ),
                  Txt(
                      text: CurrencyFormat.convertToIdr(
                          homeC.dataReminderNurse['totalPrice'], 0),
                      weight: bold,
                      size: 20,
                      color: Colors.green),
                ],
              ),
            ),
            ButtomGradient(
                label: 'Terima',
                onTap: () async {
                  //statusRespone == 1 ? TERIMA ORDER
                  //statusRespone == 2 ? TOLAK  ORDER
                  await controller.acceptOrderNurse(statusRespone: 1);
                  homeC.reminderNurse.value = false;
                  Get.back();
                }),
            const SizedBox(
              height: 10.0,
            ),
            ButtonPrimary(
                title: 'Tolak Pesanan',
                onPressed: () {
                  Get.bottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        height: 270,
                        width: Get.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: Cntr(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 10,
                                  width: 200,
                                  color: Colors.grey[300],
                                  radius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Txt(
                                text:
                                    'Apakah Anda yakin ingin menolak\npesanan tersebut ?',
                                size: 16,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              ButtonPrimary(
                                backgroundColor: Colors.red,
                                marginLeft: 0,
                                marginRight: 0,
                                onPressed: () async {
                                  //statusRespone == 1 ? TERIMA ORDER
                                  //statusRespone == 2 ? TOLAK  ORDER
                                  await controller.acceptOrderNurse(
                                      statusRespone: 2);
                                  homeC.reminderNurse.value = false;

                                  Get.back();
                                  Get.back();
                                },
                                title: 'Tolak Pesanan',
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ButtonPrimary(
                                marginLeft: 0,
                                marginRight: 0,
                                onPressed: () {
                                  Get.back();
                                },
                                title: 'Batal',
                              ),
                            ],
                          ),
                        ),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
