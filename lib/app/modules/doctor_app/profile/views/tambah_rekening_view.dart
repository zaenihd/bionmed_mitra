import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_doctor_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/saldo_dan_rekening_nurse_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/button/button_primary_withtext.dart';

class TambahRekening extends StatefulWidget {
  const TambahRekening({super.key});

  @override
  State<TambahRekening> createState() => _TambahRekeningState();
}

class _TambahRekeningState extends State<TambahRekening> {
  final controllerDoctor = Get.put(SaldoDanRekeningDoctorController());
  final controllerNurse = Get.put(SaldoDanRekeningNurseController());
  final loginC = Get.put(LoginController());
  int? selected;
  String? selectedName;

  @override
  Widget build(BuildContext context) {
    controllerDoctor.listDataBank();
    return Scaffold(
      appBar: appbarGradient('Tambah Rekening'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Nama',
              style: blackTextStyle,
            ),
            InputPrimary(
              hintText: "Masukkan nama lengkap",
              onChange: (p0) {
                controllerDoctor.name.value =
                    controllerDoctor.namaController.text;
              },
              controller: controllerDoctor.namaController,
              onTap: () {},
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Masukkan No.Rekening',
              style: blackTextStyle,
            ),
            InputPrimary(
              hintText: "Contoh : 9218362181",
              onChange: (p0) {
                controllerDoctor.noRekening.value =
                    controllerDoctor.nomerRekeningController.text;
                ;
              },
              controller: controllerDoctor.nomerRekeningController,
              onTap: () {},
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Pilih bank',
              style: blackTextStyle,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: buttonColor!),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controllerDoctor.selectedBank.isEmpty
                              ? const Text('Pilih')
                              : Row(
                                  children: [
                                    // Image.asset(
                                    //     "${myC.choiceBank[0]['image']}"),
                                    Text(controllerDoctor.selectedBank.value)
                                  ],
                                ),
                        ],
                      )),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return SizedBox(
                                  height: 550,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 18, top: 14),
                                        width: Get.width / 1.9,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffEDEDED)),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Virtual Account',
                                        style: blackTextStyle.copyWith(
                                            fontWeight: bold),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        height: 350,
                                        child: ListView.builder(
                                            itemCount: controllerDoctor
                                                .listBank.length,
                                            itemBuilder: (context, index) =>
                                                ListTile(
                                                  // leading: SizedBox(
                                                  //     width: 82,
                                                  //     child: Image.network(
                                                  //         controllerDoctor
                                                  //                 .listBank[
                                                  //             index]['image'])),
                                                  title: Text(controllerDoctor
                                                      .listBank[index]['name']),
                                                  subtitle: Text(
                                                      controllerDoctor
                                                              .listBank[index]
                                                          ['bank']),
                                                  onTap: () {
                                                    controllerDoctor.selectedBank.value =  controllerDoctor
                                                                .listBank[index]
                                                            ['name'];
                                                    selected ==
                                                        controllerDoctor
                                                                .listBank[index]
                                                            ['name'];
                                                    controllerDoctor
                                                            .bankIdFromList
                                                            .value =
                                                        controllerDoctor
                                                                .listBank[index]
                                                            ['id'];
                                                    setState(() {
                                                      selected = index;
                                                    });
                                                  },
                                                  trailing: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: selected ==
                                                                  index
                                                              ? const AssetImage(
                                                                  'assets/icon/checkboxon.png')
                                                              : const AssetImage(
                                                                  'assets/icon/checkboxoff.png')),
                                                    ),
                                                  ),
                                                )),
                                      ),
                                      const SizedBox(
                                        height: 46,
                                      ),
                                      selected != null
                                          ? ButtomGradient(
                                              label: "Simpan",
                                              onTap: () {
                                                // for(var i =0; i < pilihanBank.length; i ++){
                                                //   myC.choiceBank.add(pilihanBank[i]['image']);
                                                // }
                                                Get.back();
                                              },
                                            )
                                          : ButtonPrimary(
                                              title: "Simpan",
                                              onPressed: () {}),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Obx(
          () => controllerDoctor.name.isEmpty ||
                  controllerDoctor.noRekening.isEmpty || controllerDoctor.selectedBank.isEmpty
              ? ButtonPrimary(title: 'Simpan', onPressed: () {})
              : ButtomGradient(
                  label: 'Simpan',
                  onTap: () async {
                    controllerDoctor.selectedBank.value = "";
                    if (loginC.role.value == "nurse") {
                      await controllerNurse.addBanknurse(
                          noRek: controllerDoctor.nomerRekeningController.text,
                          name: controllerDoctor.namaController.text,
                          bankId: controllerDoctor.bankIdFromList.value);
                      await controllerNurse.listBanknurse();
                    } else {
                      await controllerDoctor.addBankDoctor(
                          noRek: controllerDoctor.nomerRekeningController.text,
                          name: controllerDoctor.namaController.text,
                          bankId: controllerDoctor.bankIdFromList.value);
                      await controllerDoctor.listBankDoctor();
                    }
                    controllerDoctor.nomerRekeningController.clear();
                    controllerDoctor.namaController.clear();
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      content: const Text('Berhasil Menambah Bank'),
                      backgroundColor: (Colors.green),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Get.back();
                  },
                  margin: 20,
                ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> pilihanBank = [
  {"image": 'assets/icon/icon_bankbca.png', "name": "Bank Central Asia"},
  {"image": 'assets/icon/icon_bankbri.png', "name": "Bank Rakyat Indonesia"},
  {"image": 'assets/icon/icon_bankpermata.png', "name": "Bank Permata"},
  {"image": 'assets/icon/icon_bankcimb.png', "name": "Bank CIMB Niaga"},
  {"image": 'assets/icon/icon_bankmandiri.png', "name": "Bank Mandiri"},
  {"image": 'assets/icon/icon_bankmybank.png', "name": "Bank Maybank"},
];
