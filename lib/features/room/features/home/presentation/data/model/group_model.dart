import '../../../../../data/model/student_model.dart';

class GroupModel {
  final int id;
  final int mosqueId;
  final String title;
  final int? groupClass;
  final int currentTeacherId;
  final String createdAt;
  final String updatedAt;
  final List<StudentModel> students;

  GroupModel({
    required this.id,
    required this.mosqueId,
    required this.title,
    required this.groupClass,
    required this.currentTeacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.students,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      mosqueId: json['mosque_id'],
      title: json['title'],
      groupClass: json['class'],
      currentTeacherId: json['current_teacher_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      students:
          (json['students'] as List)
              .map((e) => StudentModel.fromJson(e))
              .toList(),
    );
  }
}
