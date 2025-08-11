class TeacherModel {
  final int id;
  final String firstName;
  final String lastName;

  TeacherModel({required this.id, required this.firstName, required this.lastName});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}