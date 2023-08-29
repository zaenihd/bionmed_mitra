import 'package:bionmed/app/constant/colors.dart';
import 'package:bionmed/app/widget/button/button_primary_withtext.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MenungguKonfirmasi extends StatelessWidget {
  MenungguKonfirmasi({super.key});
  final Uri whatsapp = Uri.parse('https://wa.me/6282147738240');

  sendEmail() async {
    final Email email = Email(
      body: 'Test kirim email',
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
    return Scaffold(
      bottomSheet: actionLaporkan(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/menunggu.png'),
          const SizedBox(
            height: 50.0,
          ),
          Txt(
            text: 'Menunggu konfirmasi',
            size: 24,
            weight: bold,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Txt(
            text:
                'Mohon tunggu konfirmasi, Selanjutnya kami akan mengirimkan notifikasi untuk anda',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Padding actionLaporkan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ButtonPrimary(
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
                    const Text('Hubungi CS Bionmed'),
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
        title: "Hubungi CS Bionmed?",
        color: Colors.red,
        backgroundColor: const Color(0xffFFE4E4),
      ),
    );
  }
}
