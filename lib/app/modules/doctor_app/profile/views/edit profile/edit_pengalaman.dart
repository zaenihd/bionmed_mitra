import 'package:bionmed/app/modules/doctor_app/jadwal_saya/controllers/jadwal_saya_controller.dart';
import 'package:bionmed/app/modules/doctor_app/lengkapi_profil/controllers/lengkapi_profil_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/modules/doctor_app/profile/controllers/profile_controller.dart';
import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widget/button/button_gradien.dart';

class EditPengalaman extends StatefulWidget {
  const EditPengalaman({super.key});

  @override
  State<EditPengalaman> createState() => _EditPengalamanState();
}

final pengalamanC = Get.put(JadwalSayaController());
final profileC = Get.put(ProfileController());

class _EditPengalamanState extends State<EditPengalaman> {
  List datas = [];
  bool load = false;
  List pengalamanNurse = [];
  List pengalamanNurse1 = [];
  @override
  void initState() {
    // setState(() {
    //   pengalamanNurse = [
    //     {"data": pengalamanC.pengalamanDokter}
    //   ];
    // });
    // print('ayee ' + pengalamanNurse.toString() );
    checkExperience();
    super.initState();
  }

  checkExperience() async {
    if (Get.put(LoginController()).role.value == 'nurse') {
      for (var i in pengalamanC.pengalamanDokter) {
        setState(() {
          datas.add({"experience": i['description']});
        });
        // print('uyee' + i.toString());
      }
    } else {
      final data = await pengalamanC.checkPengalaman();

      for (var i in data) {
        setState(() {
          datas.add({"experience": i['description']});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBack(),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icon/icon_praktek.png'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Tempat Praktek',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    'Informasikan tempat praktek anda ',
                    style: subtitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  // Image.asset('assets/icon/stepper2.png'),
                  const SizedBox(
                    height: 23.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masukkan Tempat Praktek',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (profileC.pengalaman.value.text.isEmpty) {
                            final snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              content: const Text('Mohon isi tempat praktek'),
                              backgroundColor: (Colors.red),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {},
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            setState(() {
                              datas.add({
                                "experience": profileC.pengalaman.value.text
                              });
                            });
                            profileC.pengalaman.clear();
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Tambah',
                              style: blackTextStyle.copyWith(color: blueColor),
                            ),
                            Icon(
                              Icons.add,
                              size: 15,
                              color: blueColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  InputPrimary(
                    onChange: (p0) {},
                    controller: profileC.pengalaman,
                    onTap: () {},
                    hintText: 'Masukkan tempat praktek anda',
                  ),
                  SizedBox(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: buttonColor!),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${datas[index]['experience']}"),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    datas.removeAt(index);
                                  });
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ]),
          )),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: ButtomGradient(
                label: 'Simpan',
                onTap: () async {
                  if (datas.isEmpty) {
                    if (profileC.pengalaman.value.text == "") {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Mohon isi data Pengalaman'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      setState(() {
                        datas.add(
                            {"experience": profileC.pengalaman.value.text});
                      });
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        await profileC.editPengalaman(experience: datas);
                      }
                      {
                        await Get.put(LengkapiProfilController())
                            .tambahPengalamanNurse(experience: datas);
                      }
                      // profileC.editPengalaman(experience: datas);
                      profileC.pengalaman.clear();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Berhasil di simpan'),
                        backgroundColor: (Colors.green),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.back();
                    }
                  } else {
                    if (profileC.pengalaman.value.text == "" && datas.isEmpty) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Mohon isi data Pengalaman'),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (profileC.pengalaman.value.text == "") {
                      Get.back();
                    } else {
                      setState(() {
                        datas.add(
                            {"experience": profileC.pengalaman.value.text});
                      });
                      if (Get.find<LoginController>().role.value == 'doctor') {
                        await profileC.editPengalaman(experience: datas);
                      }
                      {
                        Get.find<LoginController>().isVerifikasiNurse.value = 1;
                        
                        await Get.put(LengkapiProfilController())
                            .tambahPengalamanNurse(experience: datas);
                      }
                      // profileC.editPengalaman(experience: datas);
                      profileC.pengalaman.clear();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        content: const Text('Berhasil di simpan'),
                        backgroundColor: (Colors.green),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.back();
                    }
                  }
                   if (Get.find<LoginController>().role.value == 'doctor') {
                        await profileC.editPengalaman(experience: datas);
                      }
                      {
                        Get.find<LoginController>().isVerifikasiNurse.value = 1;

                        await Get.put(LengkapiProfilController())
                            .tambahPengalamanNurse(experience: datas);
                      }

                  // checkExperience();
                })));
  }
}
