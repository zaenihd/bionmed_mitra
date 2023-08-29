import 'dart:developer';

import 'package:bionmed/app/modules/doctor_app/account/widget/skpengguna_widget.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../../../constant/colors.dart';
import '../../../../widget/header/header_layanan.dart';
import '../../../../widget/other/loading_indicator.dart';
import '../../account/controllers/account_controller.dart';
import '../controllers/login_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login_screen";

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginView> {
  final myC = Get.put(LoginController());
  final accountC = Get.put(AccountController());
  bool isButtonActive = false;

  @override
  void initState() {
    initPlatformState();
    // controllerPhone.clear();
    myC.controllerPhone.addListener(() {
      final isButtonActive = myC.controllerPhone.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // myC.controllerPhone.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    final box = GetStorage();
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      box.write('deviceId', deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cLogin = Get.put(LoginController());

    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: backgroundColorC,
      // appBar: appbarBack(),
      body: Obx(
        (() => LoadingOverlay(
              isLoading: cLogin.isloading.value,
              progressIndicator: loadingIndicator(),
              color: Colors.transparent,
              opacity: 0.2,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(height: 80),
                    InkWell(
                      onTap: () {
                        // Get.to(()=>Ditolak());
                      },
                      child: HeaderWidget(
                        title: "Selamat Datang di BIONMED",
                        subtitle:
                            "Masukkan nomor telepon untuk mulai \nmenggunakan BIONMED",
                        imageUrl: "assets/icon/icon5.png",
                      ),
                    ),
                    const SizedBox(height: 32),
                    Txt(
                      text: 'Nomer Handphone',
                      weight: bold,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                            initialValue: PhoneNumber(
                              isoCode: "ID",
                            ),
                            countrySelectorScrollControlled: true,

                            // autoFocus: true,
                            // countrySelectorScrollControlled: false,
                            // countries: ['asas', 'sasa'],
                            locale: "IDN",
                            searchBoxDecoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 15, left: 15),
                              // border: InputBorder.none,
                              hintText: 'Cari kode telepon negara anda',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 102, 101, 101),
                                  fontSize: 18),
                            ),
                            onInputChanged: (PhoneNumber code) {
                              // ignore: avoid_print
                              print(
                                  "cek${code.phoneNumber.toString().replaceFirst('+', '')}");
                            },
                            onInputValidated: (bool value) {
                              // ignore: avoid_print
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              // leadingPadding: 20,
                              // useEmoji: true,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            textFieldController: myC.controllerPhone,
                            formatInput: false,
                            maxLength: 15,
                            validator: (phone) => phone == null
                                ? "Enter a valid Phone number"
                                : null,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            cursorColor: Colors.black,
                            inputDecoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 15, left: 0),
                              border: InputBorder.none,
                              hintText: '81234567891',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 102, 101, 101),
                                  fontSize: 18),
                            ),
                            onSaved: (PhoneNumber number) {
                              // ignore: avoid_print
                              print('On Saved: $number');
                            },
                          ),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: 40,
                              width: 1,
                              color: Colors.black.withOpacity(0.13),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      bottomSheet: Container(
        // padding: EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        width: Get.width,
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // skPengguna(),
            const SkPengguna(),
            const SizedBox(height: 24),
            Container(
                child: isButtonActive
                    ? ButtomGradient(
                        onTap: () async {
                          var idAccount = await GetStorage().read('idAccount');
                          log(idAccount.toString());

                          if (idAccount == 2) {
                            Get.find<LoginController>().loginNurse(
                                phoneNumber: myC.controllerPhone.text);
                          } else if (idAccount == 5) {
                            Get.find<LoginController>().loginHospital(
                                phoneNumber: myC.controllerPhone.text);
                          } else {
                            Get.find<LoginController>()
                                .loginV2(phoneNumber: myC.controllerPhone.text);
                            // Get.toNamed(Routes.HOME_HOSPITAL);
                          }
                        },
                        label: 'Lanjutkan',
                      )
                    : ButtonPrimary(
                        title: 'Lanjutkan',
                        onPressed: () {
                          // Get.toNamed(Routes.REGISTER);
                          // Get.toNamed(Routes.LAYANAN);
                        })),
          ],
        ),
      ),
    );
  }

  RichText skPengguna() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Dengan masuk atau mendaftar saya menyetujui \n',
        style: TextStyle(
            color: AppColor.bodyColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu'),
        children: [
          TextSpan(
            text: 'Ketentuan Pengguna ',
            style: TextStyle(
                color: AppColor.bluePrimary, fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: 'dan ',
          ),
          TextSpan(
            text: 'Kebijakan Privasi BIONMED',
            style: TextStyle(
              color: AppColor.bluePrimary,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
