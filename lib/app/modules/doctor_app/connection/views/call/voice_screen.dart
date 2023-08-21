// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../../constant/utils.dart';
import '../../../../../widget/other/show_dialog.dart';

class VoiceScreen extends StatefulWidget {
  final String userid;
  final String userName;
  final String callId;
  final int orderId;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const VoiceScreen(
      {Key? key,
      required this.userid,
      required this.userName,
      required this.callId,
      required this.orderId,
      this.data})
      : super(key: key);
  static const routeName = "/call";

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  String title = "voice_call";
  bool isDuration = false;
  bool stop = false;
  bool isWaitingDoctor = false;

  //TIMER CHAT

  int endTime = 0;
  CountdownTimerController? controller;
  @override
  void initState() {
    myC.getOrder();
    realtimeState();
    startTimer();
    updateIsStart();
    super.initState();
  }

  void updateIsStart() {
    Get.find<LayananHomeController>().updateStatusTimer(
        statusPayment:
            Get.find<LayananHomeController>().statusPayment.value + 2,
        statusOrder:
            Get.find<LayananHomeController>().statusOrderChat.value + 1);
  }

  void startTime(bool start) {
    if (start == true && endTime == 0) {
      setState(() {
        endTime = DateTime.now().millisecondsSinceEpoch +
            (1600 * Get.find<HomeController>().orderMinute.value) * 38;
        controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
      });
    }
  }
  int timeReminder = Get.find<HomeController>().orderMinute.value * 60 + 5;
  reminder(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 400,
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
                          Text(
                            'Peringatan!',
                            style: blackTextStyle.copyWith(
                                fontWeight: bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset('assets/icon/icon5menit.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          const Text(
                            'Waktu layanan anda tersisa',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            '05.00 Menit',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Oke",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                          height: 20.0,
                          ),
                        ])
                  ]));
        });
  }

  void realtimeState() {
    // ignore: prefer_const_constructors
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (myC.stop == false) {
        myC.getOrder();
      }

      if (myC.stop == false && myC.statusOrderChat.value == 2) {
        startTime(true);
        // timer.cancel();
        setState(() {
          
        timeReminder--;
        });
        if(timeReminder == 300){
          reminder(context);
        }
      } else {}
    });
  }

  stopTime() {
    // myC.stop = true;
    stop = true;
  }

  final myC = Get.put(LayananHomeController());

  void onEnd() {
    setState(() {
      isDuration = true;
    });
    showPopUp(
        onTap: () {},
        description: "Waktu layanan anda sudah habis",
        dismissible: false,
        onPress: () async {
          // myC.stopTime();
          await ZegoUIKit.instance.leaveRoom();
          Get.to(() => BottonNavigationView());
         await Get.find<LayananHomeController>()
              .updateStatus(orderId: widget.orderId, status: 6);
           Get.find<HomeController>().timePeriodic.value = false;
    Get.find<HomeController>().realtimeApiGet.value = false;
    if (Get.find<HomeController>().realtimeApiGet.isFalse) {
     await Get.find<HomeController>().realtimeApi();
    }
        });
  }

  // int endTime = DateTime.now().millisecondsSinceEpoch + 8000 * 38;
  // late CountdownTimerController controller =
  //     CountdownTimerController(endTime: endTime, onEnd: onEnd);

  // void onEnd() {
  //   setState(() {
  //     isDuration = true;
  //   });
  //   showPopUp(
  //       description: "waktu layanan anda sudah habis",
  //       dismissible: false,
  //       onPress: () {
  //         Get.back();
  //         if (widget.data != null) {
  //           // Get.find<ControllerPesanan>().updateStatus(
  //           //     status: 5,
  //           //     data: widget.data,
  //           //     idOrder: widget.data['order']['id'].toString(),
  //           //     context: context);
  //           Get.find<LayananHomeController>().updateStatus(
  //       orderId: widget.orderId,
  //         status: 5);
  //         }
  //         Get.to(() => (BottonNavigationView
  //             ));
  //       });
  // }
  //Timer waiting pasien
  // ignore: unused_field
  Timer? _timer;
  int _start = 60;
  bool stopWaiting = false;
  void startTimer() {
    if (stopWaiting == false) {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (myC.statusOrderChat.value == 2) {
            setState(() {
              timer.cancel();
            });
          } else if (_start == 0) {
            setState(() {
              timer.cancel();
            });
            showPopUp(
                color: Colors.white,
                onTap: () {
                  setState(() {
                    isWaitingDoctor = true;
                  });
                  // Get.back();
                },
                description: "Tidak ada respon dari Pasien\nUbah jadwal!",
                dismissible: false,
                onPress: () async {
                  setState(() {
                    isWaitingDoctor = true;
                  });
                  // stopTime();
                  // Get.to(() => BottonNavigationView());
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.find<LayananHomeController>()
                      .updateStatus(orderId: myC.idOrder.value, status: 99);
                });
          } else {
            setState(() {
              _start--;
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    Get.find<LayananHomeController>().addOrder();

    log("xxxxxx :$isWaitingDoctor");
    if (isWaitingDoctor == false) {
      Get.find<LayananHomeController>()
          .updateStatus(orderId: widget.orderId, status: 6);
          Get.find<HomeController>().loading.value = false;

    } else {
      Get.find<LayananHomeController>()
          .updateStatus(orderId: widget.orderId, status: 99);
    }
     Get.find<HomeController>().timePeriodic.value = false;
          Get.find<HomeController>().realtimeApiGet.value = false;
          if (Get.find<HomeController>().realtimeApiGet.isFalse) {
            Get.find<HomeController>().realtimeApi();
          }
    // controller.dispose();
    if (widget.data != null) {}

    // Get.find<ControllerPesanan>().updateStatus(status: 5,
    //     data: widget.data,
    //     idOrder: widget.data['order']['id'].toString(),
    //     context: context);

    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Service ?'),
            content: const Text('Do you want to exit an Service?'),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // controller.dispose();
                  // if (widget.data != null)
                  // {
                  await ZegoUIKit.instance.leaveRoom();

                  // Get.find<ControllerPesanan>().updateStatus(
                  //     status: 5,
                  //     data: widget.data,
                  //     idOrder: widget.data['order']['id'].toString(),
                  //     context: context);
                  Get.find<LayananHomeController>().getOrder();
                  Get.find<LayananHomeController>()
                      .updateStatus(orderId: widget.orderId, status: 6);
                   Get.find<HomeController>().timePeriodic.value = false;
    Get.find<HomeController>().realtimeApiGet.value = false;
    if (Get.find<HomeController>().realtimeApiGet.isFalse) {
     await Get.find<HomeController>().realtimeApi();
    }
                  Get.back();
                  Get.back();
                  Get.back();

                  // }
                  // await ZegoUIKit.instance.leaveRoom();

                  // Get.offAll(() => BottonNavigationView());
                },
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Stack(
          children: [
            ZegoUIKitPrebuiltCall(
              appID: Utils()
                  .getAppId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
              appSign: Utils()
                  .getAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
              userID: widget.userid,
              userName: widget.userName,
              callID: widget.callId,
              // Modify your custom configurations here.
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
                ..bottomMenuBarConfig
                ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(),
            ),
            Obx(
              () =>
                  // Visibility(
                  //   visible: endTime != 0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //         height: 50,
                  //         width: 150,
                  //         decoration: BoxDecoration(
                  //             color: AppColor.bodyColor.shade400,
                  //             borderRadius: BorderRadius.circular(8)),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child:
                  myC.statusOrderChat.value == 2
                      ? endTime == 0
                          ? const SizedBox(
                              height: 1.0,
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 160,
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  CountdownTimer(
                                    endWidget: const Text('Waktu Habis'),
                                    controller: controller,
                                    onEnd: onEnd,
                                    endTime: endTime,
                                  ),
                                ],
                              ),
                            )
                      : myC.statusOrderChat.value == 1
                          ? Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              height: 50,
                              width: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: AutoSizeText(
                                        maxLines: 2,
                                        _start >= 10
                                            ? "Menunggu Pasien 00:${_start}"
                                            : "Menunggu Pasien 00:0${_start}",
                                        style: const TextStyle(fontSize: 12)),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 1.0,
                            ),
            ),
          ],
        ),
      ),
    ));
  }
}
