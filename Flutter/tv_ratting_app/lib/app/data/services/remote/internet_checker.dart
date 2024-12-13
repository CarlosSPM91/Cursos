import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) { //si es web
        final response = await get(
          Uri.parse("8.8.8.8"),
        );
        return response.statusCode==HttpStatus.ok;
      } else {
        final list = await InternetAddress.lookup("google.com");
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      print(e.runtimeType);
      return false;
    }
  }
}
