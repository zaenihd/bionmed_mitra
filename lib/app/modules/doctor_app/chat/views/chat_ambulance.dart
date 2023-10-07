import 'dart:async';

import 'package:bionmed/app/modules/doctor_app/home/controllers/home_controller.dart';
import 'package:bionmed/app/widget/button/button_gradien.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';

import 'package:zego_zimkit/zego_zimkit.dart';

import '../../layanan_home/controllers/layanan_home_controller.dart';

extension ZIMKitDefaultDialogService on ZIMKit {
  void showDefaultNewPeerChatDialogChat(BuildContext context, String userId) {
    final userIDController = TextEditingController(text: userId);
    final myC = Get.put(LayananHomeController());

    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Apakah anda ingin mulai sekarang ?'),
              // content: TextField(
              //   controller: userIDController,
              //   keyboardType: TextInputType.text,
              //   enabled: true,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'User ID',
              //   ),
              // ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    Get.find<HomeController>().loading.value = false;
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // myC.updateStatusTimer(statusOrder: myC.statusOrderChat.value + 1,
                    // statusPayment: myC.statusPayment.value + 2);
                    myC.updateStatus(orderId: myC.orderId.value, status: 4);
                    Get.find<HomeController>().loading.value = false;

                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((ok) {
        if (ok != true) return;
        if (userIDController.text.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ZIMKitMessageListPageChatAmbulance(
              conversationID: userIDController.text,
            );
          }));
        }
      });
    });
  }

  void showDefaultNewGroupChatDialog(BuildContext context) {
    final groupIDController = TextEditingController();
    final groupNameController = TextEditingController();
    final groupUsersController = TextEditingController();
    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Group'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: groupNameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Group Name',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: groupIDController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ID(optional)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 3,
                    controller: groupUsersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Invite User IDs',
                      hintText: 'separate by comma, e.g. 123,987,229',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((bool? ok) {
        if (ok != true) return;
        if (groupNameController.text.isNotEmpty &&
            groupUsersController.text.isNotEmpty) {
          ZIMKit()
              .createGroup(
            groupNameController.text,
            groupUsersController.text.split(','),
            id: groupIDController.text,
          )
              .then((String? conversationID) {
            if (conversationID != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversationID,
                  conversationType: ZIMConversationType.group,
                );
              }));
            }
          });
        }
      });
    });
  }

  void showDefaultJoinGroupDialog(BuildContext context) {
    final groupIDController = TextEditingController();
    Timer.run(() {
      showDialog<bool>(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Join Group'),
              content: TextField(
                controller: groupIDController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Group ID',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        },
      ).then((bool? ok) {
        if (ok != true) return;
        if (groupIDController.text.isNotEmpty) {
          ZIMKit().joinGroup(groupIDController.text).then((int errorCode) {
            if (errorCode == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ZIMKitMessageListPageChatAmbulance(
                  conversationID: groupIDController.text,
                  conversationType: ZIMConversationType.group,
                );
              }));
            }
          });
        }
      });
    });
  }
}

//CHAT PAGE
class ZIMKitMessageListPageChatAmbulance extends StatefulWidget {
  const ZIMKitMessageListPageChatAmbulance({
    Key? key,
    required this.conversationID,
    this.conversationType = ZIMConversationType.peer,
    this.appBarBuilder,
    this.appBarActions,
    this.messageInputActions,
    this.onMessageSent,
    this.preMessageSending,
    this.inputDecoration,
    this.showPickFileButton = true,
    this.editingController,
    this.messageListScrollController,
    this.onMessageItemPressd,
    this.onMessageItemLongPress,
    this.messageItemBuilder,
    this.messageListErrorBuilder,
    this.messageListLoadingBuilder,
    this.theme,
  }) : super(key: key);

  /// this page's conversationID
  final String conversationID;

  /// this page's conversationType
  final ZIMConversationType conversationType;

  /// if you just want add some actions to the appBar, use [appBarActions].
  ///
  /// use it like this:
  /// appBarActions:[
  ///   IconButton(icon: const Icon(Icons.local_phone), onPressed: () {}),
  ///   IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
  /// ],
  final List<Widget>? appBarActions;

  // if you want customize the appBar, use appBarBuilder return your custom appBar
  // if you don't want use appBar, return null
  final AppBar? Function(BuildContext context, AppBar defaultAppBar)?
      appBarBuilder;

  /// To add your own action, use the [messageInputActions] parameter like this:
  ///
  /// use [messageInputActions] like this to add your custom actions:
  ///
  /// actions: [
  ///   ZIMKitMessageInputAction.left(
  ///     IconButton(icon: Icon(Icons.mic), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.leftInside(
  ///     IconButton(icon: Icon(Icons.sentiment_satisfied_alt_outlined), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.rightInside(
  ///     IconButton(icon: Icon(Icons.cabin), onPressed: () {})
  ///   ),
  ///   ZIMKitMessageInputAction.right(
  ///     IconButton(icon: Icon(Icons.sd), onPressed: () {})
  ///   ),
  /// ],
  final List<ZIMKitMessageInputAction>? messageInputActions;

