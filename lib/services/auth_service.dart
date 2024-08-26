// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:uep/services/dio/dio_client.dart';
import 'package:uep/services/local_db/local_db.dart';

class AuthService {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>?> signUp(Map<String, dynamic> newData) async {
    String url = "/api/register";
    try {
      final response = await dioClient.dio.post(url, data: newData);

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
      throw e.response?.data["data"];
    } catch (e) {
      print("Sing Upda Xatolik: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> signIn(Map<String, dynamic> newData) async {
    String url = "/api/login";
    try {
      final response = await dioClient.dio.post(url, data: newData);

      final token = response.data["data"]["token"];
      if (token != null) {
        await LocalDb.saveToken(token);
      } else {
        throw Exception("Token not found in response");
      }

      return response.data;
    } on DioException catch (e) {
      print("Dio Xatoligi: ${e.response?.data}");
      throw e.response?.data["data"];
    } catch (e) {
      print("Sing Upda Xatolik: $e");
    }
    return null;
  }

  Future<void> logout() async {
    String url = '/api/logout';
    try {
      final token = await LocalDb.getIdToken();
      print("Bu token $token");
      final response = await dioClient.dio.post(url);
      print("Logout response: ${response.data}");
      await LocalDb.deleteToken();
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Dio logout xatoligi: $e");
      throw e.response?.data["data"];
    } catch (e) {
      print("Logout Xatolik: $e");
    }
  }

  Future<bool> isAuthenticated() async {
    return await LocalDb.getIdToken() != null;
  }
}
