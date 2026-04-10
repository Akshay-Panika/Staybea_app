// your_education_model.dart

class EducationResponse {
  final bool success;
  final List<EducationData> data;

  EducationResponse({required this.success, required this.data});

  factory EducationResponse.fromJson(Map<String, dynamic> json) {
    return EducationResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((e) => EducationData.fromJson(e))
          .toList(),
    );
  }
}

class EducationData {
  final String id;
  final String flowType;
  final String title;
  final String subtitle;
  final List<String> educations;

  EducationData({
    required this.id,
    required this.flowType,
    required this.title,
    required this.subtitle,
    required this.educations,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) {
    return EducationData(
      id: json['_id'],
      flowType: json['flowType'],
      title: json['title'],
      subtitle: json['subtitle'],
      educations: List<String>.from(json['educations']),
    );
  }
}