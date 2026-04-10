

import '../../../../core/helper/api_client.dart';
import '../../../../core/helper/api_urls.dart';
import '../model/interested_for_date_model.dart';

class InterestedForDateRepository {
  final ApiClient _apiClient = ApiClient();

  Future<InterestedForDateModel> getInterestedForDate() async {
    final response = await _apiClient.get(
      ApiUrls.getInterestedForDate,
      queryParameters: {
        "flowType": "dating",
      },
    );

    return InterestedForDateModel.fromJson(response.data);
  }
}