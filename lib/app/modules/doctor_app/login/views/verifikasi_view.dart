import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifikasiView extends StatelessWidget {
   VerifikasiView({super.key});
  final TextEditingController controllerOtp1 = TextEditingController();
  final TextEditingController controllerOtp2 = TextEditingController();
  final TextEditingController controllerOtp3 = TextEditingController();
  final TextEditingController controllerOtp4 = TextEditingController();
  final TextEditingController controllerOtp5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: appbarBack(),
      bottomSheet: ButtonPrimary(title: 'Verifikasi', onPressed: (){
                        Get.toNamed(Routes.REGISTER);
      }),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 40),
          HeaderWidget(imageUrl: 'assets/icon/icon_veri.png', title: "Verifikasi Kode", subtitle: "Kode Verifikasi dikirim melalui Whatsapp \nanda (+62) 89** _ **** _ **"),
          Container(
            margin: const EdgeInsets.only(top: 36),
            child: Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp1,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp2,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters:  [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp3,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters:  [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp4,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffF9F9F9),
                    ),
                    child: TextField(
                      controller: controllerOtp5,
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters:  [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.message_outlined,
                  // color: AppColor.bodyColor[600],
                ),
                const SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Belum dapat sms kode verifikasinya ?",
                      style: TextStyle(color: subtitleColor),
                    ),
                    const SizedBox(height: 3),
                    GestureDetector(
                      onTap: () {
                      },
                      child: const Text(
                        "Kirim Lagi",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}