class DevotionResponse {
  final JourneyInfo journey;
  final DayInfo day;
  final bool isCompleted;
  final DevotionData data;

  DevotionResponse({
    required this.journey,
    required this.day,
    required this.isCompleted,
    required this.data,
  });

  factory DevotionResponse.fromJson(Map<String, dynamic> json) {
    return DevotionResponse(
      journey: JourneyInfo.fromJson(json['journey']),
      day: DayInfo.fromJson(json['day']),
      isCompleted: json['is_completed'],
      data: DevotionData.fromJson(json['data']),
    );
  }
}

class DevotionData {
  final int id;
  final int journeyId;
  final int dayId;
  final String scriptureName;
  final String devotion;
  final String reflection;

  DevotionData({
    required this.id,
    required this.journeyId,
    required this.dayId,
    required this.scriptureName,
    required this.devotion,
    required this.reflection,
  });

  factory DevotionData.fromJson(Map<String, dynamic> json) {
    return DevotionData(
      id: json['id'],
      journeyId: json['journey_id'],
      dayId: json['day_id'],
      scriptureName: json['scripture_name'],
      devotion: json['devotion'],
      reflection: json['reflection'],
    );
  }
}

class JourneyInfo {
  final int id;
  final String name;
  final String status;

  JourneyInfo({required this.id, required this.name, required this.status});
  factory JourneyInfo.fromJson(Map<String, dynamic> json) => JourneyInfo(
    id: json['id'],
    name: json['name'],
    status: json['status'],
  );
}

class DayInfo {
  final int id;
  final int order;
  final String title;
  final String status;

  DayInfo({required this.id, required this.order, required this.title, required this.status});
  factory DayInfo.fromJson(Map<String, dynamic> json) => DayInfo(
    id: json['id'],
    order: json['order'],
    title: json['title'],
    status: json['status'],
  );
}
