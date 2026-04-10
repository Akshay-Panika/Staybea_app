import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/your_education_model.dart';

class EducationRepository {
  final ApiClient _apiClient = ApiClient();

  Future<EducationResponse> fetchEducation({String flowType = 'marriage'}) async {
    final response = await _apiClient.get(
      ApiUrls.getEducation,
      queryParameters: {'flowType': flowType},
    );
    return EducationResponse.fromJson(response.data);
  }
}