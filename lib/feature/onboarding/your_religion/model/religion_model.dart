class ReligionResponse {
  final bool success;
  final List<ReligionData> data;

  ReligionResponse({required this.success, required this.data});

  factory ReligionResponse.fromJson(Map<String, dynamic> json) {
    return ReligionResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReligionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReligionData {
  final String id;
  final String flowType;
  final String title;
  final List<Religion> religions;

  ReligionData({
    required this.id,
    required this.flowType,
    required this.title,
    required this.religions,
  });

  factory ReligionData.fromJson(Map<String, dynamic> json) {
    return ReligionData(
      id: json['_id'] ?? '',
      flowType: json['flowType'] ?? '',
      title: json['title'] ?? '',
      religions: (json['religions'] as List<dynamic>)
          .map((e) => Religion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Religion {
  final String name;
  final List<String> communities;

  Religion({required this.name, required this.communities});

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      name: json['name'] ?? '',
      communities: List<String>.from(json['communities'] ?? []),
    );
  }
}