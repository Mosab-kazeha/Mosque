class CurriculumNodeModel {
  final int id;
  final int templateId;
  final int? parentId;
  final String name;
  final String description;
  final String nodeType;
  final int orderIndex;
  final int? estimatedLessonsCount;
  final int estimatedDurationMinutes;
  final int lessonSpan;
  final String status;
  final String createdAt;
  final String updatedAt;

  const CurriculumNodeModel({
    required this.id,
    required this.templateId,
    this.parentId,
    required this.name,
    required this.description,
    required this.nodeType,
    required this.orderIndex,
    this.estimatedLessonsCount,
    required this.estimatedDurationMinutes,
    required this.lessonSpan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurriculumNodeModel.fromJson(Map<String, dynamic> json) {
    return CurriculumNodeModel(
      id: json['id'] as int,
      templateId: json['template_id'] as int,
      parentId: json['parent_id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      nodeType: json['node_type'] as String,
      orderIndex: json['order_index'] as int,
      estimatedLessonsCount: json['estimated_lessons_count'] as int?,
      estimatedDurationMinutes: json['estimated_duration_minutes'] as int,
      lessonSpan: json['lesson_span'] as int,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'template_id': templateId,
      'parent_id': parentId,
      'name': name,
      'description': description,
      'node_type': nodeType,
      'order_index': orderIndex,
      'estimated_lessons_count': estimatedLessonsCount,
      'estimated_duration_minutes': estimatedDurationMinutes,
      'lesson_span': lessonSpan,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
