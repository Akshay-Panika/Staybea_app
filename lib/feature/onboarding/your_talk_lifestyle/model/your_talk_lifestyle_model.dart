// your_talk_lifestyle_model.dart

class LifestyleResponse {
  final bool success;
  final List<LifestyleQuestion> data;

  LifestyleResponse({required this.success, required this.data});

  factory LifestyleResponse.fromJson(Map<String, dynamic> json) {
    return LifestyleResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((e) => LifestyleQuestion.fromJson(e))
          .toList(),
    );
  }
}

class LifestyleQuestion {
  final String id;
  final String key;
  final String title;
  final String category;
  final String screen;
  final bool isMulti;
  final List<LifestyleOption> options;

  LifestyleQuestion({
    required this.id,
    required this.key,
    required this.title,
    required this.category,
    required this.screen,
    required this.isMulti,
    required this.options,
  });

  factory LifestyleQuestion.fromJson(Map<String, dynamic> json) {
    return LifestyleQuestion(
      id: json['id'],
      key: json['key'],
      title: json['title'],
      category: json['category'],
      screen: json['screen'],
      isMulti: json['isMulti'],
      options: (json['options'] as List)
          .map((e) => LifestyleOption.fromJson(e))
          .toList(),
    );
  }
}

class LifestyleOption {
  final String id;
  final String questionId;
  final String value;
  final String label;

  LifestyleOption({
    required this.id,
    required this.questionId,
    required this.value,
    required this.label,
  });

  factory LifestyleOption.fromJson(Map<String, dynamic> json) {
    return LifestyleOption(
      id: json['id'],
      questionId: json['question_id'],
      value: json['value'],
      label: json['label'],
    );
  }
}