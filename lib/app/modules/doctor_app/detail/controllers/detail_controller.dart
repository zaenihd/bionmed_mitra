import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../constant/string.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  bool stop = false;

  RxBool selected = false.obs;
  RxString imageRecipe = "".obs;

  selec() {
    selected.value == true;
  }

  RxString paymentName = "".obs;
  RxString bankName = "".obs;
  var files;
  final ImagePicker _picker = ImagePicker();
  RxString imageUrl = "".obs;

  RxString tanggalRiset = ''.obs;
  RxString tanggalJadwalAmbilTes = ''.obs;
  RxString jamTerpilih = "".obs;
  RxString jamTerpilihForSend = "".obs;
  DateTime? startTime;
  final lokasiPengambilan = ['Rumah', "Hospital"];
  RxString pilihLokasi = "".obs;
  TextEditingController platNomerAmbulanceC = TextEditingController();





  Widget buildTimePickerMulai() {
    return SizedBox(
      height: Get.height / 3,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newdate) {
          String dates = DateFormat("HH:mm", "en_US").format(newdate);
          String datesToSendApi =
              DateFormat("HH:mm:ss", "en_US").format(newdate);
          // jamSekarangPlus3Jam.value = DateTime.now().toString();
          startTime = newdate;
          jamTerpilih.value = dates;
          jamTerpilihForSend.value = datesToSendApi;
          // jamSekarangPlus4JamFix.value = int.parse(jamSekarangPlus3Jam.value.substring(10, 13));
          // log(jamSekarangPlus4JamFix.value.toString());
        },
        use24hFormat: true,
        mode: CupertinoDatePickerMode.time,
      ),
    );
  }


  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      // ignore: avoid_print
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // ignore: avoid_print
      print(formattedDate);
      tanggalRiset.value = formattedDate;
      log(tanggalRiset.value);
    }
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
                onTap: () async {
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

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    files = File(image.path);
    imageUrl.value = files.toString();
    return file;
  }

  Future<bool> updaloadAmbulance(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}ambulance/order/upload/ambulance/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    request.fields['plat_no'] = platNomerAmbulanceC.text;
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('done Bro gagal');
      return false;
    }
  }

  Future<bool> updaloadbuktiPenjemputan(File imageFile, String id) async {
    // ignore: unused_local_variable
    // String idDocter = Get.find<LoginController>().doctorIdImage.value;
    final String url = "${MainUrl.urlApi}ambulance/order/upload/proof/$id";
    // ignore: avoid_print
    print("cek url : $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      // setCurrentUser(respStr);
      // currentUser = authModelFromJson(respStr);
      return true;
    } else {
      // ignore: avoid_print
      print(respStr);
      // ignore: avoid_print
      print('done Bro gagal');
      return false;
    }
  }
}
