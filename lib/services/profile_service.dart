import 'package:dio/dio.dart';
import 'package:uep/services/dio/dio_client.dart';
import 'package:uep/services/local_db/local_db.dart';

class ProfileService {
  DioClient dioClient = DioClient();

  Future<Map<String, dynamic>?> getUser() async {
    String url = "/api/user";
    try {
      final token = await LocalDb.getIdToken();
      print("Bu token: $token");
      final response = await dioClient.dio.get(url);

      return response.data;
    } on DioException catch (e) {
      print("Dio Xatoligi: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Sing Upda Xatolik: $e");
    }
    return null;
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    String url = "/api/profile/update";
    try {
      final token = await LocalDb.getIdToken();

      print("Bu token: $token");
      print("Bu data: $data");

      final response = await dioClient.dio.post(url, data: data);

      print("Bu response update name: ${response.data}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Update nameda Dio Xatoligi: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Update nameda Xatolik: $e");
      rethrow;
    }
  }
}
