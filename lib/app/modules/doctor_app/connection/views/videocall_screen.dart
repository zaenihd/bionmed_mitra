// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../../theme.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/utils.dart';
import '../../../../widget/other/show_dialog.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';

class VideoCallService extends StatefulWidget {
  final String userid;
  final String userName;
  final String callId;
  final int orderId;
  final data;

  const VideoCallService(
      {Key? key,
      required this.userid,
      required this.userName,
      required this.callId,
      required this.orderId,
      this.data})
      : super(key: key);
  static const routeName = "/call";

  @override
  State<VideoCallService> createState() => _CallScreenState();
}

class _CallScreenState extends State<VideoCallService> {
  //TIMER CHAT

  bool isDuration = false;
  int endTime = 0;
  CountdownTimerController? controller;
  String title = "call";
  bool stop = false;
  bool isWaitingDoctor = false;

  @override
  void initState() {
    myC.getOrder();
    realtimeState();
    startTimer();
    updateIsStart();
    // tenMinuteLeft();
    super.initState();
  }

  void updateIsStart() {
    Get.find<LayananHomeController>().updateStatusTimer(
        statusPayment:
            Get.find<LayananHomeController>().statusPayment.value + 2,
        statusOrder:
            Get.find<LayananHomeController>().statusOrderChat.value + 1);
  }

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
      // Get.find<HomeController>().loading.value = false;
    }
    Get.find<HomeController>().timePeriodic.value = false;
    Get.find<HomeController>().realtimeApiGet.value = false;
    if (Get.find<HomeController>().realtimeApiGet.isFalse) {
      Get.find<HomeController>().realtimeApi();
    }
    // Get.find<HomeController>().timePeriodic.value = false;
    //       Get.find<HomeController>().realtimeApiGet.value = false;
    //       if (Get.find<HomeController>().realtimeApiGet.isFalse) {
    //         Get.find<HomeController>().realtimeApi();
    //       }
    // controller.dispose();
    if (widget.data != null) {}

    // Get.find<ControllerPesanan>().updateStatus(status: 5,
    //     data: widget.data,
    //     idOrder: widget.data['order']['id'].toString(),x
    //     context: context);

    super.dispose();
  }

  int endTime1 = 0;
  CountdownTimerController? controller1;
  CurrentRemainingTime time1 = CurrentRemainingTime();

  // tenMinuteLeft() {
  //   // time1 = controller
  //   // if(time1.min == 10 ){

  //   // print("CEKKKK BISA CUY");
  //   // }
  //   // setState(() {
  //   //   endTime1 = DateTime.now().millisecondsSinceEpoch + (1600 * 10) * 38;
  //   //   controller1 = CountdownTimerController(endTime: endTime1);
  //   // });
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     print("UHUY" + time1.min.toString());
  //   });
  // }

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
        setState(() {
          
        timeReminder--;
        });
        if(timeReminder == 300){
          reminder(context);
        }

        // timer.cancel();
      } else {}
    });
  }

  stopTime() {
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
          // stopTime();
          await ZegoUIKit.instance.leaveRoom();
          Get.to(() => BottonNavigationView());
          Get.find<LayananHomeController>()
              .updateStatus(orderId: widget.orderId, status: 6);
          Get.find<HomeController>().timePeriodic.value = false;
          Get.find<HomeController>().realtimeApiGet.value = false;
          if (Get.find<HomeController>().realtimeApiGet.isFalse) {
            await Get.find<HomeController>().realtimeApi();
          }
        });
  }

  // void onEnd() {
  //   setState(() {
  //     isDuration = true;
  //   });
  //   showPopUp(
  //       description: "waktu layanan anda sudah habis",
  //       dismissible: false,
  //       onPress: () {
  //         Get.to(BottonNavigationView());
  //         controller.dispose();
  //           Get.find<LayananHomeController>().updateStatus(
  //       orderId: widget.orderId,
  //         status: 5);

  //         Get.to(BottonNavigationView());

  //       });
  // }

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
                onPressed: () {
                  Get.back();
                },
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ZegoUIKit.instance.leaveRoom();

                  Get.find<LayananHomeController>().getOrder();
                  Get.find<LayananHomeController>()
                      .updateStatus(orderId: widget.orderId, status: 6);
                  Get.find<HomeController>().timePeriodic.value = false;
                  Get.find<HomeController>().realtimeApiGet.value = false;
                  if (Get.find<HomeController>().realtimeApiGet.isFalse) {
                    await Get.find<HomeController>().realtimeApi();
                  }

                  // Get.to(BottonNavigationView());
                  Get.back();
                  Get.back();
                  Get.back();
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
              // ZegoUIKitPrebuiltCallWithInvitation(appID:  Utils().getAppId,
              // appSign: Utils()
              //       .getAppSign,
              // userID: widget.userid,
              // userName: widget.userName,
              // child: Container(),
              // plugins: [ZegoUIKitSignalingPlugin()
              // ]),
              ZegoUIKitPrebuiltCall(
                appID: Utils()
                    .getAppId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign: Utils()
                    .getAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: widget.userid,
                userName: widget.userName,
                callID: widget.callId,
                config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  ..topMenuBarConfig = ZegoTopMenuBarConfig(isVisible: false)
                  ..turnOnCameraWhenJoining = true
                  ..turnOnMicrophoneWhenJoining = true
                  ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
                    backgroundBuilder: (BuildContext context, Size size,
                        ZegoUIKitUser? user, Map extraInfo) {
                      return user != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    color: AppColor.bodyColor.shade400,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const SizedBox(
                                  height: 1.0,
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  )
                  ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
                    backgroundBuilder: (BuildContext context, Size size,
                        ZegoUIKitUser? user, Map extraInfo) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: AppColor.bodyColor.shade400,
                              borderRadius: BorderRadius.circular(8)),
                          child: const SizedBox(
                            height: 1.0,
                          ),
                        ),
                      );
                    },
                  )
                  ..layout = ZegoLayout.pictureInPicture(
                    isSmallViewDraggable: true,
                    switchLargeOrSmallViewByClick: true,
                  ),
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
                            : Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 160,
                                    margin: const EdgeInsets.all(10),
                                    // ignore: prefer_const_constructors
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: prefer_const_constructors
                                        Icon(
                                          Icons.timer,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        CountdownTimer(
                                          // widgetBuilder: (context, time1) {
                                          //   if(time1 != null){

                                          //   return Text(
                                          //     time1.min! >= 10 ?
                                          //       '${time1.min} : ${time1.sec}' : time1.sec! >= 10 ? '0${time1.min} : ${time1.sec}' : '0${time1.min} : 0${time1.sec}' );
                                          //   }
                                          //   return const SizedBox(
                                          //   height: 1.0,
                                          //   );
                                          // },
                                          endWidget: const Text('Waktu Habis'),
                                          controller: controller,
                                          onEnd: onEnd,
                                          endTime: endTime,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   height: 100,
                                  //   padding: const EdgeInsets.all(10),
                                  //   margin: const EdgeInsets.all(10),
                                  //   // ignore: prefer_const_constructors
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(12.0),
                                  //     ),
                                  //   ),
                                  //   child: CountdownTimer(
                                  //     // widgetBuilder: (context, time1) {
                                  //     //   if (time1!.min == 5 &&
                                  //     //           time1.sec == 00 ||
                                  //     //       time1.min == 4 && time1.sec == 59 ||
                                  //     //       time1.min == 4 && time1.sec == 58 ||
                                  //     //       time1.min == 4 && time1.sec == 57 ||
                                  //     //       time1.min == 4 && time1.sec == 56 ||
                                  //     //       time1.min == 4 && time1.sec == 55 ||
                                  //     //       time1.min == 4 && time1.sec == 54 ||
                                  //     //       time1.min == 4 && time1.sec == 53 ||
                                  //     //       time1.min == 4 && time1.sec == 52 ||
                                  //     //       time1.min == 4 && time1.sec == 51 ||
                                  //     //       time1.min == 4 && time1.sec == 50) {
                                  //     //     return Container(
                                  //     //         alignment: Alignment.center,
                                  //     //         padding: const EdgeInsets.all(10),
                                  //     //         // margin: const EdgeInsets.all(10),
                                  //     //         // ignore: prefer_const_constructors
                                  //     //         decoration: BoxDecoration(
                                  //     //           gradient: AppColor.gradient1,
                                  //     //           borderRadius:
                                  //     //               const BorderRadius.all(
                                  //     //             Radius.circular(12.0),
                                  //     //           ),
                                  //     //         ),
                                  //     //         child: const Text(
                                  //     //           'Waktu Layanan Anda\nTersisa 5 Menit lagi',
                                  //     //           style: TextStyle(
                                  //     //               color: Colors.white,
                                  //     //               fontSize: 15,
                                  //     //               fontWeight: FontWeight.w600
                                  //     //               // fontWeight: FontWeight.w500,
                                  //     //               ),
                                  //     //           textAlign: TextAlign.center,
                                  //     //         ));
                                  //     //   }
                                  //     //   return const SizedBox(
                                  //     //     height: 1.0,
                                  //     //   );
                                  //     // },
                                  //     endWidget: const Text('Waktu Habis'),
                                  //     controller: controller,
                                  //     endTime: endTime,
                                  //   ),
                                  // ),
                                ],
                              )
                        : myC.statusOrderChat.value == 1
                            ? Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                height: 50,
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Icon(
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
      ),
    );
  }
}
