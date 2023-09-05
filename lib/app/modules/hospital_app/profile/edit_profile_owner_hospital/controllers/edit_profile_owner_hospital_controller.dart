import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileOwnerHospitalController extends GetxController {
  TextEditingController namaOwnerC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController alamatOwnerC = TextEditingController();
  var files;
  RxString selectedStatus = ''.obs;
  RxString selectedGender = ''.obs;
  RxString dokumenKtp = ''.obs;
  RxString imageUrlStr = ''.obs;
  RxBool isLoading = false.obs;





   var fileDokumenKtp;
  pickerDokumenKtp() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    ///File file = File(platformFile.path);
    fileDokumenKtp = result.files.first;
    fileDokumenKtp = File(fileDokumenKtp.path);
    log(fileDokumenKtp.runtimeType.toString());
    // openFile(fileDokumenKtp);
    dokumenKtp.value = fileDokumenKtp.path.toString();
  }
}
