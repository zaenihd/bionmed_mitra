// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MyWidget extends StatefulWidget {
   const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int endTime =0;
   CountdownTimerController? controller ;

  @override
  void initState() {
       super.initState();
  }

  void startTime(bool start){
  if(start == true){
       setState(() {
         endTime = DateTime.now().millisecondsSinceEpoch + 8000 * 38;

      controller =
      CountdownTimerController(endTime: endTime,);   
       });
  }
  }

  @override
  void dispose() {
                  controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
startTime(true);
          }, child: const Text("Star")),
            ElevatedButton(onPressed: (){}, child: const Text("Stop")),
            CountdownTimer(
                          controller: controller,
                          // onEnd: onEnd,
                          endTime: endTime,
                        ),
          ],
        ),
      ),
    );
  }
}