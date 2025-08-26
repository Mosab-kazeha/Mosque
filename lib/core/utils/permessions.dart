// ignore_for_file: constant_identifier_names

import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Permessions {
  STUDENT_MANAGEMENT,
  SAVING_SESSION_MANAGEMENT,
  ALL_SAVING_SESSION_MANAGEMENT,
  ATTENDANCE_MANAGEMENT,
  ALL_ATTENDANCE_MANAGEMENT,
  CIRRUCULUM_MANAGEMENT,
  ALL_CIRRUCULUM_MANAGEMENT,
  POINTS_MANAGEMENT,
  ALL_POINTS_MANAGEMENT,
  AWARDS_MANAGEMENT,
  // TEACHER_MANAGEMENT,
  // ROLES_MANAGEMENT,
  // SETTINGS_MANAGEMENT,
  // ACCESS_DASHBOARD,
}

List<Permessions> getPermessionsList(List<String>? permessions) {
  final permessionsList = <Permessions>[];
  if (permessions != null) {
    for (String permession in permessions) {
      permessionsList.add(
        Permessions.values.firstWhere(
          (element) => element.name.toString() == permession,
        ),
      );
    }
  } else {
    final savedPermessions =
        serviceLocater.get<SharedPreferences>().getStringList('permessions')!;
    for (String permession in savedPermessions) {
      permessionsList.add(
        Permessions.values.firstWhere(
          (element) => element.name.toString() == permession,
        ),
      );
    }
  }

  return permessionsList;
}
