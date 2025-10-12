final class SurahModel {
  // final int number;
  // final String name;
  // final int? startPage;
  // final int? endPage;

  // final int id;
  final int number;
  final String name;
  // final int? pageNumber;
  // final int? startLine;
  // final int? endLine;
  // final num? weight;

  const SurahModel({
    // required this.number,
    // required this.name,
    // this.startPage,
    // this.endPage,
    // required this.id,
    required this.number,
    required this.name,
    // this.pageNumber,
    // this.startLine,
    // this.endLine,
    // this.weight,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      // number: json['number'],
      // name: json['name'],
      // startPage: 20,
      // endPage: 44,
      // id: json['id'],
      number: json['surahNumber'] ?? json['number'],
      name: json['surahName'] ?? json['name'],
      // pageNumber: json['pageNumber'],
      // startLine: json['startLine'],
      // endLine: json['endLine'],
      // weight: json['weight'],
    );
  }

  // bool isSameSurah(SurahModel surah) {
  //   return name == (surah.name);
  // }
}

// enum Weight { full, half, quarter }
