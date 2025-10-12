final class SurahTemplateModel {
  final int id;
  final int number;
  final String name;
  final int pageNumber;
  final int? startLine;
  final int? endLine;
  final num weight;

  const SurahTemplateModel({
    required this.id,
    required this.number,
    required this.name,
    required this.pageNumber,
    required this.startLine,
    required this.endLine,
    required this.weight,
  });

  factory SurahTemplateModel.fromJson(Map<String, dynamic> json) {
    return SurahTemplateModel(
      id: json['id'],
      number: json['surahNumber'],
      name: json['surahName'],
      pageNumber: json['pageNumber'],
      startLine: json['startLine'],
      endLine: json['endLine'],
      weight: json['weight'],
    );
  }
}
