import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/interest_hobby_model.dart';

class InterestHobbyRepository {
  final ApiClient _apiClient = ApiClient();

  Future<InterestHobbyModel> fetchInterestHobby() async {
    try {
      final response = await _apiClient.get(
        ApiUrls.getQuestions,
        queryParameters: {
          "category": "MATURE_CONNECTION",
          "screen": "INTEREST_HOBBY",
        },
      );

      return InterestHobbyModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load interests: $e");
    }
  }
}