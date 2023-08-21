import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan/controllers/layanan_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/header/header_layanan.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../../../../../theme.dart';

// ignore: must_be_immutable
class EditLayanan extends StatefulWidget {
  const EditLayanan({Key? key}) : super(key: key);

  @override
  State<EditLayanan> createState() => _EditLayananState();
}

class _EditLayananState extends State<EditLayanan> {
  List selectedServices = [];
  @override
  void initState() {
    checkLayanan(false);
    // dataService = loginC.service;
    super.initState();
  }

  List dataService = [];
  List dataServiceValue = [];

  bool? selected;
  bool? load;

  final myC = Get.put(LayananController());

  final profileC = Get.put(ProfileController());

  final loginC = Get.put(JadwalSayaController());

  checkLayanan(bool update) async {
    setState(() {
      load = true;
    });
    var data = await myC.checkLayanan();
    if (data != null) {
      setState(() {
        load = false;
        dataService = data;
        dataService = dataService.where((element) => element['id'] != 9).toList();
        if (update == false) {
          dataServiceValue = data;
        }
      });
      // ignore: avoid_print
      print('uhay + = $dataService');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorC,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Pilih Layanan"),
          titleTextStyle: const TextStyle(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                  imageUrl: 'assets/icon/icon_layanan.png',
                  title: 'Layanan Anda',
                  subtitle:
                      'Pilih spesialis bidang keahlian mu untuk melayani pasien'),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pilih Layanan",
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                  ),
                  Obx(() => myC.layananTerpilih.value != 0
                      ? Text(
                          "Terpilih (${myC.layananTerpilih.value})",
                          style: blackTextStyle.copyWith(
                              fontWeight: bold, fontSize: 16),
                        )
                      : const SizedBox()),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: load == false
                    ? ListView.builder(
                        padding: const EdgeInsets.only(bottom: 30),
                        itemCount: 2,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          child: ListTile(
                            title: Text(
                              '${dataService[index]['name']}',
                              // '',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            leading: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: textFieldC,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Obx(() => LoadingOverlay(
                                    isLoading: myC.isloading.value,
                                    progressIndicator: loadingIndicator(),
                                    color: Colors.transparent,
                                    opacity: 0.2,
                                    child: Image.network(
                                        '${dataService[index]['image']}'),
                                  )),
                            ),
                            trailing: dataService[index]['active'] == true
                                ? InkWell(
                                    onTap: () async {
                                      setState(() {
                                        dataServiceValue.removeWhere(
                                            (element) =>
                                                element['id'] ==
                                                dataService[index]['id']);
                                      });
                                      List idService = [];
                                      for (var i in dataServiceValue) {
                                        if (i['active'] == true) {
                                          idService.add(i['id']);
                                        }
                                      }

                                      var update = await profileC.editService(
                                          serviceId: idService);
                                      if (update != null) {
                                        checkLayanan(true);
                                      }
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon/checkboxon.png')),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      setState(() {
                                        dataServiceValue
                                            .add(dataService[index]);
                                      });

                                      List idService = [];
                                      idService.add(dataService[index]['id']);

                                      for (var i in dataServiceValue) {
                                        if (i['active'] == true) {
                                          idService.add(i['id']);
                                        }
                                      }
                                      var update = await profileC.editService(
                                          serviceId: idService);
                                      if (update != null) {
                                        checkLayanan(false);
                                      }
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon/checkboxoff.png')),
                                      ),
                                    )),
                          ),
                        ),
                      )
                    : loadingIndicator(),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: ButtomGradient(
            label: "Simpan",
            onTap: () async {
              await Get.find<JadwalSayaController>()
                  .loginData(phoneNumber: GetStorage().read('phone'));
              // myC.addService(
              //     serviceId: myC.tampunganLayanan);
              // Get.toNamed(Routes.PILIH_SPESIALIS);
              // Get.to(()=>EditSpesialis());
              Get.back();
            },
          ),
        ));
  }
}

// List<Map<String, dynamic>> layanan = [
//   {
//     "imageUrl": "assets/icon/doctor.png",
//     "title": "Dokter on Call By Specialist",
//     "value": false
//   },
//   {
//     "imageUrl": "assets/icon/doctor.png",
//     "title": "Dokter on Call By Specialist",
//     "value": false
//   },
//   {
//     "imageUrl": "assets/icon/doctor.png",
//     "title": "Dokter on Call By Specialist",
//     "value": false
//   },
// ];
