import 'dart:developer';

import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/controllers/lengkapi_data_hospital_controller.dart';
import 'package:bionmed/app/modules/hospital_app/lengkapi_data_hospital/views/lengkapi_data_hospital_view.dart';
import 'package:bionmed/app/modules/hospital_app/paket_layanan_hospital/views/detail_pendapatan_hospital.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/colors.dart';
import '../../../../widget/card/card_layanan.dart';
import '../../../../widget/other/show_dialog.dart';
import '../controllers/paket_layanan_hospital_controller.dart';

class PaketLayananHospitalDetail
    extends GetView<PaketLayananHospitalController> {
  PaketLayananHospitalDetail({Key? key}) : super(key: key);
  final lengkapiDataHospitalC = Get.find<LengkapiDataHospitalController>();

  final myC = Get.find<LengkapiDataHospitalController>();
  sendEmail() async {
    final Email email = Email(
      body: 'Deskripsi',
      subject: 'Selamat Pagi',
      recipients: ['care@bionmed.id'],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  final Uri whatsapp = Uri.parse('https://wa.me/6282147738240');
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.isTrue &&
            lengkapiDataHospitalC.listTimServiceHospital.isNotEmpty
        ? Scaffold(body: loadingIndicator())
        : Scaffold(
            bottomSheet: lengkapiDataHospitalC.listTimServiceHospital.isEmpty
                ? Cntr(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ButtomGradient(
                        label: 'Daftar',
                        onTap: () {
                          lengkapiDataHospitalC.serviceId.value =
                              lengkapiDataHospitalC.listServiceHospital[
                                      lengkapiDataHospitalC.index.value]
                                  ['service']['id'];
                          // lengkapiDataHospitalC.serviceHospital();
                          Get.to(() => TambahTimLayanan(
                                dataTim: lengkapiDataHospitalC
                                        .listServiceHospital[
                                    lengkapiDataHospitalC.index.value]['team'],
                              ));
                              log(lengkapiDataHospitalC.serviceId.value.toString());

                          // Get.toNamed(Routes.LENGKAPI_DATA_HOSPITAL);
                        }),
                  )
                : Cntr(
                    height: 130,
                    child: Column(
                      children: [
                        ButtonPrimary(
                            title: 'Helpdesk',
                            onPressed: () {
                              helpDesk(context);
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ButtomGradient(
                            label: 'Kelola layanan',
                            onTap: () {
                              showPopUp(
                                  onTap: () {},
                                  imageAction: 'assets/json/eror.json',
                                  description:
                                      "Sedang dalam proses\npengembangan");
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
            appBar: appbarBack(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lengkapiDataHospitalC.listTimServiceHospital.isEmpty
                      ? belumTerdaftar()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cntr(
                            //   radius: BorderRadius.circular(10),
                            //   border: Border.all(color: const Color(0xffE9E9E9)),
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 13),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Txt(
                            //             text: 'Aktivasi layanan',
                            //             size: 12,
                            //             weight: bold,
                            //           ),
                            //           const SizedBox(
                            //             height: 5.0,
                            //           ),
                            //           Txt(
                            //             text:
                            //                 'Jika menonaktifkan layanan, anda tidak\ndapat menerima pesanan layanan ini',
                            //             size: 10,
                            //             weight: light,
                            //           )
                            //         ],
                            //       ),
                            //       Cntr(
                            //         onTap: () {
                            //           controller.isActive.value =
                            //               !controller.isActive.value;
                            //         },
                            //         child: Obx(() => controller.isActive.isTrue
                            //             ? Image.asset('assets/icon/jadwal_off.png')
                            //             : Image.asset('assets/icon/jadwal_on.png')),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Txt(
                              text: 'Laporan pendapatan layanan',
                              weight: bold,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Cntr(
                              gradient: gradient1,
                              radius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xffE9E9E9)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon/nurse.png',
                                        width: 25,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Txt(
                                            text: 'Total pendapatan',
                                            size: 10,
                                            weight: light,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Txt(
                                            text: CurrencyFormat.convertToIdr(
                                                controller.incomeTotal.value,
                                                0),
                                            size: 12,
                                            weight: bold,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Cntr(
                                    onTap: () {
                                      controller.dateIncome.value = 4;
                                      controller.detailIncome();
                                      Get.to(() => DetailPendapatanHospital());
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    color: Colors.amber,
                                    radius: BorderRadius.circular(5),
                                    child: Txt(
                                      text: 'Lihat rincian',
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 26.0,
                            ),
                            // for (var i = 0; i < 3; i++)
                            CardIncomeHospital(
                              imageUrl: 'assets/icon/pendapatan.png',
                              onTap: () {
                                controller.dateIncome.value = 1;
                                controller.detailIncome();
                                Get.to(() => DetailPendapatanHospital());
                              },
                              title: "Harian",
                              income: controller.incomeDay.value,
                            ),
                            CardIncomeHospital(
                              imageUrl: 'assets/icon/pendapatan1.png',
                              onTap: () {
                                controller.dateIncome.value = 2;
                                controller.detailIncome();

                                Get.to(() => DetailPendapatanHospital());
                              },
                              title: "Bulanan",
                              income: controller.incomeMonth.value,
                            ),
                            CardIncomeHospital(
                              imageUrl: 'assets/icon/pendapatan2.png',
                              onTap: () {
                                controller.dateIncome.value = 3;
                                controller.detailIncome();

                                Get.to(() => DetailPendapatanHospital());
                              },
                              title: "Tahunan",
                              income: controller.incomeYear.value,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ));
  }

  helpDesk(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 150,
                height: 5,
                decoration: BoxDecoration(
                    color: AppColor.bodyColor.shade200,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Hubungi Helpdesk'),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  launchUrl(whatsapp);
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Color(0xff9CEEA5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icon/icon_wa.png'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        '+62 8821-8721-8723',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00810F)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  sendEmail();
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Color(0xffFFB3AD),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icon/icon_gmail.png'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        'care@bionmed.id',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffC80000)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  // FlutterPhoneDirectCaller.callNumber("+6289657081093");
                  // ignore: deprecated_member_use
                  launch("tel:(021) 82407779");
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Color(0xffB1D4F7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icon/icon_call.png'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        '(021) 82407779',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff001A61)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          );
        });
  }

  Center belumTerdaftar() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Column(
          children: [
            Image.asset('assets/icon/belum.png'),
            const SizedBox(
              height: 20.0,
            ),
            Txt(
              text: 'Belum terdaftar',
              size: 20,
              weight: bold,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Txt(
              text: 'Anda sudah belum terdaftar pada layanan ini',
              size: 10,
              weight: light,
            ),
          ],
        ),
      ),
    );
  }
}

class CardIncomeHospital extends StatelessWidget {
  CardIncomeHospital(
      {Key? key,
      required this.title,
      required this.income,
      required this.imageUrl,
      required this.onTap})
      : super(key: key);

  String title;
  String imageUrl;
  int income;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Cntr(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 10),
      radius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xffE9E9E9)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageUrl),
              const SizedBox(
                width: 6.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Pendapatan $title',
                    size: 10,
                    weight: light,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Txt(
                    text: CurrencyFormat.convertToIdr(income, 0),
                    size: 12,
                    weight: bold,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ],
          ),
          Cntr(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.amber,
            radius: BorderRadius.circular(5),
            child: Txt(
              text: 'Lihat rincian',
              size: 10,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
