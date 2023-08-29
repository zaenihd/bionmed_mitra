import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/detail/views/detail_view.dart';
import 'package:bionmed/app/modules/hospital_app/detail_order_hospital/controllers/detail_order_hospital_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/textform/input_primary1.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailOrderHospitalView extends GetView<DetailOrderHospitalController> {
  DetailOrderHospitalView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(DetailOrderHospitalController());
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
                  tujuanAmbulance(),
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
                  namaPerawat(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  detailAmbulance(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  jadwalPengambilanTes(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  prosesStatusOrder(),
                  dataDiriPasien(),
                  detailPaket(),
                  Rating(rating: 2.0),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            hargaDanActionButton(context),
          ],
        ),
      ),
    );
  }

  Cntr tujuanAmbulance() {
    return Cntr(
      width: Get.width,
      padding: const EdgeInsets.all(25),
      color: Colors.grey[300],
      radius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: 'Tujuan Anda',
            weight: bold,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(text: 'Alamat :'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Txt(
                    text: 'Jl.Padjajaran',
                    weight: bold,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(text: 'Tujuan :'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Txt(
                    text: 'Jl.Padjajaran',
                    weight: bold,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // /=============================================================/METHOD WIDGET===========================================

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

  Cntr hargaDanActionButton(BuildContext context) {
    return Cntr(
      boxShadow: [
        BoxShadow(blurRadius: 10, color: Colors.grey[300]!, spreadRadius: 0.6)
      ],
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(text: "Harga /hari"),
                    Txt(text: "Rp 5.000.000 "),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(text: "Hari"),
                    Txt(text: "5 Hari"),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(text: "Diskon"),
                    Txt(text: "50%"),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
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
              ],
            ),
          ),
          ButtomGradient(
              label: 'Konfirmasi Perawatan telah selesai',
              onTap: () {
                // actionUploadBuktiSample();
                popUpSelesaiKonfirmasi(context);
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
                  onPressed: () {
                    popUpBerikanLaporan(context);
                  },
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
                children: [
                  const Icon(
                    Icons.access_time_filled_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        text: 'Terjadwalkan pada :',
                        weight: bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Txt(
                              text: 'Tanggal',
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 110.0,
                            ),
                            Txt(
                              text: '19 Juni 2023',
                              weight: bold,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                        weight: FontWeight.bold,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        radius: BorderRadius.circular(10),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Cntr(
                              height: 16,
                              width: 16,
                              child: Image.asset('assets/icon/icon_add.png'),
                            ),
                            const Text('Pengecekan Tensi Darah'),
                          ],
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

  Cntr namaPerawat() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    text: 'Detail Perawat',
                    size: 12,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Cntr(
                        height: 20,
                        width: 20,
                        color: Colors.white,
                        radius: BorderRadius.circular(5),
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Cntr(
                        margin: const EdgeInsets.only(right: 10),
                        height: 20,
                        width: 20,
                        color: Colors.white,
                        radius: BorderRadius.circular(5),
                        child: const Icon(
                          Icons.edit_note_sharp,
                          color: Colors.green,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Txt(
                        text: 'Dr. ni putu ani',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Umur    : 36 Tahun',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'No STR : 12345678',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Cntr(
                    radius: BorderRadius.circular(100),
                    height: 80,
                    width: 80,
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.white, width: 4),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Cntr detailAmbulance() {
    return Cntr(
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Detail Ambulance',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'DK 1234 FGH',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Txt(
                        text: 'Ambulance Standar 1',
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      popUpkirimLaporanSelesaiAmbulance(Get.context!);
                    },
                    child: Cntr(
                      radius: BorderRadius.circular(100),
                      height: 80,
                      width: 80,
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://fastly.picsum.photos/id/201/200/300.jpg?blur=2&hmac=Bk1YAURRJgndPj6oL1nVMMPuskT1OVuu7itxEp71aH4'),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),

                  // const Icon(
                  //   Icons.access_time_filled_outlined,
                  //   color: Colors.white,
                  //   size: 40,
                  // )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  popUpLihatGambar(Get.context!);
                },
                child: Cntr(
                  alignment: Alignment.center,
                  radius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  height: 40,
                  width: Get.width,
                  border: Border.all(color: Colors.white),
                  child: Txt(
                    text: "Lihat gambar",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
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
                              'Text'),
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
                  child: Cntr(
                    radius: BorderRadius.circular(10),
                    width: Get.width,
                    padding: EdgeInsets.zero,
                    border: Border.all(color: Colors.grey[300]!),
                    child: ListTile(
                      leading: const Icon(
                        Icons.upload,
                      ),
                      title: Obx(
                        () => Txt(
                          maxLines: 1,
                          textOverFlow: TextOverflow.ellipsis,
                          text: controller.imageUrl.isEmpty
                              ? 'Upload bukti foto'
                              : controller.imageUrl.value,
                          color: controller.imageUrl.isEmpty
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
                            height: Get.height / 2.6,
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
                                  onTap: () {
                                    Get.back();
                                  },
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

  Cntr prosesStatusOrder() {
    return Cntr(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.centerLeft,
      width: Get.width,
      gradient: AppColor.gradient1,
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Row(
            children: [
              const Icon(
                Icons.access_time_filled,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Perawatan Sedang Berlangsung',
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  Txt(
                    text: 'Lihat laporan harian',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          children: [
            Cntr(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Txt(
                        text: 'Senin, 12 Juni 2023',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      Txt(
                        text: 'Senin, 12 Juni 2023',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      popUpLihatGambar(Get.context!);
                    },
                    child: Cntr(
                      alignment: Alignment.center,
                      radius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      height: 40,
                      width: Get.width,
                      border: Border.all(color: Colors.white),
                      child: Txt(
                        text: "Lihat gambar",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )
          ]),
    );
  }

  popUpLihatGambar(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Cntr(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 260,
                            width: Get.width,
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://picsum.photos/200/300/?blur'),
                            ),
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtomGradient(
                            label: "Kembali",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpBerikanLaporan(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 320,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(
                            text: 'Berikan laporan harian\nkepada pasien',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),

                          // ignore: avoid_unnecessary_containers
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Tanggal',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                InputPrimary(
                                  controller: controller.tanggalC,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      // ignore: avoid_print
                                      print(pickedDate);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      // ignore: avoid_print
                                      print(formattedDate);

                                      controller.tanggalC.text = formattedDate;
                                    } else {
                                      // ignore: avoid_print
                                      print("Date is not selected");
                                    }
                                  },
                                  hintText: "Masukkan tanggal laporan",
                                  onChange: (val) {},
                                  validate: (value) {
                                    if (value.toString().isNotEmpty) {
                                      return null;
                                    }
                                    return "Tanggal lahir tidak boleh kosong";
                                  },
                                  prefixIcon: const Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ButtomGradient(
                            label: "Kirim laporan",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpkirimLaporanSelesaiAmbulance(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 280,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(
                            text:
                                'Apakah pesanan ambulance\ntelah anda nyatakan selesai?',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),

                          // ignore: avoid_unnecessary_containers
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                // if (controller
                                //     .nurseScopeData.isEmpty) {
                                //   controller.getNurseWorkScope();
                                // }
                                controller.pickerFilesImage(context);
                              },
                              child: Cntr(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: 50,
                                alignment: Alignment.centerLeft,
                                width: Get.width,
                                color: AppColor.bgForm,
                                radius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey[300]!),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Obx(
                                        //   () =>
                                        Icon(
                                          Icons.upload,
                                          color: AppColor.bodyColor.shade500,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        //    controller
                                        //           .tampunganNurseId
                                        //           .isNotEmpty
                                        //       ? Txt(
                                        //           text:
                                        //               '${controller.tampunganNurseId.length} Dipilih')
                                        //       :
                                        Txt(
                                          text: 'Upload foto bukti',
                                          color: AppColor.bodyColor.shade500,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 20,
                                      color: AppColor.bodyColor.shade500,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ButtomGradient(
                            label: "Kirim laporan",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpSelesaiKonfirmasi(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 280,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Terima kasih, telah mengkonfirmasi',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Image.asset('assets/images/berhasil.png'),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtomGradient(
                            label: "Oke",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ])
                  ]));
        });
  }

  popUpPilihPerawat(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18, top: 14),
                            width: Get.width / 1.9,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDEDED)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Txt(text: 'Pilih Perawat'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Cntr(
                              height: 230,
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) => ListTile(
                                    title: Txt(
                                      text: 'Dr.John',
                                      weight: bold,
                                    ),
                                    subtitle: Txt(
                                      text: 'Dokter Umum',
                                      weight: medium,
                                      size: 12,
                                    ),
                                    trailing: Checkbox(
                                      onChanged: (value) {
                                        value = true;
                                      },
                                      value: false,
                                    ),
                                    leading: Cntr(
                                      height: 50,
                                      width: 50,
                                      radius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://picsum.photos/id/${700 + index}/200/300?grayscale&blur=2'),
                                          fit: BoxFit.cover),
                                    )),
                              )),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ButtomGradient(
                            label: "Kembali",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ])
                  ]));
        });
  }
}

// ignore: must_be_immutable
class Rating extends StatelessWidget {
  Rating({Key? key, this.rating}) : super(key: key);

  double? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Txt(
          text: 'Penilian',
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 6.0,
        ),
        Txt(
          text: 'Penilaian untuk anda',
          weight: FontWeight.w400,
        ),
        const SizedBox(
          height: 20.0,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        //   child:
        //       Center(child: Image.asset('assets/icon/icon_order_finish.png')),
        // ),
        // Center(
        //     child: Text(
        //   'Konsultasi Selesai',
        //   style: blackTextStyle.copyWith(fontWeight: bold),
        // )),
        // Center(
        //     child: Text(
        //   'Sesi konsultasi telah selesai',
        //   style: subtitleTextStyle.copyWith(fontWeight: normal),
        // )),
        // const SizedBox(
        //   height: 20,
        // ),
        Center(
          child: RatingBar.builder(
            ignoreGestures: true,
            initialRating: double.parse(rating.toString()),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
        // SizedBox(
        //   // alignment: Alignment.center,
        //   width: 400,
        //   height: 50,
        //   child: SizedBox(
        //       height: 50,
        //       child: ListView.builder(
        //         // padding: const EdgeInsets.all(10),
        //         itemCount: 5,
        //         // physics: NeverScrollableScrollPhysics(),
        //         scrollDirection: Axis.horizontal,
        //         itemBuilder: (context, index) =>
        //             InkWell(
        //               onTap: (){
        //                 Get.put(DetailController()).selected.toggle();
        //               },
        //               child: Obx(()=> Get.put(DetailController()).selected.isFalse? Image.asset('assets/icon/icon_staron.png') : Image.asset('assets/icon/icon_staroff.png'))),
        //       )),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staron.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //     Image.asset('assets/icon/icon_staroff.png'),
        //   ],
        // ),
        const SizedBox(
          height: 20,
        ),
        const Align(alignment: Alignment.centerLeft, child: Text('Deskripsi')),
        const SizedBox(
          height: 10,
        ),
        // Obx(() =>
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: const Text("deskripsiRating.value"))
        // ),
      ],
    );
  }
}
