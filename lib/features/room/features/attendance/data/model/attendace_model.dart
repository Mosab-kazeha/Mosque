class AttendanceModel {
  final int studentId;
  final int campaignId;
  final String status;
  final int delay;
  final String date;

  AttendanceModel({
    required this.studentId,
    required this.campaignId,
    required this.status,
    required this.delay,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "campaign_id": campaignId,
    "status": status,
    "delay": delay,
    "date": date,
  };

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentId: json['student_id'] ?? 0,
      campaignId: json['campaign_id'] ?? 0,
      status: json['status'] ?? '',
      delay: json['delay_time'] ?? 0,
      date: json['taken_date'] ?? '',
    );
  }
}
