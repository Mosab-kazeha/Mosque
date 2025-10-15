class CurriculumModel {
  final int id;
  final String name;
  final String description;

  const CurriculumModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CurriculumModel.fromJson(Map<String, dynamic> json) {
    return CurriculumModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
