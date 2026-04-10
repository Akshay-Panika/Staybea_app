import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/your_things_love_model.dart';

class YourThingsLoveRepository {
  final ApiClient _apiClient = ApiClient();

  Future<YourThingsLoveResponse> fetchThingsLove({
    String category = 'DATE_TO_MARRY',
    String screen = 'THINGS_U_LOVE',
  }) async {
    final response = await _apiClient.get(
      ApiUrls.getQuestions,
      queryParameters: {
        'category': category,
        'screen': screen,
      },
    );

    return YourThingsLoveResponse.fromJson(response.data);
  }
}