import 'package:flutter/material.dart';


AppBar appbarBack() {
    return AppBar(
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text("Kembali"),
      titleTextStyle: const TextStyle(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }