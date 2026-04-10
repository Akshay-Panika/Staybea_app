class InterestHobbyModel {
  final bool success;
  final List<QuestionData> data;

  InterestHobbyModel({
    required this.success,
    required this.data,
  });

  factory InterestHobbyModel.fromJson(Map<String, dynamic> json) {
    return InterestHobbyModel(
      success: json['success'] ?? false,
      data: (json['data'] as List)
          .map((e) => QuestionData.fromJson(e))
          .toList(),
    );
  }
}

class QuestionData {
  final String id;
  final String key;
  final String title;
  final String category;
  final String screen;
  final bool isMulti;
  final List<OptionModel> options;

  QuestionData({
    required this.id,
    required this.key,
    required this.title,
    required this.category,
    required this.screen,
    required this.isMulti,
    required this.options,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      screen: json['screen'] ?? '',
      isMulti: json['isMulti'] ?? false,
      options: (json['options'] as List)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }
}

class OptionModel {
  final String id;
  final String value;
  final String label;

  OptionModel({
    required this.id,
    required this.value,
    required this.label,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] ?? '',
      value: json['value'] ?? '',
      label: json['label'] ?? '',
    );
  }
}