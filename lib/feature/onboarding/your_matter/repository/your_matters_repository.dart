// your_matters_repository.dart
import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/your_matters_model.dart';

class YouMattersRepository {
  final ApiClient _apiClient = ApiClient();

  Future<YouMattersResponse> fetchMatters({
    String category = 'DATE_TO_MARRY',
    String screen = 'REAL_U_MATTERS',
  }) async {
    final response = await _apiClient.get(
      ApiUrls.getQuestions,
      queryParameters: {
        'category': category,
        'screen': screen,
      },
    );
    return YouMattersResponse.fromJson(response.data);
  }
}