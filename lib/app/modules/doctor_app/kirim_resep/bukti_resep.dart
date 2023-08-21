import 'package:bionmed/app/modules/doctor_app/kirim_resep/controller_resep.dart';
import 'package:bionmed/app/modules/doctor_app/kirim_resep/kirim_berhasil.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../layanan_home/controllers/layanan_home_controller.dart';

class BuktiResep extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final file;
   BuktiResep({super.key, this.file, });
  final myC = Get.put(ControllerResep());

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Bukti Resep",
          style: blackTextStyle.copyWith(fontWeight: bold),
        ),
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 
              300,
              width: 300,
              child: Image.file(file)),
              const SizedBox(
              height: 20.0,
              ),
              Text(file.toString().substring(46), textAlign: TextAlign.center,)
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Obx(()=> ButtomGradient(
            label: myC.isLoading.isTrue ? "Loading...." :  " Kirim Resep",
            onTap: () async{
              if(myC.isLoading.isFalse){
              await Get.find<ControllerResep>().uploadResep(file);
              await Get.find<LayananHomeController>().updateStatusTimer(
                      statusPayment: Get.find<LayananHomeController>().statusPayment.value + 0,
                      statusOrder: Get.find<LayananHomeController>().statusOrderChat.value + 3);
              await Get.find<LayananHomeController>().getOrder();
              Get.to(const SuksesKirimResep());
              }
              else{
              }
              // pickerFilesImage(context);
            }),)
      ),
    );
  }
}
