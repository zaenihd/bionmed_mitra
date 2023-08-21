import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/modules/doctor_app/chat/views/catatan_docter_view.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorC,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25),
            width: Get.width,
            height: 130,
            decoration: const BoxDecoration(gradient: AppColor.gradient2),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){Get.back();},
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xffE3E3E3),
                                  ),
                                  // image: DecorationImage(image: AssetImage('assets/images/doctor1.png'),fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 1.5, top: 1.5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: blueColor!),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/kevin.png'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Septio Dwi',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: medium),
                            ),
                            Text(
                              'Pasien',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 12, fontWeight: normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: Text(
                    '00:05:00',
                    style: whiteTextStyle.copyWith(fontWeight: bold),
                  ))
                ],
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 125,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(4, 8),
                              color: Color.fromARGB(255, 225, 223, 223))
                        ],
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset('assets/icon/icon_logo.png'),
                              Text(
                                'Selamat datang di Boinmed !',
                                style: blackTextStyle.copyWith(
                                    fontWeight: medium, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color(0xffF8F8F8),
                        ),
                        Container(
                            margin: const EdgeInsets.all(12),
                            child: Text(
                              'Hallo Dokter, Bantu pasien berkonsultasi semoga\ndokter bisa membantu dan memberi solusi atau\narahan.',
                              style: greyTextStyle.copyWith(fontSize: 12),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  const Chats(
                    isSender: true,
                    msg:
                        "Hallo, Selamat siang juga dok saya mau konsultasi tentang Paru-paru dok?",
                    time: 'a',
                  ),
                  const Chats(
                    isSender: false,
                    msg:
                        "Hallo, Selamat siang Septio dwi ! ada yang bisa saya bantu?...18.10",
                    time: 'a',
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      // Ini Bagian Kirim Pesan

      // bottomSheet: 
      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      //               height: 60,
      //               width: Get.width,
      //               decoration: BoxDecoration(boxShadow: const [
      //                 BoxShadow(
      //                     spreadRadius: 1,
      //                     blurRadius: 10,
      //                     offset: Offset(4, 8),
      //                     color: Color.fromARGB(255, 225, 223, 223))
      //               ], borderRadius: BorderRadius.circular(100)),
      //               child: TextField(
      //                 decoration: InputDecoration(
      //                     border: OutlineInputBorder(
      //                       borderSide: BorderSide.none,
      //                         borderRadius: BorderRadius.circular(100)),
      //                     fillColor: whiteColor,
      //                     filled: true,
      //                     prefixIcon: Image.asset('assets/icon/icon_addmedia.png'),
      //                     suffixIcon: Container(
      //                       margin: EdgeInsets.only(right: 11, top: 2),
      //                       width: 45, height: 45,
      //                     child: Image.asset('assets/icon/icon_send.png'),
      //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), gradient: gradient1),),
      //                     hintText: 'Kirim pesan...',
      //                     hintStyle: GoogleFonts.ubuntu(color: Color(0xffCBCBCB))
      //                     ),
      //               ),
      //             ),

      // Ini bagian Rekomendasi Obat

      bottomSheet: InkWell(
        onTap: (){Get.to(()=> CatatanDocter());},
        child: Container(
          alignment: Alignment.center,
          height: 45,
          width: Get.width,
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: AppColor.gradient2,),
          child: Text('Rekomendasikan', style: whiteTextStyle.copyWith(fontWeight: bold),),
        ),
      ),

      //Ini bagian Cek Hasil Konsultasi

      // bottomSheet: Container(
      //   alignment: Alignment.center,
      //   height: 45,
      //   width: Get.width,
      //   margin: EdgeInsets.all(24),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(6),
      //     gradient: gradient2,),
      //   child: ListTile(leading: Image.asset('assets/icon/icon_catatan.png'),
      //   title: Text('Lihat catatan dokter hasil konsultasi', style: whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium),),
      //   trailing: Icon(Icons.arrow_forward_ios_outlined, color: whiteColor, size: 10,),),),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats(
      {Key? key, required this.isSender, required this.msg, required this.time})
      : super(key: key);

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: isSender == false
                ? const BoxDecoration(
                    gradient: AppColor.gradient2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                     bottomRight : Radius.circular(10),
                    ))
                : const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Color(0xffF2F2F2)),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  msg,
                  style: whiteTextStyle.copyWith(
                      fontSize: 12, color: isSender ? blackColor : whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat.jm()
                      .format(DateTime.parse(DateTime.now().toIso8601String())),
                  style: whiteTextStyle.copyWith(
                      fontSize: 11,
                      color: isSender ? const Color(0xff555555) : whiteColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
