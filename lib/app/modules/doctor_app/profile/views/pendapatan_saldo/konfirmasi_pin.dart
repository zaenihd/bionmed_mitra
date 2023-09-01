import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class KonfirmasiPinSaldo extends StatelessWidget {
  const KonfirmasiPinSaldo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/icon/icon_konfirmasi.png'),
              const SizedBox(
                height: 10.0,
              ),
              Txt(
                text: 'Konfirmasi PIN',
                size: 26,
                weight: bold,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Txt(text: 'Masukkan 6 Digit kode pin anda'),
              const SizedBox(
                height: 40.0,
              ),
              Cntr(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                height: 60,
                width: Get.width,
                border: Border.all(color: Color(0xffC1C1C1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      text: '1234',
                      size: 26,
                      weight: bold,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0,
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: 12,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Cntr(
                      alignment: Alignment.center,
                      height: 90,
                      width: 90,
                      radius: BorderRadius.circular(100),
                      color: Colors.grey[300],
                      child: index == 11
                          ? Icon(Icons.backspace_rounded)
                          : index == 9
                              ? const SizedBox(
                                  height: 1.0,
                                )
                              : index == 10
                                  ? Txt(
                                      text: '0',
                                      size: 26,
                                      weight: bold,
                                    )
                                  : Txt(
                                      text: '${index + 1}',
                                      size: 26,
                                      weight: bold,
                                    ));
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ButtomGradient(label: 'Konfirmasi PIN', onTap: () {}),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
