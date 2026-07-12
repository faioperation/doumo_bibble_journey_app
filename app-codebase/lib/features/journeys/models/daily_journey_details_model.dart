class DailyJourneyResponse {
  final JourneyInfo journey;
  final JourneyDetails journeyDetails;
  final List<Day> days;

  DailyJourneyResponse({
    required this.journey,
    required this.journeyDetails,
    required this.days,
  });

  factory DailyJourneyResponse.fromJson(Map<String, dynamic> json) {
    return DailyJourneyResponse(
      journey: JourneyInfo.fromJson(json['journey']),
      journeyDetails:
      JourneyDetails.fromJson(json['journey_details']),
      days: (json['days'] as List)
          .map((e) => Day.fromJson(e))
          .toList(),
    );
  }
}

class JourneyDetails {
  final String image;
  final String details;

  JourneyDetails({
    required this.image,
    required this.details,
  });

  factory JourneyDetails.fromJson(Map<String, dynamic> json) {
    return JourneyDetails(
      image: json['image'] ?? "",
      details: json['details'] ?? "",
    );
  }
}



class JourneyInfo {
  final int id;
  final String name;

  JourneyInfo({required this.id, required this.name});

  factory JourneyInfo.fromJson(Map<String, dynamic> json) {
    return JourneyInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Day {
  final int dayId;
  final String dayName;
  final int order;
  final String status;

  Day({
    required this.dayId,
    required this.dayName,
    required this.order,
    required this.status,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      dayId: json['day_id'],
      dayName: json['day_name'],
      order: json['order'],
      status: json['status'],
    );
  }
}

