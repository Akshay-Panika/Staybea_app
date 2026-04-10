class InterestedForDateModel {
  final bool success;
  final List<InterestedForDateData> data;

  InterestedForDateModel({
    required this.success,
    required this.data,
  });

  factory InterestedForDateModel.fromJson(Map<String, dynamic> json) {
    return InterestedForDateModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>)
          .map((e) => InterestedForDateData.fromJson(e))
          .toList(),
    );
  }
}

class InterestedForDateData {
  final String id;
  final String flowType;
  final String title;
  final List<GenderImage> genderImages;

  InterestedForDateData({
    required this.id,
    required this.flowType,
    required this.title,
    required this.genderImages,
  });

  factory InterestedForDateData.fromJson(Map<String, dynamic> json) {
    return InterestedForDateData(
      id: json['_id'] ?? '',
      flowType: json['flowType'] ?? '',
      title: json['title'] ?? '',
      genderImages: (json['genderImages'] as List<dynamic>)
          .map((e) => GenderImage.fromJson(e))
          .toList(),
    );
  }
}

class GenderImage {
  final String gender;
  final String image;

  GenderImage({
    required this.gender,
    required this.image,
  });

  factory GenderImage.fromJson(Map<String, dynamic> json) {
    return GenderImage(
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
    );
  }
}