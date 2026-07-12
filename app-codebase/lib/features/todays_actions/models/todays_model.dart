class TodayAction {
  final int id;
  final String? action;

  TodayAction({required this.id, required this.action});

  factory TodayAction.fromJson(Map<String, dynamic> json) {
    return TodayAction(
      id: json['id'],
      action: json['action'],
    );
  }
}
