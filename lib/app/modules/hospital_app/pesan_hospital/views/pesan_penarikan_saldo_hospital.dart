import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/constant/styles.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../theme.dart';
import '../controllers/pesan_hospital_controller.dart';

class PesanPenarikanSaldoHospital extends GetView<PesanHospitalController> {
  const PesanPenarikanSaldoHospital({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: ListView.builder(
          itemCount: 3,
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              popUpDetailPesan(context);
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
                      Image.asset(
                        'assets/icon/saldo.png',
                        width: 40,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Penarikan Saldo Diproses",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          AutoSizeText(
                              maxLines: 2,
                              "Rp 100.000",
                              style: TextStyles.small1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Txt(
                            text: "Klik disini untuk melihat detail penarikan ",
                            size: 10,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Txt(
                            text: "11.00 PM",
                            size: 10,
                            color: Colors.grey,
                          ),
                        ],
                      )
                    ],
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

  popUpDetailPesan(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Cntr(
            color: Colors.transparent,
            height: Get.height /2.1,
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
                Image.asset(
                  'assets/icon/saldo.png',
                  width: 55,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Penarikan Saldo Diproses",
                  style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "12 Desember 2023",
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
                      Txt(text: "23809123983HH")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Cntr(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(255, 220, 219, 219)),
                  padding: const EdgeInsets.symmetric(horizontal :24, vertical: 12),
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
                            text: 'Rp 100.000',
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
                  margin: 24,
                  label: 'Lihat Detail Transaksi', onTap: (){})
              ],
            ),
          );
        });
  }
}
