// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:uep/services/local_db.dart';

class AuthService {
  late final Dio _dio;

  AuthService() {
    _dio = Dio(
      BaseOptions(baseUrl: "http://millima.flutterwithakmaljon.uz/api"),
    );
  }

  Future<Map<String, dynamic>?> signUp(Map<String, dynamic> newData) async {
    String url = "/register";
    try {
      final response = await _dio.post(url, data: newData
          // data: {
          //   "name": "Hello Isfandiyor",
          //   "phone": "+998881180515",
          //   "password": "1146236",
          //   "password_confirmation": "1146236",
          // },
          );
      print("Bu uning datasi: ${response.data}");
      final token = response.data["data"]["token"];
      if (token != null) {
        await LocalDb.saveToken(token);
      } else {
        throw Exception("Token not found in response");
      }
      return response.data;
    } on DioException catch (e) {
      print("Dio Xatoligi: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Sing Upda Xatolik: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> signIn(Map<String, dynamic> newData) async {
    String url = "/login";
    try {
      final response = await _dio.post(url, data: newData
          // data: {
          //   "phone": "+998881180515",
          //   "password": "1146236",
          // },
          );

      final token = response.data["data"]["token"];
      if (token != null) {
        await LocalDb.saveToken(token);
      } else {
        throw Exception("Token not found in response");
      }

      return response.data;
    } on DioException catch (e) {
      print("Dio Xatoligi: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Sing Upda Xatolik: $e");
    }
    return null;
  }

  Future<void> logout() async {
    String url = '/logout';
    try {
      final token = await LocalDb.getIdToken();
      print("Bu token $token");
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Logout response: ${response.data}");
      await LocalDb.deleteToken();
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Dio logout xatoligi: $e");
    } catch (e) {
      print("Logout Xatolik: $e");
    }
  }

  Future<bool> isAuthenticated() async {
    return await LocalDb.getIdToken() != null;
  }
}
