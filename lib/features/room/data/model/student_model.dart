class StudentModel {
  final int id;
  final String currentMosqueName;
  final int educationalClass;
  final String firstName;
  final String lastName;
  final String? birthDate;
  final String studentMobile;
  final String school;
  final bool inAnotherMosque;
  final String? otherMosqueNames;
  final String studentHealthStatus;
  final String specialTalent;
  final String fatherName;
  final String fatherStatus;
  final String fatherJob;
  final String fatherIncomeLevel;
  final String fatherEducationLevel;
  final String fatherHealthStatus;
  final String fatherPhoneNumber;
  final String? fatherWorkNumber;
  final String motherName;
  final String motherStatus;
  final String motherJob;
  final String? motherIncomeLevel;
  final String motherEducationLevel;
  final String motherHealthStatus;
  final String motherPhoneNumber;
  final String? motherHomeNumber;
  final String parentMaritalStatus;
  final String? studentMobileNumber;
  final String? studentHomeNumber;
  final String? originalResidenceAddressArea;
  final String? originalResidenceAddressStreet;
  final String? originalResidenceAddressBuilding;
  final String? originalResidenceAddressFloor;
  final String? currentResidenceAddressArea;
  final String? currentResidenceAddressStreet;
  final String? currentResidenceAddressBuilding;
  final String? currentResidenceAddressFloor;
  final String preservedParts;
  final String partsTestedByTheEndowments;
  final String? imageUrl;
  final String password;
  final String createdAt;
  final String updatedAt;

  StudentModel({
    required this.id,
    required this.currentMosqueName,
    required this.educationalClass,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.studentMobile,
    required this.school,
    required this.inAnotherMosque,
    required this.otherMosqueNames,
    required this.studentHealthStatus,
    required this.specialTalent,
    required this.fatherName,
    required this.fatherStatus,
    required this.fatherJob,
    required this.fatherIncomeLevel,
    required this.fatherEducationLevel,
    required this.fatherHealthStatus,
    required this.fatherPhoneNumber,
    required this.fatherWorkNumber,
    required this.motherName,
    required this.motherStatus,
    required this.motherJob,
    required this.motherIncomeLevel,
    required this.motherEducationLevel,
    required this.motherHealthStatus,
    required this.motherPhoneNumber,
    required this.motherHomeNumber,
    required this.parentMaritalStatus,
    required this.studentMobileNumber,
    required this.studentHomeNumber,
    required this.originalResidenceAddressArea,
    required this.originalResidenceAddressStreet,
    required this.originalResidenceAddressBuilding,
    required this.originalResidenceAddressFloor,
    required this.currentResidenceAddressArea,
    required this.currentResidenceAddressStreet,
    required this.currentResidenceAddressBuilding,
    required this.currentResidenceAddressFloor,
    required this.preservedParts,
    required this.partsTestedByTheEndowments,
    required this.imageUrl,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? 0,
      currentMosqueName: json['current_mosque_name'] ?? '',
      educationalClass: json['educational_class'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthDate: json['birth_date'],
      studentMobile: json['student_mobile'] ?? '',
      school: json['school'] ?? '',
      inAnotherMosque: json['in_another_mosque'] ?? false,
      otherMosqueNames: json['other_mosque_names'],
      studentHealthStatus: json['student_health_status'] ?? '',
      specialTalent: json['special_talent'] ?? '',
      fatherName: json['father_name'] ?? '',
      fatherStatus: json['father_status'] ?? '',
      fatherJob: json['father_job'] ?? '',
      fatherIncomeLevel: json['father_income_level'] ?? '',
      fatherEducationLevel: json['father_education_level'] ?? '',
      fatherHealthStatus: json['father_health_status'] ?? '',
      fatherPhoneNumber: json['father_phone_number'] ?? '',
      fatherWorkNumber: json['father_work_number'],
      motherName: json['mother_name'] ?? '',
      motherStatus: json['mother_status'] ?? '',
      motherJob: json['mother_job'] ?? '',
      motherIncomeLevel: json['mother_income_level'],
      motherEducationLevel: json['mother_education_level'] ?? '',
      motherHealthStatus: json['mother_health_status'] ?? '',
      motherPhoneNumber: json['mother_phone_number'] ?? '',
      motherHomeNumber: json['mother_home_number'],
      parentMaritalStatus: json['parent_marital_status'] ?? '',
      studentMobileNumber: json['student_mobile_number'],
      studentHomeNumber: json['student_home_number'],
      originalResidenceAddressArea: json['original_residence_address_area'],
      originalResidenceAddressStreet: json['original_residence_address_street'],
      originalResidenceAddressBuilding:
          json['original_residence_address_building'],
      originalResidenceAddressFloor: json['original_residence_address_floor'],
      currentResidenceAddressArea: json['current_residence_address_area'],
      currentResidenceAddressStreet: json['current_residence_address_street'],
      currentResidenceAddressBuilding:
          json['current_residence_address_building'],
      currentResidenceAddressFloor: json['current_residence_address_floor'],
      preservedParts: json['preserved_parts'] ?? '',
      partsTestedByTheEndowments: json['parts_tested_by_the_endowments'] ?? '',
      imageUrl: json['image_url'],
      password: json['password'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
