import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme.dart';
import '../../../../widget/button/button_costum.dart';
import '../../../doctor_app/pesan/views/pesan_view.dart';
import '../../../doctor_app/profile/views/riwayat_transaksi.dart';
import '../controllers/pesan_hospital_controller.dart';

class PesanPenarikanSaldoHospital extends GetView<PesanHospitalController> {
  PesanPenarikanSaldoHospital(
      {Key? key, required this.data, required this.imageUrl})
      : super(key: key);
  var data;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: ListView.builder(
          itemCount: data.length,
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) => InkWell(
            onLongPress: () {
              Get.defaultDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Kembali')),
                    Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                         await controller.hapusPesanHospital(data[index]['id']);
                         await controller.fetchInboxHospital();
                         Get.back();
                         Get.back();
                        },
                        child: controller.isLoadingHapus.isTrue
                            ? const Text("Loading...")
                            : const Text('Hapus')))
                  ],
                  title: "Hapus Pesan",
                  middleText: "Apakah Anda yakin\nMenghapus Pesan ini?");
            },
            onTap: () {
              controller.bacaPesanHospital(data[index]['id']);
              if (data[index]['nominal'] == null) {
                popUpInboxTim(index, context);
              } else {
                popUpDetailPesan(context, index);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      imageUrl == "null"
                          ? Image.asset(
                              'assets/icon/saldo.png',
                              width: 40,
                            )
                          : Image.asset(
                              data[index]['title'] == "Terjadwalkan" ||
                                      data[index]['title'] ==
                                          "Pesanan pasien akan dimulai"
                                  ? 'assets/icon/icon_pesan2.png'
                                  : data[index]['title'] == "Berlangsung" ||
                                          data[index]['title'] ==
                                              "Layanan Berlangsung"
                                      ? 'assets/icon/icon_pesan4.png'
                                      : data[index]['title'] ==
                                                  "Mulai Sekarang" ||
                                              data[index]['title'] ==
                                                  "Waktu layanan dimulai"
                                          ? 'assets/icon/icon_pesan3.png'
                                          : data[index]['title'] ==
                                                  "Pesanan Masuk"
                                              ? 'assets/icon/icon_pesan1.png'
                                              : data[index]['title'] ==
                                                      "Pesanan Dibatalkan"
                                                  ? 'assets/icon/icon_pesan98.png'
                                                  : data[index]['title'] ==
                                                              "Selesai" ||
                                                          data[index]
                                                                  ['title'] ==
                                                              "Konfirmasi Selesai"
                                                      ? 'assets/icon/icon_pesan5.png'
                                                      : 'assets/icon/icon_pesan99.png',
                              width: 40,
                              height: 40,
                            ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['title'],
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          data[index]['nominal'] == null
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : AutoSizeText(
                                  maxLines: 2,
                                  CurrencyFormat.convertToIdr(
                                      data[index]['nominal'], 0),
                                  style: TextStyles.small1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Txt(
                            text: data[index]['description'],
                            size: 10,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Txt(
                            text: data[index]['date'],
                            size: 10,
                            color: Colors.grey,
                          ),
                        ],
                      )
                    ],
                  ),
                  data[index]['status'] == 2
                      ? const SizedBox(
                          height: 1.0,
                        )
                      : const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 12,
                        ),
                  const Icon(
                    Icons.more_vert_sharp,
                    size: 30,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  popUpDetailPesan(BuildContext context, int index) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Cntr(
            color: Colors.transparent,
            height: Get.height / 2.1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 18, top: 14),
                  width: Get.width / 1.9,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffEDEDED)),
                ),
                // status == 5 ? Image.network(imageNetwork ?? "https://picsum.photos/seed/picsum/200/300", width: 110,) :
                imageUrl == "null"
                    ? Image.asset(
                        'assets/icon/saldo.png',
                        width: 50,
                      )
                    : Image.network(
                        imageUrl,
                        width: 50,
                      ),
                // Image.asset(
                //   'assets/icon/saldo.png',
                //   width: 55,
                //   fit: BoxFit.cover,
                // ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data[index]['title'],
                  style:
                      blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  data[index]['date'],
                  // DateFormat('d MMMM y, kk:mm', "id_ID").format(
                  //     DateTime.parse(
                  //         Get.find<PesanController>().tanggalPesan.value)),
                  style: blackTextStyle.copyWith(
                      fontWeight: normal, color: const Color(0xff555555)),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // rating,
                const SizedBox(
                  height: 8,
                ),
                // rating!,
                // SizedBox(
                //   width: Get.width,
                //   child: AutoSizeText(
                //     subtitle,
                //     style: subtitleTextStyle,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Cntr(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  radius: BorderRadius.circular(10),
                  color: const Color(0xffEFEFEF),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Code Order',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Txt(text: data[index]['orderId'].toString())
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Cntr(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  radius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 220, 219, 219)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    children: [
                      Image.asset('assets/icon/saldo.png'),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: 'Penarikan Saldo :',
                            size: 12,
                            weight: light,
                          ),
                          Txt(
                            text: CurrencyFormat.convertToIdr(
                                data[index]['nominal'], 0),
                            size: 16,
                            weight: bold,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ButtomGradient(
                    margin: 24, label: 'Lihat Detail Transaksi', onTap: () {
                      Get.to(()=> RiwayatPenarikanSaldo());
                    })
              ],
            ),
          );
        });
  }

  popUpInboxTim(int index, BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return DetailPesan(
              dataPesan: data[index],
              orderId: data[index]["id"].toString(),
              rating: const SizedBox(),
              imageUrl: 'assets/icon/icon_pesan1.png',
              title: 'Pembayaran Berhasil',
              subtitle: 'Terima kasih Anda telah melakukan pembayaran ',
              time: DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(
                DateTime.parse(
                  data[index]['date'],
                ),
              ),
              button: ButtonCostum(
                title: "Kembali",
                onPressed: () async {
                  Get.back();
                },
                color: Colors.blue,
              ));
        });
  }
}
