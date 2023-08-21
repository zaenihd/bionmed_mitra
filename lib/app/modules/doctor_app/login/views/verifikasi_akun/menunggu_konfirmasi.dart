import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenungguKonfirmasi extends StatelessWidget {
  const MenungguKonfirmasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/menunggu.png'),
          const SizedBox(
            height: 50.0,
          ),
          Txt(
            text: 'Menunggu konfirmasi',
            size: 24,
            weight: bold,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Txt(
            text:
                'Mohon tunggu konfirmasi, Selanjutnya kami akan mengirimkan notifikasi untuk anda',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
