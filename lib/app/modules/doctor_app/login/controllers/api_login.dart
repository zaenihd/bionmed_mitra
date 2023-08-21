import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constant/string.dart';

class ApiLogin {
  Future<dynamic> loginApps({required String phoneNumber}) async {
    try {
      String url = '${MainUrl.urlApi}login/';

      final payload = <String, dynamic>{"phoneNumber": phoneNumber};
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      // ignore: avoid_print
      print("err : $e");
      rethrow;
    }
  }
}
