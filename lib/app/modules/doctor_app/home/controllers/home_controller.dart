// ignore_for_file: unused_field, prefer_final_fields, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bionmed/app/constant/string.dart';
import 'package:bionmed/app/constant/url.dart';
import 'package:bionmed/app/modules/doctor_app/chat/views/chat_dokter.dart';
import 'package:bionmed/app/modules/doctor_app/connection/views/call/voice_screen.dart';
import 'package:bionmed/app/modules/doctor_app/connection/views/videocall_screen.dart';
import 'package:bionmed/app/modules/doctor_app/detail/controllers/detail_controller.dart';
import 'package:bionmed/app/modules/doctor_app/layanan_home/controllers/layanan_home_controller.dart';
import 'package:bionmed/app/modules/doctor_app/login/controllers/login_controller.dart';
import 'package:bionmed/app/routes/app_pages.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zego_zimkit/services/services.dart';

class HomeController extends GetxController {
  final groupIDController = TextEditingController();

  final box = GetStorage();
  final assetsAudioPlayer = AssetsAudioPlayer();
  RxBool timePeriodic = false.obs;
  RxBool willPopUp = false.obs;
  RxBool reminderNurse = false.obs;
  RxString layanan1 = "".obs;
  RxInt orderMinute = 0.obs;
  String url = 'assets/COMTelph_Phone ring 5 (ID 0375)_BSB.wav';
  RxBool loading = false.obs;
  RxInt timerLoading = 10.obs;
  RxInt statusOrderDetail = 0.obs;
  RxBool realtimeApiGet = true.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxString address = "".obs;
  RxList dataBanner = [].obs;
  RxInt pendapatan = 0.obs;
  RxString imageCostomer = ''.obs;

