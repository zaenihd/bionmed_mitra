import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePaketLayananVcallController extends GetxController {
  TextEditingController minute = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController diskon = TextEditingController();
  RxList listPaket = [].obs;

  RxDouble totalHarga = 0.0.obs;
  RxBool buatDiskon = false.obs;
  RxBool buatPaket = false.obs;
}
