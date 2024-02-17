import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'repository.dart';
import 'dart:convert';
import 'dart:io';

class NewsRepository extends Repository {
  final Dio _dio = Dio();

  Future addNews(
      {required title,
      required String desc,
      required String date,
      required File image}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String sessionToken = prefs.getString('sessionToken') ?? "";

      FormData formData = FormData.fromMap({
        'title': title,
        'description': desc,
        'date': date,
        'image':
            await MultipartFile.fromFile(image.path, filename: 'image.jpg'),
      });

      Response response = await _dio.post(
        'https://prauas-aldi07.000webhostapp.com/addnews.php',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Berita berhasil ditambahkan');
      } else {
        log('Gagal menambahkan berita');
      }
    } catch (error) {
      log('Error: $error');
    }
  }

  Future<List<dynamic>> getlistNews(String keyword) async {
    FormData formData = FormData.fromMap({
      'key': keyword,
    });
    try {
      log("Ambil List");
      var response = await _dio.post(
          "https://prauas-aldi07.000webhostapp.com/listnews.php",
          data: formData);

      // Mengonversi respons ke dalam bentuk JSON
      Map<String, dynamic> responseData = json.decode(response.data);

      // Mengakses data dalam respons
      List<dynamic> newsList =
          responseData['data']; // Sesuaikan dengan struktur respons dari server

      // Cetak respons untuk debugging
      print("Response: $newsList");

      return newsList;
    } catch (error) {
      log("Error $error");
      return [];
    }
  }
}
