class PrayerResponse {
  final JourneyInfo journey;
  final DayInfo day;
  final bool isCompleted;
  final PrayerData data;

  PrayerResponse({
    required this.journey,
    required this.day,
    required this.isCompleted,
    required this.data,
  });

  factory PrayerResponse.fromJson(Map<String, dynamic> json) {
    return PrayerResponse(
      journey: JourneyInfo.fromJson(json['journey']),
      day: DayInfo.fromJson(json['day']),
      isCompleted: json['is_completed'],
      data: PrayerData.fromJson(json['data']),
    );
  }
}

class JourneyInfo {
  final int id;
  final String name;
  final String status;

  JourneyInfo({required this.id, required this.name, required this.status});

  factory JourneyInfo.fromJson(Map<String, dynamic> json) {
    return JourneyInfo(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

class DayInfo {
  final int id;
  final int order;
  final String title;
  final String status;

  DayInfo({
    required this.id,
    required this.order,
    required this.title,
    required this.status,
  });

  factory DayInfo.fromJson(Map<String, dynamic> json) {
    return DayInfo(
      id: json['id'],
      order: json['order'],
      title: json['title'],
      status: json['status'],
    );
  }
}

class PrayerData {
  final int id;
  final int journeyId;
  final int dayId;
  final String prayer;
  final String audioUrl;

  PrayerData({
    required this.id,
    required this.journeyId,
    required this.dayId,
    required this.prayer,
    required this.audioUrl,
  });

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      id: json['id'],
      journeyId: json['journey_id'],
      dayId: json['day_id'],
      prayer: json['prayer'],
      audioUrl: json['audio_url'],
    );
  }
}
