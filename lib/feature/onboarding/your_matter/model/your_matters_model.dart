// your_matters_model.dart

class YouMattersResponse {
  final bool success;
  final List<YouMattersQuestion> data;

  YouMattersResponse({required this.success, required this.data});

  factory YouMattersResponse.fromJson(Map<String, dynamic> json) {
    return YouMattersResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((e) => YouMattersQuestion.fromJson(e))
          .toList(),
    );
  }
}

class YouMattersQuestion {
  final String id;
  final String key;
  final String title;
  final String category;
  final String screen;
  final bool isMulti;
  final List<YouMattersOption> options;

  YouMattersQuestion({
    required this.id,
    required this.key,
    required this.title,
    required this.category,
    required this.screen,
    required this.isMulti,
    required this.options,
  });

  factory YouMattersQuestion.fromJson(Map<String, dynamic> json) {
    return YouMattersQuestion(
      id: json['id'],
      key: json['key'],
      title: json['title'],
      category: json['category'],
      screen: json['screen'],
      isMulti: json['isMulti'],
      options: (json['options'] as List)
          .map((e) => YouMattersOption.fromJson(e))
          .toList(),
    );
  }
}

class YouMattersOption {
  final String id;
  final String questionId;
  final String value;
  final String label;

  YouMattersOption({
    required this.id,
    required this.questionId,
    required this.value,
    required this.label,
  });

  factory YouMattersOption.fromJson(Map<String, dynamic> json) {
    return YouMattersOption(
      id: json['id'],
      questionId: json['question_id'],
      value: json['value'],
      label: json['label'],
    );
  }
}