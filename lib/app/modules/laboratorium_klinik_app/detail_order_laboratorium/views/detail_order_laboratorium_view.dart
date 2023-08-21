import 'package:bionmed/app/modules/doctor_app/detail/views/detail_view.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../controllers/detail_order_laboratorium_controller.dart';

class DetailOrderLaboratoriumView
    extends GetView<DetailOrderLaboratoriumController> {
  DetailOrderLaboratoriumView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(DetailOrderLaboratoriumController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  namePasien(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Txt(
                    text: 'Info Pesanan',
                    size: 16,
                    weight: bold,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InfoOrder(status: '3', onTap: () {}),
                  const SizedBox(
                    height: 20.0,
                  ),
                  jadwalPengambilanTes(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  dataDiriPasien(),
                  detailPaket(),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            hargaDanActionButton(),
          ],
        ),
      ),
    );
  }

  //METHOD WIDGET
  
  Row namePasien() {
    return Row(
      children: [
        Cntr(
          height: 72,
          width: 112,
          image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/id/237/200/300'),
              fit: BoxFit.cover),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(text: 'Laboratorium'),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 20,
                ),
                Txt(
                  text: 'Jakarta Barat',
                  size: 12,
                  color: Colors.grey,
                )
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: 15,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Txt(
                  text: '5.0',
                  size: 12,
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Cntr hargaDanActionButton() {
    return Cntr(
      boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.grey[300]!, spreadRadius: 0.6)
      ],
      height: 180,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(text: 'Total Harga :'),
                Column(
                  children: [
                    Txt(
                      text: 'Rp.22222222',
                      color: Colors.green,
                    ),
                    const SizedBox(
                    height: 6.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Txt(
                          text: 'Sudah Bayar',
                          color: Colors.green,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          ButtomGradient(
              label: 'Upload Bukti Pengambilan Sample',
              onTap: () {
                actionUploadBuktiSample();
              }),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 45,
              width: Get.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      backgroundColor: const Color(0xffFFE4E4)),
                  onPressed: () {},
                  child: Txt(
                    text: "Laporkan?",
                    color: Colors.red,
                    weight: bold,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Cntr jadwalPengambilanTes() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Terjadwalkan',
                        weight: bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Pengambilan Sample Tes',
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.access_time_filled_outlined,
                    color: Colors.white,
                    size: 40,
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Jenis',
                    color: Colors.white,
                  ),
                  Txt(
                    text: 'Datang Kerumah',
                    weight: bold,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Tanggal',
                    color: Colors.white,
                  ),
                  Txt(
                    text: '19 Juni 2023',
                    weight: bold,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Jadwal',
                    color: Colors.white,
                  ),
                  Txt(
                    text: '14.00 WIB',
                    weight: bold,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  Cntr detailPaket() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: Colors.grey[200],
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Detail Paket',
            weight: bold,
          ),
          children: [
            Cntr(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
              radius: BorderRadius.circular(10),
              width: Get.width,
              color: Colors.grey[200],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Layanan',
                        color: Colors.grey,
                      ),
                      Txt(
                        text: 'Paket 1',
                        weight: bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60 * 3,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => Cntr(
                        radius: BorderRadius.circular(10),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          title: const Text('Test Darah'),
                          leading: Cntr(
                            height: 40,
                            width: 40,
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://picsum.photos/id/37/200/300'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Cntr dataDiriPasien() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: Colors.grey[200],
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data Diri Pasien',
            weight: bold,
          ),
          children: [
            Cntr(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                radius: BorderRadius.circular(10),
                width: Get.width,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Nama',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Jenis Kelamin',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Umur',
                        ),
                        Txt(
                          text: 'Datang Kerumah',
                          weight: bold,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          text: 'Alamat',
                        ),
                        InkWell(
                          onTap: () {},
                          child: Txt(
                            text: 'Detail',
                            weight: bold,
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Cntr(
                      padding: const EdgeInsets.all(10),
                      radius: BorderRadius.circular(10),
                      height: 100,
                      width: Get.width,
                      border: Border.all(color: Colors.grey),
                      child: Txt(
                          text:
                              'text'),
                    )
                  ],
                )),
          ]),
    );
  }

  actionUploadBuktiSample() {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        Cntr(
          padding: const EdgeInsets.all(20),
          radius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
               Cntr(
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    height: 10,
                    width: 200,
                    color: Colors.grey[300],
                    radius: BorderRadius.circular(20),
                  ),
                
                const SizedBox(
                  height: 20.0,
                ),
                Txt(text: 'Upload bukti pengambilan sample tes'),
                const SizedBox(
                  height: 20.0,
                ),
                 InkWell(
                  onTap: () {
                    controller.pickerFilesImage(Get.context!);
                  },
                  child: 
                Cntr(
                  radius: BorderRadius.circular(10),
                  width: Get.width,
                  padding: EdgeInsets.zero,
                  border: Border.all(color: Colors.grey[300]!),
                  child: ListTile(
                    leading: const Icon(
                      Icons.upload,
                    ),
                    title: Obx(()=>Txt(
                      maxLines: 1,
                      textOverFlow: TextOverflow.ellipsis,
                      text: controller.imageUrl.isEmpty ? 'Upload bukti foto' : controller.imageUrl.value,
                      color:controller.imageUrl.isEmpty ? Colors.grey[500] : Colors.black,
                    ),),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    controller.pickDate();
                  },
                  child: Cntr(
                    radius: BorderRadius.circular(10),
                    width: Get.width,
                    padding: EdgeInsets.zero,
                    border: Border.all(color: Colors.grey[300]!),
                    child: ListTile(
                      // ignore: prefer_const_constructors
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Obx(
                        () => Txt(
                          text: controller.tanggalRiset.isEmpty
                              ? 'Masukkan estimasi selesai riset lab'
                              : controller.tanggalRiset.value,
                          color: controller.tanggalRiset.isEmpty
                              ? Colors.grey[500]
                              : Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Cntr(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    width: Get.width,
                    height: 130,
                    radius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    child: TextFormField(
                      maxLines: 10,
                      decoration: const InputDecoration(
                          hintText: 'Berikan alasan jika ada',
                          hintStyle: TextStyle(color: Colors.grey),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                ButtomGradient(
                  margin: 0,
                  label: 'Kirim & Lanjtukan proses lab',
                  onTap: () {
                    Get.back();
                    Get.bottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        Cntr(
                            padding: const EdgeInsets.all(20),
                            radius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            height: Get.height /2.6,
                            child: Column(
                              children: [
                                Cntr(
                                  // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  height: 10,
                                  width: 200,
                                  color: Colors.grey[300],
                                  radius: BorderRadius.circular(20),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Txt(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Terima kasih, telah memberikan\nbukti pengambilan tes'),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Image.asset('assets/images/berhasil.png'),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                ButtomGradient(
                                  label: 'Oke',
                                  onTap: () {Get.back();},
                                )
                              ],
                            )));
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ));
  }
}
