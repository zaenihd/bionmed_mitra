import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class VerifikasiView extends StatelessWidget {
  VerifikasiView({super.key});
  final TextEditingController controllerOtp1 = TextEditingController();
  final TextEditingController controllerOtp2 = TextEditingController();
  final TextEditingController controllerOtp3 = TextEditingController();
  final TextEditingController controllerOtp4 = TextEditingController();
  final TextEditingController controllerOtp5 = TextEditingController();
  final loginC = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: appbarBack(),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Obx(() => ButtomGradient(
            label: loginC.isloadingOtp.isTrue ? "Loading.." : 'Verifikasi',
            onTap: () async {
              if (loginC.isloadingOtp.isFalse) {
                await loginC.verifyOtp();
              }

              // Get.toNamed(Routes.REGISTER);
            })),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 40),
          HeaderWidget(
              imageUrl: 'assets/icon/icon_veri.png',
              title: "Verifikasi Kode",
              subtitle:
                  "Kode Verifikasi dikirim melalui Whatsapp \nanda (+62) 89** _ **** _ **"),
          // Container(
          //   margin: const EdgeInsets.only(top: 36),
          //   child: Form(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           height: 55,
          //           width: 55,
          //           padding:
          //               const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             color: const Color(0xffF9F9F9),
          //           ),
          //           child: TextField(
          //             controller: controllerOtp1,
          //             style: Theme.of(context).textTheme.headline6,
          //             keyboardType: TextInputType.number,
          //             textAlign: TextAlign.center,
          //             inputFormatters: [
          //               LengthLimitingTextInputFormatter(1),
          //               FilteringTextInputFormatter.digitsOnly,
          //             ],
          //           ),
          //         ),
          //         Container(
          //           height: 55,
          //           width: 55,
          //           padding:
          //               const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          //           decoration: BoxDecoration(

          //             borderRadius: BorderRadius.circular(5),
          //             color: const Color(0xffF9F9F9),
          //           ),
          //           child: TextField(
          //             controller: controllerOtp2,
          //             style: Theme.of(context).textTheme.headline6,
          //             keyboardType: TextInputType.number,
          //             textAlign: TextAlign.center,
          //             inputFormatters:  [
          //               LengthLimitingTextInputFormatter(1),
          //               FilteringTextInputFormatter.digitsOnly,
          //             ],
          //           ),
          //         ),
          //         Container(
          //           height: 55,
          //           width: 55,
          //           padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             color: const Color(0xffF9F9F9),
          //           ),
          //           child: TextField(
          //             controller: controllerOtp3,
          //             style: Theme.of(context).textTheme.headline6,
          //             keyboardType: TextInputType.number,
          //             textAlign: TextAlign.center,
          //             inputFormatters:  [
          //               LengthLimitingTextInputFormatter(1),
          //               FilteringTextInputFormatter.digitsOnly,
          //             ],
          //           ),
          //         ),
          //         Container(
          //           height: 55,
          //           width: 55,
          //           padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             color: const Color(0xffF9F9F9),
          //           ),
          //           child: TextField(
          //             controller: controllerOtp4,
          //             style: Theme.of(context).textTheme.headline6,
          //             keyboardType: TextInputType.number,
          //             textAlign: TextAlign.center,
          //             inputFormatters: [
          //               LengthLimitingTextInputFormatter(1),
          //               FilteringTextInputFormatter.digitsOnly,
          //             ],
          //           ),
          //         ),
          //         Container(
          //           height: 55,
          //           width: 55,
          //           padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             color: const Color(0xffF9F9F9),
          //           ),
          //           child: TextField(
          //             controller: controllerOtp5,
          //             style: Theme.of(context).textTheme.headline6,
          //             keyboardType: TextInputType.number,
          //             textAlign: TextAlign.center,
          //             inputFormatters:  [
          //               LengthLimitingTextInputFormatter(1),
          //               FilteringTextInputFormatter.digitsOnly,
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 10.0,
          ),
          Pinput(
            length: 5,
            onChanged: (value) {
              print(loginC.controllerOtp.text);
            },
            controller: loginC.controllerOtp,
            defaultPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10))),

            // defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            // submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return null;

              // return s == '2222' ? null : 'Pin is incorrect';
              // return null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
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
                        loginC.sendOtp();
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          content: const Text('Kode OTP Berhasil dikirim'),
                          backgroundColor: (Colors.green),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                            .showSnackBar(snackBar);
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
