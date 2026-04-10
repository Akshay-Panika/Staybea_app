import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/dream_plan_model.dart';

class DreamPlanRepository {
  final ApiClient _apiClient = ApiClient();

  Future<DreamPlanModel> fetchDreamPlan() async {
    try {
      final response = await _apiClient.get(
        ApiUrls.getQuestions,
        queryParameters: {
          "category": "MATURE_CONNECTION",
          "screen": "DREAM_PLAN", // ✅ UPDATED HERE
        },
      );

      return DreamPlanModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load dream plan: $e");
    }
  }
}