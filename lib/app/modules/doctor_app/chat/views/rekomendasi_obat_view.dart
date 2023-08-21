import 'package:bionmed/app/modules/doctor_app/chat/views/catatan_docter_view.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widget/button/button_primary_withtext.dart';
import '../../../../widget/grid/grid_widget.dart';
import '../controllers/chat_controller.dart';

// ignore: must_be_immutable
class RekomendasiObat extends GetView<ChatController> {
  // TextEditingController controllerRekomendasi = TextEditingController();
  const RekomendasiObat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: appbarGradient("Rekomendasi Obat"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: const InputSearch()),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kategori Obat',
                        style: blackTextStyle.copyWith(
                            fontWeight: bold, fontSize: 16),
                      ),
                      Text(
                        'Cari obat berdasarkan dengan Gejala',
                        style: subtitleTextStyle.copyWith(
                            fontWeight: normal, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    'Semuanya',
                    style: GoogleFonts.ubuntu(
                        fontSize: 12, color: blueColor, fontWeight: medium),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridWidget(
                itemCount: 8,
                crossAxisC: 4,
                crossAxisS: 8,
                mainAxisE: 100,
                mainAxisS: 14,
                widget: (p0, p1) => Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    height: 72,
                    width: 72,
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: textFieldC,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      '${kategoriObat[p1]['imageUrl']}',
                    ),
                  ),
                  Text(
                    "${kategoriObat[p1]['title']}",
                    style: blackTextStyle.copyWith(fontSize: 10),
                    // textAlign: TextAlign.center,
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridWidget(
                  itemCount: obat.length,
                  crossAxisC: 2,
                  crossAxisS: 24,
                  mainAxisE: 200,
                  mainAxisS: 24,
                  widget: (build, index) => Container(
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 10,
                                color: Color.fromARGB(255, 224, 220, 220))
                          ],
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              '${obat[index]['imageUrl']}',
                            ),
                            Text(
                              "${obat[index]['title']}",
                              style: blackTextStyle.copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 290,
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
                                                  color:
                                                      const Color(0xffEDEDED)),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Beri resep dokter untuk pasien mengkonsupsi\nobat',
                                              style: subtitleTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              child: InputPrimary(
                                                  onChange: (p0) {},
                                                  controller: controller
                                                      .controllerRekomendasi,
                                                  hintText: "Deskripsi",
                                                  onTap: () {}),
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            ButtonPrimary(
                                                title: "Rekomendasikan",
                                                onPressed: () {
                                                  if (controller
                                                      .controllerRekomendasi
                                                      .value
                                                      .text
                                                      .isEmpty) {
                                                        Get.defaultDialog(
                                                          // contentPadding: EdgeInsets.all(20),
                                                          textCancel: 'Tutup',
                                                          // custom: Text('sasasa'),
                                                          // cancel: IconButton(onPressed: (){}, icon: Icon(Icons.cancel)),
                                                          title: "Terjadi Kesalahan",
                                                          middleText: 'Mohon isi deskripsi\nterlebih dahulu');
                                                    // Get.snackbar(
                                                    //   snackPosition: SnackPosition.BOTTOM,
                                                    //   'title', 'message');
                                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('dada')));
                                                    // showDialog(
                                                    //   context: context,
                                                    //   builder: (context) =>
                                                    //       AlertDialog(
                                                            
                                                    //     title: Text('Mohon isi deskripsi\nterlebih dahulu', textAlign: TextAlign.center,),
                                                    //   ),
                                                    // );
                                                  } else {
                                                    controller.rekomdasiObat
                                                        .add({
                                                      'imageUrl': obat[index]
                                                          ['imageUrl'],
                                                      'title': obat[index]
                                                          ['title'],
                                                      'deskripsi': controller
                                                          .controllerRekomendasi
                                                          .value
                                                          .text
                                                    });
                                                    // print(controller.controllerRekomendasi.value.text);
                                                    // Get.back();
                                                    Get.to(()=> CatatanDocter());
                                                  } //     .value.text;
                                                  // Get.toNamed(Routes.CHAT);
                                                })
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                height: 23,
                                width: 101,
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  "Rekomendasi",
                                  style: greenTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 11),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class InputSearch extends StatelessWidget {
  const InputSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.red[50]!, blurRadius: 10, spreadRadius: 1)
      ]),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Cari dokter yang sesuai...",
            hintStyle: TextStyle(color: buttonColor),
            suffixIcon: Icon(
              Icons.search,
              color: buttonColor,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

List<Map<String, dynamic>> kategoriObat = [
  {
    "imageUrl": "assets/icon/icon_Cat_obat.png",
    "title": "Mual",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat1.png",
    "title": "Flu",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat2.png",
    "title": "Pusing",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat3.png",
    "title": "Covid-19",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat4.png",
    "title": "Demam",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat5.png",
    "title": "Kulit",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat6.png",
    "title": "Anti Biotik",
  },
  {
    "imageUrl": "assets/icon/icon_Cat_obat7.png",
    "title": "Nafsu Makan",
  },
];

List<Map<String, dynamic>> obat = [
  {
    "imageUrl": "assets/images/obat.png",
    "title": "Evalen gel 10 g",
  },
  {
    "imageUrl": "assets/images/obat1.png",
    "title": "Ever E250",
  },
  {
    "imageUrl": "assets/images/obat2.png",
    "title": "Hemaviton Kapsul ",
  },
  {
    "imageUrl": "assets/images/obat3.png",
    "title": "Vitamin C1000",
  },
  {
    "imageUrl": "assets/images/obat.png",
    "title": "Evalen gel 10 g",
  },
  {
    "imageUrl": "assets/images/obat1.png",
    "title": "Ever E250",
  }
];
