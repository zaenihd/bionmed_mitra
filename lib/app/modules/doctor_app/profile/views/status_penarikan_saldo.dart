import 'package:bionmed/app/modules/doctor_app/detail/views/detail_view.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StatusPenarikanSaldo extends StatelessWidget {
  StatusPenarikanSaldo({
    super.key,
    required this.namaBank,
    required this.tarikSaldo,
    required this.tanggal,
    required this.norek,
    required this.penerina,
    required this.status,
    required this.bank

  });

  String tanggal, namaBank, penerina, norek, bank = "";
  int tarikSaldo, status = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Transaksi Anda'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(status == 0
                  ? 'assets/images/saldo1.png'
                  : status == 1
                      ? 'assets/images/berhasil.png'
                      : 'assets/images/statusImage999.png'),
              const SizedBox(
                height: 20.0,
              ),
              Txt(
                text: status == 0
                    ? 'Penarikan saldo diproses'
                    : status == 1
                        ? "Penarikan saldo berhasil"
                        : "Penarikan saldo gagal",
                weight: bold,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Txt(
                text: status == 0
                    ? 'Silahkan tunggu, kami akan\nmemberikan notifikasi'
                    : status == 1
                        ? "Silahkan cek rekening anda"
                        : "Saldo anda dikembalikan,\nsilahkan coba lagi nanti",
                weight: normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Visibility(
                  visible: status != 0,
                  child: Cntr(
                    radius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 229, 224, 224),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                              text: 'No. Invoice : ',
                              size: 12,
                              weight: normal,
                            ),
                            Txt(
                              text: 'INV/$norek/$bank',
                              size: 14,
                              weight: normal,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.upload,
                          color: Colors.blue[200],
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Cntr(
                radius: BorderRadius.circular(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: const Color.fromARGB(255, 229, 224, 224),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(text: 'Detail Transaksi'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Tarik Saldo',
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: CurrencyFormat.convertToIdr(tarikSaldo, 0),
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Tanggal',
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: tanggal,
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Waktu',
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: tanggal,
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Nama Bank',
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: namaBank,
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Penerima',
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: penerina,
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: "Nomer Rekening",
                          color: const Color(0xff7C7C7C),
                        ),
                        Txt(
                          text: norek,
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Cntr(
                      padding: const EdgeInsets.all(15),
                      color: const Color.fromARGB(61, 0, 221, 37),
                      radius: BorderRadius.circular(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(text: "Total"),
                          Txt(
                            text: CurrencyFormat.convertToIdr(tarikSaldo, 0),
                            color: const Color(0xff0B9444),
                            weight: bold,
                            size: 16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
