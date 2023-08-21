// // import 'package:flutter/material.dart';
// // import 'package:flutter_callkit_incoming/entities/android_params.dart';
// // import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// // import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'dart:async';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_callkit_incoming/entities/android_params.dart';
// import 'package:flutter_callkit_incoming/entities/call_event.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'package:get/get.dart';


// class IncomingCall extends StatefulWidget {
//   const IncomingCall({super.key});

//   @override
//   State<IncomingCall> createState() => _IncomingCallState();
// }

// class _IncomingCallState extends State<IncomingCall> {
//   @override
//   void initState() {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });

//     super.initState();
//   }

//   notif() {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: 10, channelKey: 'basic_channel', title: "HALOOO"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Incoming Call')),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               child: const Text('PANGGILAN MASUK'),
//               onPressed: () async {
//                 showCallkitIncoming('12');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ZegoUIKitPrebuiltCallInvitationConfig {}

// Future<void> showCallkitIncoming(String uuid) async {
//   final params = CallKitParams(
//     id: uuid,
//     nameCaller: 'Zaeni Hilman',
//     appName: 'Callkit',
//     avatar: 'https://i.pravatar.cc/100',
//     handle: '0123456789',
//     type: 0,
//     duration: 60000.0,
//     textAccept: 'Accept',
//     textDecline: 'Decline',
//     textMissedCall: 'Missed call',
//     textCallback: 'Call back',
//     extra: <String, dynamic>{'userId': '1a2b3c4d'},
//     headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
//     android: const AndroidParams(
      
//       isCustomNotification: true,
//       isShowLogo: false,
//       isShowCallback: true,
//       isShowMissedCallNotification: true,
//       ringtonePath: 'system_ringtone_default',
//       backgroundColor: '#0955fa',
//       backgroundUrl: 'assets/test.png',
//       actionColor: '#4CAF50',
//     ),
//   );
//   await FlutterCallkitIncoming.showCallkitIncoming(params);
//    FlutterCallkitIncoming.onEvent.listen((event) {
//     switch (event!.event) {
//       case Event.ACTION_CALL_INCOMING:
//         break;
//       case Event.ACTION_CALL_START:
//         break;
//       case Event.ACTION_CALL_ACCEPT:
//       Get.defaultDialog(
//         title: 'HALOO SELAMAT MALAM'
//       );
//         break;
//       case Event.ACTION_CALL_DECLINE:
//        Get.defaultDialog(
//         title: 'HAHAHAH MANTAP'
//       );

//         break;
//       case Event.ACTION_CALL_ENDED:
//         break;
//       case Event.ACTION_CALL_TIMEOUT:
//         break;
//       case Event.ACTION_CALL_CALLBACK:
//         break;
//       case Event.ACTION_CALL_TOGGLE_HOLD:
//         break;
//       case Event.ACTION_CALL_TOGGLE_MUTE:
//         break;
//       case Event.ACTION_CALL_TOGGLE_DMTF:
//         break;
//       case Event.ACTION_CALL_TOGGLE_GROUP:
//         break;
//       case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
//         break;
//       case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
//         break;
//     }
//   });
// }