  notif() {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 10, channelKey: 'basic_channel', title: "Layanan Akan Segera Dimulah",  ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Peringatan!',
            body: 'Mengingat waktu untuk pesanan\nakan berlangsung 3 Jam lagi',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  notifPesananMasukNurse() {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 10, channelKey: 'basic_channel', title: "Layanan Akan Segera Dimulah",  ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Pesanan Masuk!',
            body: 'Lihat Detail!',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  notifLayanan() {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id: 10, channelKey: 'basic_channel', title: "Layanan Akan Segera Dimulah",  ));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Peringatan!',
            body:
                'Mengingat waktu untuk pesanan\nakan berlangsung 5 Menit lagi',
            actionType: ActionType.Default,
            wakeUpScreen: true));
  }

  Future<void> showCallkitIncoming({
    required String uuid,
    required Function() onTap,
    required String nameCaller,
    required String nameOrder,
    required String image,
    required StreamSubscription callIncoming,
  }) async {
    final params = CallKitParams(
      id: uuid,
      nameCaller: nameOrder,
      appName: 'Callkit',
      avatar: image,
      handle: nameCaller,
      type: 0,
      duration: 60000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      // textMissedCall: 'Missed call',
      // textCallback: 'Call back',
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        // isShowCallback: true,
        // isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    callIncoming;
  }

  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerLoading == 0) {
          loading.value = false;
          timer.cancel();
        } else {
          timerLoading.value--;
        }
      },
    );
  }

  void playRingtone() async {
    await assetsAudioPlayer.open(Audio(url));
    assetsAudioPlayer.play();
  }

  void stopRingtone() {
    assetsAudioPlayer.stop();
  }

  getOrder() {
    Get.find<LayananHomeController>().getOrder();
  }

  Future<dynamic> reminderKesiapan() async {
    final params = <String, dynamic>{
      "lat": Get.find<LoginController>().lat.value,
      "long": Get.find<LoginController>().long.value
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/reminder/order/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      final order = json.decode(result.toString());

      if (order['code'] == 200) {
        notif();
        reminder(Get.context!);
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> getBanner() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient()
          .request('${MainUrl.urlApi}banner', Method.GET, params);
      final banner = json.decode(result.toString());
      dataBanner.value = banner['data'];
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> getDetailDoctor() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/${Get.find<LoginController>().idLogin}',
          Method.GET,
          params);
      final detailDoctor = json.decode(result.toString());
      pendapatan.value = detailDoctor['data']['balance'];
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  Future<dynamic> getDetailNurse() async {
    final params = <String, dynamic>{
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/detail/${Get.find<LoginController>().idLogin}',
          Method.GET,
          params);
      final detailDoctor = json.decode(result.toString());
      pendapatan.value = detailDoctor['data']['balance'] ?? 0;

      // ignore: avoid_print
      print('saldo   $pendapatan');
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }

  RxInt statusCode = 0.obs;
  RxInt nurseReceiveStatus = 0.obs;
  RxMap dataReminderNurse = {}.obs;

  Future<dynamic> reminderKesiapanLayanan() async {
    final params = <String, dynamic>{
      "lat": Get.find<LoginController>().lat.value,
      "long": Get.find<LoginController>().long.value
      // "serviceId": serviceId,
    };

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}doctor/reminder/order/telemedicine/${Get.find<LoginController>().idLogin}',
          Method.POST,
          params);
      final order = json.decode(result.toString());
      statusCode.value = order['code'];

      if (order['code'] == 200) {
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      // ignore: avoid_print
      print('zaee $e');
    }
  }

  Future<dynamic> reminderOrderNurse() async {
    final params = <String, dynamic>{};

    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}nurse/catch/order/${Get.find<LoginController>().idLogin}',
          Method.GET,
          params);
      final order = json.decode(result.toString());
      if (order['code'] == 200) {
        statusCode.value = order['code'];
        nurseReceiveStatus.value = order['data']['nurse_receive_status'];
        dataReminderNurse.value = order['data'];
        log('zeen $order');
      } else {
        // dataReminderNurse.clear();
      }

      if (dataReminderNurse['nurse_receive_status'] == 0) {
        // dataListOrder.value = order['data'];
        // statusOrder.value = order['data']['order']['statusOrder'];
      } else {
        // dataListOrder.clear();
      }
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {
      dataReminderNurse['nurse_receive_status'] = 1;

      // ignore: avoid_print
      print('zeenhaha $e');
    }
  }

  Future<dynamic> automaticUpdateStatus() async {
    final params = <String, dynamic>{};
    try {
      final result = await RestClient().request(
          '${MainUrl.urlApi}cron/automatic/update/status/order',
          Method.GET,
          params);
      final statusUpdate = json.decode(result.toString());
      log('zeen$statusUpdate');
    } on Exception catch (e) {
      // ignore: avoid_print
      print("ERROR NIH ==  $e");
    }
  }

  trimUpdateStatus() {
    Timer.periodic(const Duration(seconds: 60), (timer) async {
      await automaticUpdateStatus();
    });
  }

  realtimeApi() {
    if (timePeriodic.value == false) {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        if (Get.find<LoginController>().role.value == 'nurse') {
          await Get.find<LayananHomeController>().listOrderNurse();
          if (reminderNurse.isFalse) {
            await reminderOrderNurse();
            if (dataReminderNurse['nurse_receive_status'] == 0 &&
                reminderNurse.isFalse) {
              notifPesananMasukNurse();
              Get.toNamed(Routes.PESANAN_MASUK_PERAWAT);
            }
          }
          getDetailNurse();
        } else {
          await Get.find<LayananHomeController>().addOrder();
          await Get.find<LayananHomeController>().orderListToday();
          // Get.find<LayananHomeController>().getOrder();

          reminderKesiapan();
          reminderKesiapanLayanan();
          if (statusCode.value == 200) {
            if (willPopUp.isFalse) {
              // ignore: prefer_const_constructors
              Future.delayed(Duration(seconds: 3)).then(
                (value) {
                  notifLayanan();
                  reminderLayanan(Get.context!);
                  willPopUp.value = true;
                },
              );
            }
            statusCode.value = 0;
          } else {
            willPopUp.value = false;
            statusCode.value = 0;
          }

          getDetailDoctor();
          for (int i = 0;
              i < Get.find<LayananHomeController>().dataListOrder.length;
              i++) {
            if (Get.find<LayananHomeController>().dataListOrder[i]['order']
                        ['statusOrder'] ==
                    1 &&
                Get.find<LayananHomeController>().dataListOrder[i]['order']
                        ['statusPayment'] ==
                    1) {
              if (Get.find<LayananHomeController>().dataListOrder[i]['order']
                      ['service_price']['name'] ==
                  'Layanan Chat') {
                final userIDController = TextEditingController(
                    text: Get.find<LayananHomeController>()
                        .dataListOrder[i]['order']['customer']['userId']
                        .toString());

                timePeriodic.value = true;
                showCallkitIncoming(
                    image:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['image']}",
                    nameCaller: "Panggilan Layanan Chat",
                    nameOrder:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['name']}",
                    onTap: () {
                      Get.defaultDialog();
                    },
                    uuid: "1",
                    callIncoming:
                        FlutterCallkitIncoming.onEvent.listen((event) async {
                      switch (event!.event) {
                        case Event.actionCallIncoming:
                          break;
                        case Event.actionCallStart:
                          break;
                        case Event.actionCallAccept:
                          // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                          orderMinute.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['service_price']['minute'];
                          // ignore: unused_local_variable
                          var dataLayanan = Get.find<LayananHomeController>()
                              .dataListOrder[i]['order']['status'];
                          // ignore: unused_local_variable
                          var dataService = Get.find<LayananHomeController>()
                              .dataListOrder[i]['order']['service']['name'];
                          Get.find<LayananHomeController>().idOrder.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['id'];
                          await Get.find<LayananHomeController>().getOrder();
                          // ignore: use_build_context_synchronously,
                          // ZIMKit().showDefaultNewPeerChatDialogChat(
                          //   Get.context!,
                          //   Get.find<LayananHomeController>()
                          //       .dataListOrder[i]['order']['customer']['userId']
                          //       .toString(),
                          // );
                          // await Get.find<LayananHomeController>()
                          //     .updateStatusTimer(
                          //         statusPayment: Get.find<LayananHomeController>()
                          //                 .statusPayment.value +
                          //             2,
                          //         statusOrder: Get.find<LayananHomeController>()
                          //             .statusOrderChat.value + 1);
                          // await Get.find<LayananHomeController>()
                          //     .updateStatusTimer(
                          //         statusPayment: Get.find<LayananHomeController>()
                          //                 .statusPayment
                          //                 .value +
                          //             2,
                          //         statusOrder: Get.find<LayananHomeController>()
                          //                 .statusOrderChat
                          //                 .value +
                          //             1);
                          //  await Get.find<LayananHomeController>()
                          //     .updateStatusTimer(
                          //         statusPayment: Get.find<LayananHomeController>()
                          //                 .statusPayment
                          //                 .value +
                          //             2,
                          //         statusOrder: Get.find<LayananHomeController>()
                          //                 .statusOrderChat
                          //                 .value +
                          //             1);
                          Get.put(DetailController()).paymentName.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ["payment"]['product_code'];
                          //     if (userIDController.text
                          //     .isNotEmpty) {
                          //       print("CEK CEK CEK");
                          await ZIMKit().connectUser(
                            // ignore: prefer_interpolation_to_compose_strings
                            id: Get.find<LayananHomeController>()
                                .dataListOrder[i]['order']['doctor']['userId']
                                .toString(),
                          );
                          // ZIMKit().showDefaultNewPeerChatDialogChat(
                          //     Get.context!,
                          //     Get.find<LayananHomeController>().dataListOrder[i]['order']
                          //             ['customer']['userId']
                          //         .toString(),
                          //   );
                          Get.to(() => ZIMKitMessageListPageChat(
                                conversationID: userIDController.text,
                              ));
                          // }

                          // Get.to(
                          //   () => navigationDetailOrder(dataLayanan, dataService,
                          //       i, Get.context!, layanan),
                          // );
                          // timePeriodic.value = false;
                          // realtimeApiGet.value = false;
                          // if (realtimeApiGet.isFalse) {
                          //   realtimeApi();
                          // }

                          break;
                        case Event.actionCallDecline:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }

                          // Get.defaultDialog(title: 'HAHAHAH MANTAP');

                          break;
                        case Event.actionCallEnded:
                          break;
                        case Event.actionCallTimeout:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }
                          break;
                        // case Event.ACTION_CALL_CALLBACK:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_HOLD:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_MUTE:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_DMTF:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_GROUP:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                        //   break;
                        // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                        //   break;
                        case Event.actionDidUpdateDevicePushTokenVoip:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCallback:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleHold:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleMute:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleDmtf:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleGroup:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleAudioSession:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCustom:
                          // TODO: Handle this case.
                          break;
                      }
                    }));
              } else if (Get.find<LayananHomeController>().dataListOrder[i]
                      ['order']['service_price']['name'] ==
                  'Layanan Telephone') {
                timePeriodic.value = true;
                showCallkitIncoming(
                    image:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['image']}",
                    nameCaller: "Panggilan Layanan Telephone",
                    nameOrder:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['name']}",
                    onTap: () {
                      Get.defaultDialog();
                    },
                    uuid: "1",
                    callIncoming:
                        FlutterCallkitIncoming.onEvent.listen((event) async {
                      switch (event!.event) {
                        case Event.actionCallIncoming:
                          break;
                        case Event.actionCallStart:
                          break;
                        case Event.actionCallAccept:
                          // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                          orderMinute.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['service_price']['minute'];
                          Get.find<LayananHomeController>().idOrder.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['id'];
                          Get.find<LayananHomeController>().startTime();
                          await Get.find<LayananHomeController>().getOrder();
                          await Get.find<LayananHomeController>()
                              .updateStatusTimer(
                                  statusPayment:
                                      Get.find<LayananHomeController>()
                                              .statusPayment
                                              .value +
                                          2,
                                  statusOrder: Get.find<LayananHomeController>()
                                          .statusOrderChat
                                          .value +
                                      1);
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 4);
                          Get.to(VoiceScreen(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              userid: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['doctor']['userId']
                                  .toString(),
                              userName: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['doctor']['name'],
                              callId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id']
                                  .toString()));
                          break;
                        case Event.actionCallDecline:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }
                          // Get.defaultDialog(title: 'HAHAHAH MANTAP');

                          break;
                        case Event.actionCallEnded:
                          break;
                        case Event.actionCallTimeout:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }
                          break;
                        // case Event.ACTION_CALL_CALLBACK:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_HOLD:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_MUTE:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_DMTF:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_GROUP:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                        //   break;
                        // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                        //   break;
                        case Event.actionDidUpdateDevicePushTokenVoip:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCallback:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleHold:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleMute:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleDmtf:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleGroup:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleAudioSession:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCustom:
                          // TODO: Handle this case.
                          break;
                      }
                    }));
              } else if (Get.find<LayananHomeController>().dataListOrder[i]
                      ['order']['service_price']['name'] ==
                  'Layanan Video Call') {
                timePeriodic.value = true;
                showCallkitIncoming(
                    image:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['image']}",
                    nameCaller: "Panggilan Layanan Video Call",
                    nameOrder:
                        "${Get.find<LayananHomeController>().dataListOrder[i]['order']['customer']['name']}",
                    onTap: () {
                      Get.defaultDialog();
                    },
                    uuid: "1",
                    callIncoming:
                        FlutterCallkitIncoming.onEvent.listen((event) async {
                      switch (event!.event) {
                        case Event.actionCallIncoming:
                          break;
                        case Event.actionCallStart:
                          break;
                        case Event.actionCallAccept:
                          // Get.defaultDialog(title: 'HAHAHAH MANTAP COY');
                          orderMinute.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['service_price']['minute'];
                          Get.find<LayananHomeController>().idOrder.value =
                              Get.find<LayananHomeController>().dataListOrder[i]
                                  ['order']['id'];
                          Get.find<LayananHomeController>().startTime();
                          await Get.find<LayananHomeController>().getOrder();
                          await Get.find<LayananHomeController>()
                              .updateStatusTimer(
                                  statusPayment:
                                      Get.find<LayananHomeController>()
                                              .statusPayment
                                              .value +
                                          2,
                                  statusOrder: Get.find<LayananHomeController>()
                                          .statusOrderChat
                                          .value +
                                      1);
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 4);
                          Get.to(VideoCallService(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              userid: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['doctor']['userId']
                                  .toString(),
                              userName: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['doctor']['name'],
                              callId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id']
                                  .toString()));
                          break;
                        case Event.actionCallDecline:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }
                          // Get.defaultDialog(title: 'HAHAHAH MANTAP');

                          break;
                        case Event.actionCallEnded:
                          break;
                        case Event.actionCallTimeout:
                          Get.find<LayananHomeController>().updateStatus(
                              orderId: Get.find<LayananHomeController>()
                                  .dataListOrder[i]['order']['id'],
                              status: 99);
                          timePeriodic.value = false;
                          realtimeApiGet.value = false;
                          if (realtimeApiGet.isFalse) {
                            realtimeApi();
                          }
                          break;
                        // case Event.ACTION_CALL_CALLBACK:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_HOLD:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_MUTE:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_DMTF:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_GROUP:
                        //   break;
                        // case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
                        //   break;
                        // case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
                        //   break;
                        case Event.actionDidUpdateDevicePushTokenVoip:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCallback:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleHold:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleMute:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleDmtf:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleGroup:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallToggleAudioSession:
                          // TODO: Handle this case.
                          break;
                        case Event.actionCallCustom:
                          // TODO: Handle this case.
                          break;
                      }
                    }));
              }
            }

            //POP UP PANGGILAN MASUK

          }
          if (timePeriodic == true) {
            timer.cancel();
          }
        }
      });
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // ignore: unused_local_variable
    var phone = await box.read('phone');

    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 2), () async {
      getDetailDoctor();
      getBanner();

      // await Get.find<LayananHomeController>().addOrder();
      Get.lazyPut(() => LayananHomeController());

      //Get ORDER ID and RINGING
      for (var i = 0;
          i < Get.find<LayananHomeController>().dataListOrder.length;
          i++) {
        // ignore: avoid_print
        // ignore: prefer_interpolation_to_compose_strings
      }
      timePeriodic.value = false;
      // await realtimeApi();
      // await trimUpdateStatus();
    });
  }

  //POP UP LENGKAPI PROFIL

  // ignore: prefer_typing_uninitialized_variables
  var dataUser;
  Future<dynamic> reminder(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 350,
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
                          Image.asset('assets/icon/icon_reminder.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Mengingat waktu untuk pesanan\nakan berlangsung 3 Jam lagi',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Oke",
                            onTap: () {
                              Get.back();
                            },
                          )
                        ])
                  ]));
        });
  }

  Future<dynamic> reminderLayanan(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
              height: 350,
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
                          Image.asset('assets/icon/icon_reminder.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'Mengingat waktu untuk pesanan\nakan berlangsung 5 Menit lagi',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtomGradient(
                            label: "Oke",
                            onTap: () {
                              Get.back();
                            },
                          )
                        ])
                  ]));
        });
  }
}
