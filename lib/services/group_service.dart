import 'package:dio/dio.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class GroupService {
  final Dio dio = DioClient().dio;

  Future<List<Group>?> getGroups() async {
    String url = "/api/groups";
    try {
      final response = await dio.get(url);
      print("Bu response: $response");
      List<dynamic> data = response.data["data"];
      return data
          .map((e) => Group.fromJson((e as Map<String, dynamic>)))
          .toList();
    } on DioException catch (e) {
      print("Group get dio Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Groups get Error: $e");
      rethrow;
    }
  }
}