  /// Called when a message is sent.
  final void Function(ZIMKitMessage)? onMessageSent;

  /// Called before a message is sent.
  final FutureOr<ZIMKitMessage> Function(ZIMKitMessage)? preMessageSending;

  /// By default, [ZIMKitMessageInput] will show a button to pick file.
  /// If you don't want to show this button, set [showPickFileButton] to false.
  final bool showPickFileButton;

  /// The TextField's decoration.
  final InputDecoration? inputDecoration;

  /// The [TextEditingController] to use.
  /// if not provided, a default one will be created.
  final TextEditingController? editingController;

  /// The [ScrollController] to use.
  /// if not provided, a default one will be created.
  final ScrollController? messageListScrollController;

  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onMessageItemPressd;
  final void Function(
          BuildContext context, ZIMKitMessage message, Function defaultAction)?
      onMessageItemLongPress;
  final Widget Function(
          BuildContext context, ZIMKitMessage message, Widget defaultWidget)?
      messageItemBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      messageListErrorBuilder;
  final Widget Function(BuildContext context, Widget defaultWidget)?
      messageListLoadingBuilder;

  // theme
  final ThemeData? theme;

  @override
  State<ZIMKitMessageListPageChatAmbulance> createState() =>
      _ZIMKitMessageListPageChatAmbulanceState();
}

class _ZIMKitMessageListPageChatAmbulanceState extends State<ZIMKitMessageListPageChatAmbulance> {
  //TIMER CHAT

  bool isDuration = false;
  bool stop = false;
  bool stopWaiting = false;
  int endTime = 0;
  CountdownTimerController? controller;
  @override
  void initState() {
    super.initState();
  }


  //Timer waiting pasien
  // ignore: unused_field
  Timer? _timer;
  final int _start = 60;

  stopWaitingF() {
    stopWaiting = true;
  }


  // void startTime(bool start) {
  //   if (start == true && endTime == 0) {
  //     setState(() {
  //       endTime = DateTime.now().millisecondsSinceEpoch + 8000 * 38;
  //       controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  //     });
  //   } else {
  //     endTime = 0;
  //     controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  //   }
  // }


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

  stopTime() {
    stop = true;
  }

  final myC = Get.put(LayananHomeController());


  @override
  void dispose() {
    super.dispose();
    // ignore: todo
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: widget.theme ?? Theme.of(context),
        child: Scaffold(
            appBar: widget.appBarBuilder != null
                ? widget.appBarBuilder!.call(context, buildAppBar(context))
                : buildAppBar(context),
            body: Stack(children: [
              Column(
                children: [
                  ZIMKitMessageListView(
                    key: ValueKey('ZIMKitMessageListView:${Object.hash(
                      widget.conversationID,
                      widget.conversationType,
                    )}'),
                    conversationID: widget.conversationID,
                    conversationType: widget.conversationType,
                    onPressed: widget.onMessageItemPressd,
                    itemBuilder: widget.messageItemBuilder,
                    // onLongPress: widget.onMessageItemLongPress,
                    loadingBuilder: widget.messageListLoadingBuilder,
                    errorBuilder: widget.messageListErrorBuilder,
                    scrollController: widget.messageListScrollController,
                    theme: widget.theme,
                  ),
                  ZIMKitMessageInput(
                    key: ValueKey('ZIMKitMessageInput:${Object.hash(
                      widget.conversationID,
                      widget.conversationType,
                    )}'),
                    conversationID: widget.conversationID,
                    conversationType: widget.conversationType,
                    actions: widget.messageInputActions,
                    onMessageSent: widget.onMessageSent,
                    preMessageSending: widget.preMessageSending,
                    inputDecoration: widget.inputDecoration,
                    showPickFileButton: widget.showPickFileButton,
                    editingController: widget.editingController,
                    theme: widget.theme,
                  ),
                ],
              ),
            ])));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title:  Row(
              children: [
                Cntr(
                  radius: BorderRadius.circular(100),
                  height: 40, width: 40, image: DecorationImage(image: NetworkImage(Get.find<HomeController>().imageCostomer.value)),),
                // child!,
                const SizedBox(
                width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Get.find<LayananHomeController>().nameCostumer,
                        style: const TextStyle(fontSize: 16)),
                    // if (myC.statusOrderChat.value == 3) {
                    //   endTime = 0;
                    //   startTime(false);
                    // }
                  ],
                )
              ],
            ),
        );
  }
}
