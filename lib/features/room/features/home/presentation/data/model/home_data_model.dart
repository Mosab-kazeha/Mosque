import 'package:saas_mosque/features/room/features/home/presentation/data/model/group_model.dart';

class HomeDataModel {
  final int id;
  final String? educationalLevel;
  final String? universityName;
  final String? collegeName;
  final String firstName;
  final String lastName;
  final String? birthDate;
  final String mobilePhoneNumber;
  final bool? inAnotherMosque;
  final String? otherMosqueNames;
  final String? specialTalent;
  final String? fatherName;
  final String? currentResidenceAddressArea;
  final String? currentResidenceAddressStreet;
  final String? currentResidenceAddressBuilding;
  final String? preservedParts;
  final String? partsTestedByTheEndowments;
  final String? imageUrl;
  final bool? isMojaz;
  final bool? isWorking;
  final String? jobRole;
  final String? workplaceName;
  final String password;
  final String role;
  final String createdAt;
  final String updatedAt;
  final List<GroupModel> groups;

  HomeDataModel({
    required this.id,
    this.educationalLevel,
    this.universityName,
    this.collegeName,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    required this.mobilePhoneNumber,
    this.inAnotherMosque,
    this.otherMosqueNames,
    this.specialTalent,
    this.fatherName,
    this.currentResidenceAddressArea,
    this.currentResidenceAddressStreet,
    this.currentResidenceAddressBuilding,
    this.preservedParts,
    this.partsTestedByTheEndowments,
    this.imageUrl,
    this.isMojaz,
    this.isWorking,
    this.jobRole,
    this.workplaceName,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.groups,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      id: json['id'] ?? 0,
      educationalLevel: json['educational_level'] as String?,
      universityName: json['university_name'] as String?,
      collegeName: json['college_name'] as String?,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthDate: json['birth_date'] as String?,
      mobilePhoneNumber: json['mobile_phone_number'] ?? '',
      inAnotherMosque: json['in_another_mosque'] as bool?,
      otherMosqueNames: json['other_mosque_names'] as String?,
      specialTalent: json['special_talent'] as String?,
      fatherName: json['father_name'] as String?,
      currentResidenceAddressArea:
          json['current_residence_address_area'] as String?,
      currentResidenceAddressStreet:
          json['current_residence_address_street'] as String?,
      currentResidenceAddressBuilding:
          json['current_residence_address_building'] as String?,
      preservedParts: json['preserved_parts'] as String?,
      partsTestedByTheEndowments:
          json['parts_tested_by_the_endowments'] as String?,
      imageUrl: json['image_url'] as String?,
      isMojaz: json['is_mojaz'] as bool?,
      isWorking: json['is_working'] as bool?,
      jobRole: json['job_role'] as String?,
      workplaceName: json['workplace_name'] as String?,
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      groups:
          (json['groups'] as List<dynamic>? ?? [])
              .map((e) => GroupModel.fromJson(e))
              .toList(),
    );
  }
}
