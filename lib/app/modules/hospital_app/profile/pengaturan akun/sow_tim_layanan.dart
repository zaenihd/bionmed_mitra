import 'package:bionmed/app/widget/appbar/appbar_back.dart';
import 'package:bionmed/app/widget/container/container.dart';
import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

class SowTimLayanan extends StatelessWidget {
   SowTimLayanan({super.key, this.data});

  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBack(),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => ListTile(
          leading: Cntr(
            color: Colors.transparent,
            height: 40,
            width: 40,
            image:  DecorationImage(image: NetworkImage(data[index]['nurse_work_scope']['icon'])),
          ),
          title: Txt(text: data[index]['nurse_work_scope']['name']),
        ),
      ),
    );
  }
}
