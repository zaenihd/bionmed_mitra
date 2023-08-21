import 'dart:io';

import 'package:bionmed/app/modules/doctor_app/kirim_resep/bukti_resep.dart';
import 'package:bionmed/app/modules/doctor_app/kirim_resep/controller_resep.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class KirimResep extends StatefulWidget {
  const KirimResep({super.key});

  @override
  State<KirimResep> createState() => _KirimResepState();
}

class _KirimResepState extends State<KirimResep> {
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;
  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    setState(() => files = File(image.path));
    if (files != null) {
      Get.to(BuktiResep(file: files));
    }
    return file;
  }

  void pickerFilesImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Photo"),
                onTap: ()async {
                  //    if (await Permission.storage.request().isGranted) {
                  // }
                  takePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  takePhoto(ImageSource.camera);
                  Get.back();
                },
              )
            ],
          );
        });
  }

  final myC = Get.put(ControllerResep());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pesanan Selesai',
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Image.asset('assets/images/kirim_resep.png'),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Silakan upload resep untuk\npasien, jika ada',
              style: blackTextStyle.copyWith(color: greyColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 150,
        width: Get.width,
        child: Column(
          children: [
            Obx(()=>
            ButtomGradient(
                label:Get.find<LayananHomeController>().isloadingResep.isFalse ? "Lewati, dan selesai" : "Loading...",
                onTap: () async {
                  if(Get.find<LayananHomeController>().isloadingResep.isFalse){
                  await Get.find<LayananHomeController>().updateStatusTimer(
                      statusPayment: Get.find<LayananHomeController>()
                              .statusPayment
                              .value +
                          0,
                      statusOrder: Get.find<LayananHomeController>()
                              .statusOrderChat
                              .value +
                          3);
                  // await Get.find<LayananHomeController>().getOrder();
                    Get.back();
                    Get.back();
                  }
                  // Get.to(BuktiResep());
                
                }),),
            const SizedBox(
              height: 20.0,
            ),
            ButtomGradient(
                label: "Upload",
                onTap: () {
                  // myC.file = files;
                  pickerFilesImage(context);
                }),
          ],
        ),
      ),
    );
  }
}
