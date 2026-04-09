import 'package:dio/dio.dart';
import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/religion_model.dart';

class ReligionRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ReligionResponse> getReligions() async {
    try {
      final response = await _apiClient.get(
        ApiUrls.getReligions,
        queryParameters: {"flowType": "marriage"},
      );

      if (response.data == null) {
        throw Exception("Empty response from server.");
      }

      return ReligionResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message ?? 'Network error';
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}