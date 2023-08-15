class AppointmentSlotModel {
  final String startTime;
  final String endTime;
  final bool available;

  AppointmentSlotModel({
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) {
    return AppointmentSlotModel(
      startTime: json['start_time'],
      endTime: json['end_time'],
      available: json['available'],
    );
  }
}
