import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<Map<String, dynamic>> checkSession(String sessionToken) async {
    final Dio _dio = Dio();

    try {
      // Mendapatkan nilai session dari SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String savedSessionToken = prefs.getString('session') ?? "";

      // Menggunakan nilai sessionToken dari parameter fungsi
      Map<String, dynamic> fdataMap = {'session_token': sessionToken};
      FormData fdata = FormData();
      fdata.fields
          .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));

      final response = await _dio.post(
        'https://prauas-aldi07.000webhostapp.com/session.php',
        data: fdata,
      );

      log("check session $response");

      Map<String, dynamic> repoResponse = {"status": false, "data": null};
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data['status'] == 'success') {
          repoResponse['status'] = true;
          repoResponse['data'] = data;

          // Menyimpan session baru ke SharedPreferences
          prefs.setString('session', data['session_token']);
        } else {
          repoResponse['data'] = data;
        }
      }

      return repoResponse;
    } catch (error) {
      log("Error: $error");
      // Mengembalikan response dengan status false jika terjadi error
      return {"status": false, "data": null};
    }
  }
}
