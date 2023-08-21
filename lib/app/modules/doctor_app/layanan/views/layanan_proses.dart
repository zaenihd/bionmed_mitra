import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/layanan_controller.dart';

class LayananProses extends GetView<LayananController> {
  const LayananProses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ProsesWidget(imageUrl: 'assets/sedang_proses.png', title: 'Sedang Proses Data', subtitle: 'Mohon tunggu beberapa saat, data anda sedang\ndi proses oleh kami demi ke amanan'),
    );
  }
}

// ignore: must_be_immutable
class ProsesWidget extends StatelessWidget {
   ProsesWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  String imageUrl;
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Image.asset(imageUrl),
        const SizedBox(
          height: 14,
        ),
        Text(
          title,
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 24),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          subtitle,
          style: blackTextStyle.copyWith(
              fontWeight: normal, color: subtitleColor),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}


