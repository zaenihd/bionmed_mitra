import 'dart:developer';
import 'dart:io';

import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileHospitalController extends GetxController {
  TextEditingController namaHopitalC = TextEditingController();
  TextEditingController emailHopitalC = TextEditingController();
  TextEditingController alamatHospitalC = TextEditingController();
  TextEditingController detailAlamatHospitalC = TextEditingController();
  TextEditingController deskripsiHospitalC = TextEditingController();
  TextEditingController nomerHospitalC = TextEditingController();
  TextEditingController tahunBerdiriHospitalC = TextEditingController();
  RxString imageUrlHospital = ''.obs;
  RxString selectedStatus = ''.obs;
  RxString selectedGender = ''.obs;
  RxString dokumenPendukung = ''.obs;
  RxString dokumenSuratIjinOperasional = ''.obs;
  RxString dokumenKtp = ''.obs;
  RxBool isLoading = false.obs;


  var fileDokumenIjinOperasional;
  pickerDokumenSuratIjinOperasinal() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    fileDokumenIjinOperasional = result.files.first;
    fileDokumenIjinOperasional = File(fileDokumenIjinOperasional.path);

    // openFile(fileDokumenIjinOperasional);
    dokumenSuratIjinOperasional.value =
        fileDokumenIjinOperasional.path.toString();
  }

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

  var fileDokumenPendukung;
  pickerDokumenPendukung() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    ///Open Single file
    fileDokumenPendukung = result.files.first;
    fileDokumenPendukung = File(fileDokumenPendukung.path);


    // openFile(fileDokumenPendukung);
    dokumenPendukung.value = fileDokumenPendukung.path.toString();
  }

}
