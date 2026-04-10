// your_talk_lifestyle_repository.dart
import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/your_talk_lifestyle_model.dart';

class LifestyleRepository {
  final ApiClient _apiClient = ApiClient();

  Future<LifestyleResponse> fetchLifestyle({
    String category = 'DATE_TO_MARRY',
    String screen = 'LIFESTYLE',
  }) async {
    final response = await _apiClient.get(
      ApiUrls.getLifestyleQuestions,
      queryParameters: {
        'category': category,
        'screen': screen,
      },
    );
    return LifestyleResponse.fromJson(response.data);
  }
}