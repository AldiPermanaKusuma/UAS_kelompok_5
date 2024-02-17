// ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:newsapk/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class LoginRepository extends Repository {
  Future Login({required String username, required String password}) async {
    final Dio _dio = Dio();
    Map formDataMap = {'user': username, 'pwd': password};
    FormData formData = FormData();
    formData.fields
        .addAll(formDataMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await _dio.post(
      'https://prauas-aldi07.000webhostapp.com/login.php',
      data: formData,
    );
    log("hasil res $response");
    Map repoResponse = {"status": false, "data": Null};

    if (response.statusCode == 200) {
      log("Masuk");
      final Map<String, dynamic> data = response.data;
      if (data['status'] == 'success') {
        repoResponse['status'] = true;
        repoResponse['data'] = data;
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('session', data['session_token']);
      } else {
        repoResponse['data'] = data;
      }
    }
    return repoResponse;
  }

  Future logout() async {
    final _dio = Dio();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String sessionToken = preferences.getString('session') ?? "";
    Map formDataMap = {'session_token': sessionToken};
    FormData formData = FormData();
    formData.fields
        .addAll(formDataMap.entries.map((e) => MapEntry(e.key, e.value)));
    final response = await _dio.post(
      'https://prauas-aldi07.000webhostapp.com/logout.php',
      data: formData,
    );
    preferences.remove('session_token');
  }
}
