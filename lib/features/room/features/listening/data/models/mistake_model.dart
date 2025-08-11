class MistakeModel {
  final int id;
  final int page;
  final String title;

  MistakeModel({required this.id, required this.page, required this.title});

  factory MistakeModel.fromJson(Map<String, dynamic> json) {
    return MistakeModel(
      id: json['id'] ?? 0,
      page: json['page'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}