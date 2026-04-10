class YourThingsLoveResponse {
  final bool success;
  final List<YourThingsLoveQuestion> data;

  YourThingsLoveResponse({
    required this.success,
    required this.data,
  });

  factory YourThingsLoveResponse.fromJson(Map<String, dynamic> json) {
    return YourThingsLoveResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((e) => YourThingsLoveQuestion.fromJson(e))
          .toList(),
    );
  }
}

class YourThingsLoveQuestion {
  final String id;
  final String key;
  final String title;
  final String category;
  final String screen;
  final bool isMulti;
  final List<YourThingsLoveOption> options;

  YourThingsLoveQuestion({
    required this.id,
    required this.key,
    required this.title,
    required this.category,
    required this.screen,
    required this.isMulti,
    required this.options,
  });

  factory YourThingsLoveQuestion.fromJson(Map<String, dynamic> json) {
    return YourThingsLoveQuestion(
      id: json['id'],
      key: json['key'],
      title: json['title'],
      category: json['category'],
      screen: json['screen'],
      isMulti: json['isMulti'],
      options: (json['options'] as List)
          .map((e) => YourThingsLoveOption.fromJson(e))
          .toList(),
    );
  }
}

class YourThingsLoveOption {
  final String id;
  final String questionId;
  final String value;
  final String label;

  YourThingsLoveOption({
    required this.id,
    required this.questionId,
    required this.value,
    required this.label,
  });

  factory YourThingsLoveOption.fromJson(Map<String, dynamic> json) {
    return YourThingsLoveOption(
      id: json['id'],
      questionId: json['question_id'],
      value: json['value'],
      label: json['label'],
    );
  }
}