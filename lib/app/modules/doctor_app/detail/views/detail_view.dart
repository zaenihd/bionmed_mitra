import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/detail/views/detail_resep.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/card/card_layanan.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/other/loading_indicator.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../theme.dart';
import '../controllers/detail_controller.dart';

// ignore: must_be_immutable
class DetailView extends GetView<DetailController> {
  DetailView(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.totalPrice,
      required this.tanggal,
      required this.jamMulai,
      required this.jamSelesai,
      required this.codeOrder,
      required this.statusPembayaran,
      // required this.layanan,
      // required this.statusVerifikasi,
      // required this.terlewatkan,
      // required this.pasienTitle,
      // required this.pasienSubtitle,
      // required this.data,
      // required this.bottomHcontainer,
      required this.buttonGradient,
      required this.rating,
      // required this.onTap,
      required this.buttonGradientfinish,
      // required this.time,
      required this.iconService,
      required this.service,
      required this.statusOrder,
      required this.statusOrderImage,
      required this.iconPembayaran,
      this.dataDetail
      // required this.discount
      })
      : super(key: key);

  final layananHomeC = Get.find<LayananHomeController>();
  // ignore: annotate_overrides
  final controller = Get.put(DetailController());

  String? imageUrl;
  String? name;
  int? totalPrice;
  String tanggal;
  String codeOrder;
  String jamMulai;
  String jamSelesai;
  // String? layanan;
  // String? statusVerifikasi;
  // String? terlewatkan;
  // String? pasienTitle;
  // String? pasienSubtitle;
  // dynamic data;
  // double bottomHcontainer;
  Widget buttonGradient;
  Widget rating;
  Widget buttonGradientfinish;
  // String time;
  String iconService;
  String service;
  // int? discount;
  // Function() onTap;
  Widget statusOrder;
  Widget statusOrderImage;
  Widget statusPembayaran;
  Widget iconPembayaran;
  // ignore: prefer_typing_uninitialized_variables
  var dataDetail;

  DateTime now = DateTime.now();
  final Uri whatsapp = Uri.parse('https://wa.me/6282147738240');
  sendEmail() async {
    final Email email = Email(
      body: 'Deskripsi',
      subject: 'Selamat Pagi',
      recipients: ['care@bionmed.id'],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<LoginController>().role.value == "nurse" || Get.find<LoginController>().role.value == "hospital" ) {
      Get.find<LayananHomeController>().getOrderDetailNurse();
    } else {
      Get.find<LayananHomeController>().getOrderDetail();
    }
    return Scaffold(
        backgroundColor: backgroundColorC,
        appBar: AppBar(
          title: InkWell(onTap: () {
            // actionUploadBuktiSample();
            // popUpJadwalPengambilanTest();
          }, child: const Text("Detail Order")),
          leading: IconButton(
              onPressed: () {
                controller.stop = true;
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          elevation: 0.0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.gradient1,
            ),
          ),
        ),
        body: Obx(
          () => layananHomeC.isLoadingDetail.isTrue
              ? loadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Header(
                                    iconService: iconService,
                                    service: service,
                                    imageUrl: imageUrl!,
                                    name: name!,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Info Order',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: bold),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  statusOrder,
                                  // detailPesananDokter(),
                                ]),
                          ),
                          // SizedBox(height: 200,)
                        ],
                      ),
                          // jadwalPengambilanTes(),
                          // const SizedBox(
                          // height: 20.0,
                          // ),
                      Get.find<LoginController>().role.value == "nurse" || Get.find<LoginController>().role.value == "hospital"
                          ? detailPesananNurse(context)
                          : detailPesananDokter(),
                    ],
                  ),
                ),
        ));
  }

  Column detailPesananNurse(BuildContext context) {
    return Column(
      children: [
        Cntr(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            gradient: gradient1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tanggal Pemesanan',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      DateFormat('d MMMM y, kk:mm', "id_ID")
                          .format(DateTime.parse(tanggal)),
                      style: blackTextStyle.copyWith(
                          fontWeight: bold, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mulai Order',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Selesai Order',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          DateFormat('d MMMM y, kk:mm', "id_ID")
                              .format(DateTime.parse(jamMulai)),
                          // CurrencyFormat.convertToIdr(discount, 0),
                          style: blackTextStyle.copyWith(
                              fontWeight: bold, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          DateFormat('d MMMM y, kk:mm', "id_ID")
                              .format(DateTime.parse(jamSelesai)),
                          // CurrencyFormat.convertToIdr(discount, 0),
                          style: blackTextStyle.copyWith(
                              fontWeight: bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 15.0,
        ),
        Visibility(
          visible: dataDetail['nurse']['hospital'] != null,
          child: namaHospital()),
        dataOrderNurse(),
        const SizedBox(
          height: 20.0,
        ),
        dataPemesanNurse(),
        const SizedBox(
          height: 20.0,
        ),
        // detailPaketNurse(),
        // const SizedBox(
        //   height: 25.0,
        // ),
        // InkWell(
        //         onTap: () {
        //           popUpLihatGambar(Get.context!);
        //         },
        //         child: Cntr(
        //           margin: const EdgeInsets.symmetric(horizontal: 24),
        //           alignment: Alignment.center,
        //           radius: BorderRadius.circular(10),
        //           color: Colors.transparent,
        //           height: 40,
        //           width: Get.width,
        //           border: Border.all(color: Colors.blue),
        //           child: Txt(
        //             text: "Lihat bukti selesai",
        //             color: Colors.blue,
        //           ),
        //         ),
        //       ),
        // tujuanAmbulance(),
        // const SizedBox(
        // height: 20.0,
        // ),
        Cntr(
            width: Get.width,
            boxShadow: const [
              BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.grey)
            ],
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            color: Colors.white,
            child: dataDetail['status'] == 4
                ? Column(
                    children: [
                      buttonGradient,
                      const SizedBox(
                        height: 15.0,
                      ),
                      actionLaporkan(context)
                    ],
                  )
                : dataDetail['status'] == 99
                    ? Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Txt(
                              text:
                                  'Menunggu pemesan mengatur ulang jadwal atau mebatalkan pesanan',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          actionLaporkan(context)
                        ],
                      )
                    : dataDetail['status'] == 98
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Txt(
                              text:
                                  'Mohon maaf pesanan ini telah dibatalkan oleh pemesan',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : dataDetail['status'] == 6
                            ? Cntr(
                                alignment: Alignment.center,
                                width: Get.width,
                                child: Txt(text: 'Menunggu penilaian pasien'),
                              )
                            : dataDetail['status'] == 5
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Column(
                                      children: [
                                        Txt(
                                          text: 'Penilaian',
                                          weight: bold,
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Txt(
                                          text: 'Penilaian untuk anda',
                                          weight: normal,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        rating,
                                      ],
                                    ),
                                  )
                                : buttonGradient)
      ],
    );
  }

  ButtonPrimary actionLaporkan(BuildContext context) {
    return ButtonPrimary(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 150,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColor.bodyColor.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Hubungi Helpdesk'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(whatsapp);
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xff9CEEA5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/icon_wa.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            '+62 8821-8721-8723',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00810F)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      sendEmail();
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xffFFB3AD),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/icon_gmail.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            'care@bionmed.id',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffC80000)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      // FlutterPhoneDirectCaller.callNumber("+6289657081093");
                      // ignore: deprecated_member_use
                      launch("tel:(021) 82407779");
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Color(0xffB1D4F7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/icon_call.png'),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            '(021) 82407779',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff001A61)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              );
            });
      },
      title: "Laporkan?",
      color: Colors.red,
      backgroundColor: const Color(0xffFFE4E4),
    );
  }

  Cntr detailPaketNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Detail Paket',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Layanan',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: dataDetail['service']['name'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Cntr(
                    color: Colors.transparent,
                    height: 50.0 *
                        Get.find<LayananHomeController>()
                            .packageNurseSops
                            .length,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: Get.find<LayananHomeController>()
                          .packageNurseSops
                          .length,
                      itemBuilder: (context, index) => Cntr(
                        radius: BorderRadius.circular(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              Get.find<LayananHomeController>()
                                      .packageNurseSops[index]
                                  ['nurse_work_scope']['icon'],
                              height: 20,
                            ),
                            Cntr(
                              width: Get.width / 1.7,
                              child: Txt(
                                  text: Get.find<LayananHomeController>()
                                          .packageNurseSops[index]
                                      ['nurse_work_scope']['name']),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Cntr namaHospital() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      radius: BorderRadius.circular(10),
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      gradient: AppColor.gradient1,
      child: Column(
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cntr(
                        color: Colors.transparent,
                        height: 40,
                        width: 40,
                        image: DecorationImage(
                            image: NetworkImage(dataDetail['service']['image'] ?? ""),
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: dataDetail['nurse']['name'] ?? "",
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          Txt(
                            text: dataDetail['nurse']['hospital'] == null ? "" :dataDetail['nurse']['hospital']['name'],
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Cntr(
                    radius: BorderRadius.circular(5),
                    width: Get.width,
                    padding: const EdgeInsets.all(15),
                    child: Txt(text: dataDetail['nurse']['description'] ?? ""),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Cntr dataOrderNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data Order',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Kode Order',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: codeOrder,
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Pembayaran',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Image.asset(
                        controller.paymentName.value == "022"
                            ? 'assets/icon/icon_bankcimb.png'
                            : controller.paymentName.value == "014"
                                ? 'assets/icon/icon_bankbca.png'
                                : controller.paymentName.value == "002"
                                    ? 'assets/icon/bri.png'
                                    : controller.paymentName.value == "013"
                                        ? 'assets/icon/icon_bankpermata.png'
                                        : controller.paymentName.value == "503"
                                            ? "assets/icon/logo_ovo.png"
                                            : controller.paymentName.value ==
                                                    "016"
                                                ? "assets/icon/logo_maybank.png"
                                                : controller.paymentName
                                                            .value ==
                                                        "011"
                                                    ? "assets/icon/logo_danamon.png"
                                                    : controller.paymentName
                                                                    .value ==
                                                                "008" &&
                                                            controller.bankName
                                                                    .value ==
                                                                "MANDIRIATM"
                                                        ? "assets/icon/logo_mandiri.png"
                                                        : controller.paymentName
                                                                        .value ==
                                                                    "008" &&
                                                                controller
                                                                        .bankName
                                                                        .value ==
                                                                    "DANAPAY"
                                                            ? "assets/icon/logo_dana.png"
                                                            : controller.paymentName
                                                                        .value ==
                                                                    "157"
                                                                ? "assets/icon/logo_maspion.png"
                                                                : controller.paymentName
                                                                            .value ==
                                                                        "037"
                                                                    ? "assets/icon/logo_artha.png"
                                                                    : controller.paymentName.value ==
                                                                            "200"
                                                                        ? "assets/icon/logo_btn.png"
                                                                        : controller.paymentName.value ==
                                                                                "213"
                                                                            ? "assets/icon/logo_btpn.png"
                                                                            : controller.bankName.value == "SHOPEEJUMPPAY"
                                                                                ? "assets/icon/logo_shopeepay.png"
                                                                                : controller.bankName.value == "LINKAJAAPPLINK"
                                                                                    ? "assets/icon/logo_linkaja.png"
                                                                                    : 'assets/icon/bni.png',
                        height: 20,
                      ),
                      // Txt(
                      //   text: 'alah siaa',
                      //   size: 10,
                      //   weight: FontWeight.bold,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Harga',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: CurrencyFormat.convertToIdr(
                            dataDetail['totalPrice'], 0),
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Cntr dataPemesanNurse() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
          title: Txt(
            text: 'Data pemesan',
            weight: FontWeight.bold,
          ),
          children: [
            Cntr(
              color: const Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              radius: BorderRadius.circular(10),
              width: Get.width,
              child: Column(
                children: [
                  Image.network(
                    dataDetail['patient_image'],
                    height: 150,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Nama',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: dataDetail['name'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Jenis Kelamin',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: dataDetail['gender'],
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        text: 'Umur',
                        size: 12,
                        color: Colors.grey,
                      ),
                      Txt(
                        text: "${dataDetail['old']} Tahun",
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Cntr(
                    padding: const EdgeInsets.all(15),
                    height: 80,
                    width: Get.width,
                    border: Border.all(color: const Color(0xffE2E2E2)),
                    radius: BorderRadius.circular(10),
                    child: Txt(
                      text: dataDetail['description'],
                      size: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtomGradient(
                      margin: 0,
                      label: 'Lihat lokasi pasien',
                      onTap: () async {
                        await MapsLauncher.launchCoordinates(
                            Get.find<HomeController>().lat.value,
                            Get.find<HomeController>().long.value,
                            Get.find<HomeController>().address.value);
                      })
                ],
              ),
            ),
          ]),
    );
  }

  Column detailPesananDokter() {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.imageRecipe.value == ""
                    ? const SizedBox(
                        height: 1.0,
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(Resep());
                        },
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: Get.width,
                                height: 50,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    gradient: gradient1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Lihat Resep',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 7.0,
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.verified,
                //       size: 15,
                //       color: greenColor,
                //       // color: AppColor.successColor,
                //     ),
                //     const SizedBox(
                //       height: 5.0,
                //     ),
                //     const Text(
                //       " Dokter mengirimkan resep untuk anda",
                //     )
                //   ],
                // ),

                const Divider(
                  thickness: 1,
                ),

                Text(
                  'Bank Transfer',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    decoration: DottedDecoration(
                        shape: Shape.box,
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          controller.paymentName.value == "022"
                              ? 'assets/icon/icon_bankcimb.png'
                              : controller.paymentName.value == "014"
                                  ? 'assets/icon/icon_bankbca.png'
                                  : controller.paymentName.value == "002"
                                      ? 'assets/icon/bri.png'
                                      : controller.paymentName.value == "013"
                                          ? 'assets/icon/icon_bankpermata.png'
                                          : controller.paymentName.value ==
                                                  "503"
                                              ? "assets/icon/logo_ovo.png"
                                              : controller.paymentName.value ==
                                                      "016"
                                                  ? "assets/icon/logo_maybank.png"
                                                  : controller.paymentName
                                                              .value ==
                                                          "011"
                                                      ? "assets/icon/logo_danamon.png"
                                                      : controller.paymentName
                                                                      .value ==
                                                                  "008" &&
                                                              controller
                                                                      .bankName
                                                                      .value ==
                                                                  "MANDIRIATM"
                                                          ? "assets/icon/logo_mandiri.png"
                                                          : controller.paymentName
                                                                          .value ==
                                                                      "008" &&
                                                                  controller
                                                                          .bankName
                                                                          .value ==
                                                                      "DANAPAY"
                                                              ? "assets/icon/logo_dana.png"
                                                              : controller.paymentName
                                                                          .value ==
                                                                      "157"
                                                                  ? "assets/icon/logo_maspion.png"
                                                                  : controller.paymentName
                                                                              .value ==
                                                                          "037"
                                                                      ? "assets/icon/logo_artha.png"
                                                                      : controller.paymentName.value ==
                                                                              "200"
                                                                          ? "assets/icon/logo_btn.png"
                                                                          : controller.paymentName.value == "213"
                                                                              ? "assets/icon/logo_btpn.png"
                                                                              : controller.bankName.value == "SHOPEEJUMPPAY"
                                                                                  ? "assets/icon/logo_shopeepay.png"
                                                                                  : controller.bankName.value == "LINKAJAAPPLINK"
                                                                                      ? "assets/icon/logo_linkaja.png"
                                                                                      : 'assets/icon/bni.png',
                          width: 70,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Txt(
                            text: controller.paymentName.value == "022"
                                ? 'Bank CIMB'
                                : controller.paymentName.value == "014"
                                    ? 'Bank BCA'
                                    : controller.paymentName.value == "002"
                                        ? 'Bank BRI'
                                        : controller.paymentName.value == "013"
                                            ? 'Bank Permata'
                                            : controller.paymentName.value ==
                                                    "503"
                                                ? "OVO"
                                                : controller.paymentName
                                                            .value ==
                                                        "016"
                                                    ? "Bank Maybank"
                                                    : controller.paymentName
                                                                .value ==
                                                            "011"
                                                        ? "Bank Danamon"
                                                        : controller.paymentName
                                                                        .value ==
                                                                    "008" &&
                                                                controller
                                                                        .bankName
                                                                        .value ==
                                                                    "MANDIRIATM"
                                                            ? "Bank Mandiri"
                                                            : controller.paymentName
                                                                            .value ==
                                                                        "008" &&
                                                                    controller
                                                                            .bankName
                                                                            .value ==
                                                                        "DANAPAY"
                                                                ? "DANA"
                                                                : controller.paymentName
                                                                            .value ==
                                                                        "157"
                                                                    ? "Bank Maspion"
                                                                    : controller.paymentName.value ==
                                                                            "037"
                                                                        ? "Bank Artha Graha"
                                                                        : controller.paymentName.value ==
                                                                                "200"
                                                                            ? "Bank BTN"
                                                                            : controller.paymentName.value == "213"
                                                                                ? "Bank BTPN"
                                                                                : controller.bankName.value == "SHOPEEJUMPPAY"
                                                                                    ? "ShopeePay"
                                                                                    : controller.bankName.value == "LINKAJAAPPLINK"
                                                                                        ? "LinkAja"
                                                                                        : 'BANK',
                            size: 14,
                            weight: medium)
                      ],
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    iconPembayaran,
                    const SizedBox(
                      width: 5.0,
                    ),
                    statusPembayaran
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                statusOrderImage,
                rating,
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: bottomHcontainer,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: Get.width,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, -7),
                    color: Color.fromARGB(255, 182, 180, 180))
              ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kode Order',
                              style: greyTextStyle.copyWith(
                                  fontWeight: normal, fontSize: 12),
                            ),
                            Text(
                              codeOrder,
                              style: blackTextStyle.copyWith(
                                  fontWeight: bold,
                                  color: const Color(0xff555555)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tanggal Pemesanan',
                              style: greyTextStyle.copyWith(
                                  fontWeight: normal, fontSize: 12),
                            ),
                            Text(
                              DateFormat('d MMMM y, kk:mm', "id_ID")
                                  .format(DateTime.parse(tanggal)),
                              style: blackTextStyle.copyWith(
                                  fontWeight: bold,
                                  color: const Color(0xff555555)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mulai Order',
                                  style: greyTextStyle.copyWith(
                                      fontWeight: normal, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Selesai Order',
                                  style: greyTextStyle.copyWith(
                                      fontWeight: normal, fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  DateFormat('d MMMM y, kk:mm', "id_ID")
                                      .format(DateTime.parse(jamMulai)),
                                  // CurrencyFormat.convertToIdr(discount, 0),
                                  style: blackTextStyle.copyWith(
                                      fontWeight: bold,
                                      color: const Color(0xff555555)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  DateFormat('d MMMM y, kk:mm', "id_ID")
                                      .format(DateTime.parse(jamSelesai)),
                                  // CurrencyFormat.convertToIdr(discount, 0),
                                  style: blackTextStyle.copyWith(
                                      fontWeight: bold,
                                      color: const Color(0xff555555)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Harga :',
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              (CurrencyFormat.convertToIdr(totalPrice, 0)),
                              style: greenTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buttonGradient,
                  buttonGradientfinish,
                ],
              ),
            ))
      ],
    );
  }

Cntr tujuanAmbulance() {
    return Cntr(
     margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      width: Get.width,
      color: const Color(0xffF4F4F4),
      radius: BorderRadius.circular(10),
      child: ExpansionTile(
        title:  Txt(
              text: 'Tujuan Anda',
              weight: bold,
            ),
        children:[
          Padding(
            padding: const EdgeInsets.only(left :10.0, right: 10, bottom: 20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
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
          ),]
      ),
    );
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
                            margin: 20,
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

popUpJadwalPengambilanTest() {
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
                Txt(text: 'Jadwalkan Pengambilan Sampel Tes'),
                const SizedBox(
                  height: 20.0,
                ),

                Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!)),
                // dropdown below..
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.bgForm,
                      filled: true,
                      hintText: "Tipe pengambilan sample tes",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (jKelamin) => jKelamin == null
                      ? "Tipe pengambilan sample tes tidak boleh kosong"
                      : null,
                  items: controller.lokasiPengambilan
                      .map((e) => DropdownMenuItem(
                          onTap: () {
                            controller.pilihLokasi.value =
                                e.toString();
                          },
                          value: e,
                          child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),const SizedBox(
              height: 10.0,
              ),
              
              // ignore: avoid_unnecessary_containers
              InkWell(
                onTap: () {
                  // Get.defaultDialog();
                  showModalBottomSheet(
                      isDismissible: false,
                      context: Get.context!,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            controller.buildTimePickerMulai(),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Pilih Jam'),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      });
                },
                child: Cntr(
                  // padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  height: 55,
                  color: AppColor.bgForm,
                  radius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  child: ListTile(
                        leading :const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          title :
                      Obx(() => Txt(
                            text: controller.jamTerpilih.isEmpty
                                ? 'Masukkan jam'
                                : controller.jamTerpilih.value,
                            color: controller.jamTerpilih.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          )),
                          trailing :
                         const Icon(Icons.arrow_forward_ios),
                    
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
                          text: controller.tanggalJadwalAmbilTes.isEmpty
                              ? 'Masukan jadwal'
                              : controller.tanggalJadwalAmbilTes.value,
                          color: controller.tanggalJadwalAmbilTes.isEmpty
                              ? Colors.grey[500]
                              : Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtomGradient(
                  margin: 0,
                  label: 'Kirim & Lanjtukan',
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

Cntr jadwalPengambilanTes() {
    return Cntr(
      margin: const EdgeInsets.symmetric(horizontal: 24),
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
}

// ignore: must_be_immutable
class StatusImage extends StatelessWidget {
  StatusImage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  String imageUrl;
  String title;
  String subtitle;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
              onTap: onTap,
              child: Image.asset('assets/images/statusImage$imageUrl.png')),
          const SizedBox(
            height: 6.0,
          ),
          Txt(text: title, size: 14, weight: bold),
          const SizedBox(
            height: 5.0,
          ),
          Txt(
            text: subtitle,
            size: 11,
            weight: normal,
            color: greyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class InfoOrder extends StatelessWidget {
  InfoOrder({Key? key, required this.status, required this.onTap})
      : super(key: key);

  String status;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 300,
        width: 279,
        // child: Image.asset('assets/images/status0.png'),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/status$status.png'))),
      ),
    );
  }
}

// ignore: must_be_immutable
class Rating extends StatelessWidget {
  Rating({Key? key, this.rating}) : super(key: key);

  double? rating;
  final myC = Get.put(LayananHomeController());

  @override
  Widget build(BuildContext context) {
    if (Get.find<LoginController>().role.value != 'nurse' || Get.find<LoginController>().role.value != 'hospital' ) {
      myC.getOrder();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const Text('Deskripsi'),
        const SizedBox(
          height: 10,
        ),
        Obx(() => Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: greyColor!)),
            child: Text(myC.deskripsiRating.value))),
      ],
    );
  }
}

// ignore: must_be_immutable
class ListOrder extends StatelessWidget {
  final layananHomeC = Get.find<LayananHomeController>();
  ListOrder(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.colorText,
      required this.heightC,
      required this.widthC,
      required this.widht})
      : super(key: key);

  String imageUrl;
  String title;
  String subtitle;
  double widht;
  Color colorText;
  double widthC;
  double heightC;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
                height: widthC,
                width: heightC,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      imageUrl,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Image.asset(imageUrl)),
          ],
        ),
        SizedBox(
          width: widht,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(fontWeight: bold),
            ),
            Text(
              subtitle,
              style: subtitleTextStyle.copyWith(fontSize: 14, color: colorText),
            ),
            // Text(
            //   time,
            //   style: subtitleTextStyle.copyWith(
            //       fontSize: 14, color: const Color(0xff6C6C6C)),
            // )
          ],
        )
      ],
    );
  }
}

// Mengubah int ke Rupiah
class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
