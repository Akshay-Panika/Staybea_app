import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/health_wellness_model.dart';

class HealthWellnessRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<HealthWellnessModel>> fetchHealthWellness() async {
    try {
      final response = await _apiClient.get(
        ApiUrls.getLifestyleQuestions,
        queryParameters: {
          "category": "MATURE_CONNECTION",
          "screen": "HEALTH_WELLNESS",
        },
      );

      final data = response.data['data'] as List;

      return data
          .map((e) => HealthWellnessModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch health wellness: $e");
    }
  }
}