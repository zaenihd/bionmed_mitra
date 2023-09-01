import 'package:bionmed/app/modules/doctor_app/profile/views/pendapatan_saldo/buat_pin.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class InputVerifikasiKode extends StatelessWidget {
  const InputVerifikasiKode({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ButtomGradient(label: 'Verifikasi', onTap: (){
          Get.to(()=> BuatPinSaldo());
        }),
      ),
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icon/icon_otp.png'),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      text: 'Verifikasi Kode',
                      weight: bold,
                    ),
                    Txt(
                      text:
                          'Kode Verifikasi dikirim melalui SMS anda\n(+62) 8*** _ **** _ **',
                      color: Colors.grey,
                      size: 11,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            inputOtp(context),
            const SizedBox(
              height: 26.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      text: 'Belum dapat kode verifikasinya ? ',
                      color: Colors.grey,
                      size: 11,
                    ),
                    Txt(
                      text: 'Kirim',
                      weight: bold,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Row inputOtp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: Theme.of(context).textTheme.headline6,
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: Theme.of(context).textTheme.headline6,
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: Theme.of(context).textTheme.headline6,
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: Theme.of(context).textTheme.headline6,
            onChanged: (value) {
              // if (value.length == 1) {
              //   FocusScope.of(context).nextFocus();
              // }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
      ],
    );
  }
}
