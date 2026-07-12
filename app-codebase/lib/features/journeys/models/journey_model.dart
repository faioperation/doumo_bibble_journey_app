class JourneyResponse {
  final String category;
  final List<Journey> journeys;

  JourneyResponse({
    required this.category,
    required this.journeys,
  });

  factory JourneyResponse.fromJson(Map<String, dynamic> json) {
    return JourneyResponse(
      category: json['category'] ?? "",
      journeys: (json['journeys'] as List)
          .map((e) => Journey.fromJson(e))
          .toList(),
    );
  }
}

class Journey {
  final int id;
  final String name;
  final String status;
  final int completedDays;
  final String journeyIcon;
  final JourneyDetails details;

  Journey({
    required this.id,
    required this.name,
    required this.status,
    required this.completedDays,
    required this.journeyIcon,
    required this.details,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      name: json['name'] ?? "",
      status: json['status'] ?? "",
      completedDays: json['completed_days'] ?? 0,
      journeyIcon: json['journey_icon'] ?? "",
      details: JourneyDetails.fromJson(json['details'] ?? {}),
    );
  }
}

class JourneyDetails {
  final String image;
  final String description;

  JourneyDetails({
    required this.image,
    required this.description,
  });

  factory JourneyDetails.fromJson(Map<String, dynamic> json) {
    return JourneyDetails(
      image: json['image'] ?? "",
      description: json['details'] ?? "",
    );
  }
}

