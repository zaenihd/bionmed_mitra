import 'package:bionmed/app/modules/doctor_app/chat/views/rekomendasi_obat_view.dart';
import 'package:bionmed/app/widget/appbar/appbar_gradient.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/theme.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/textform/input_primary.dart';
import '../controllers/chat_controller.dart';

class CatatanDocter extends GetView<ChatController> {
  CatatanDocter({Key? key}) : super(key: key);

  // ignore: annotate_overrides
  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      appBar: appbarGradient("Catatan Dokter"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/icon/icon_catatan.png'),
                Text(
                  'Kesimpulan dari Konsultasi',
                  style:
                      blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 26,
            ),
            InputText(
                maxLines: 1,
                label: "Deskripsi",
                border: const BorderSide(
                  color: Color(0xffF5F5F5),
                  width: 1,
                ),
                color: whiteColor!),
            // Container(
            //   width: Get.width,
            //   padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       border: Border.all(color: Color(0xffF5F5F5))),
            //   child: Text(
            //     'Deskripsi',
            //     style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 16),
            //   ),
            // ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Rekomendasi obat',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 12),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => controller.rekomdasiObat.isEmpty
                  ? InputObat(
                      onTap: () {
                        Get.to(() => const RekomendasiObat());
                      },
                      label: "Masukkan Produk")
                  : Expanded(
                      // height: 100,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.rekomdasiObat.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xffF8F8F8)),
                          child: ListTile(
                            leading: Image.asset(
                                '${controller.rekomdasiObat[index]['imageUrl']}'),
                            title: Text(
                              '${controller.rekomdasiObat[index]['title']}',
                              style: blackTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 14),
                            ),
                            subtitle: Text(
                                '${controller.rekomdasiObat[index]['deskripsi']}'),
                            trailing: InkWell(
                                onTap: () {
                                  controller.rekomdasiObat.removeLast();
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            InputObat(
              label: ' + Tambah Obat',
              onTap: () {
                Get.to(() => const RekomendasiObat());
                controller.controllerRekomendasi.clear();
              },
            )
            // InputObat(
            //   label: 'Masukan Produk',
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            // InputObat(
            //   label: '+ Tambah Produk',
            // ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Obx(() => controller.rekomdasiObat.isEmpty
            ? ButtonPrimary(
                title: "Kirim",
                onPressed: () {
                })
            : ButtomGradient(label: 'Kirim', onTap: () {
                  // Get.back();

            })),
      ),
    );
  }
}

// ignore: must_be_immutable
class InputObat extends StatelessWidget {
  InputObat({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final myC = Get.find<ChatController>();

  String label;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: Get.width,
          padding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
          decoration: DottedDecoration(
              shape: Shape.box,
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffEDEDED))
          // BoxDecoration(
          //   borderRadius: BorderRadius.circular(6),
          //     color: Color(0xffF8F8F8)),
          //     child: ListTile(leading: Image.asset('assets/images/obat3.png'),
          //     title: Text('Vitamin C1000', style: blackTextStyle.copyWith(fontWeight: bold,fontSize: 14),),
          //     subtitle: Text('2 x 3 hari'),
          //     trailing: Icon(Icons.edit, color: Colors.black,),
          //     ),
          ,
          child: Text(
            label,
            style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 16),
          )),
    );
  }
}
