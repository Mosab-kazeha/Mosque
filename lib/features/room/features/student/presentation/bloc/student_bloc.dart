import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import 'package:saas_mosque/features/room/features/student/data/repositories/student_repo.dart';
import '../../../../data/model/student_model.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepo _studentRepo;

  StudentBloc(StudentRepo studentRepo)
    : _studentRepo = studentRepo,
      super(StudentInitial()) {
    on<GetStudentAttendance>((event, emit) async {
      emit(StudentAttendanceLoading());
      (await _studentRepo.fetchAttendance(studentId: event.studentId)).fold(
        (l) => emit(StudentAttendanceFailure(message: l.errorMessege)),
        (r) => emit(StudentAttendanceSuccess(student: r)),
      );
    });
    on<GetStudentInfo>((event, emit) async {
      emit(StudentInfoLoading());
      (await _studentRepo.fetchStudentById(studentId: event.studentId)).fold(
        (l) => emit(StudentInfoFailure(message: l.errorMessege)),
        (r) => emit(StudentInfoSuccess(student: _getStudentInfo(student: r))),
      );
    });
    on<GetStudentSavingSessions>((event, emit) async {
      emit(StudentSavingSessionsLoading());
      (await _studentRepo.fetchSavingSessions(studentId: event.studentId)).fold(
        (l) => emit(StudentSavingSessionsFailure(message: l.errorMessege)),
        (r) => emit(StudentSavingSessionsSuccess(sessions: r)),
      );
    });
  }
}

List<Map> _getStudentInfo({required StudentModel student}) {
  String formatEducationalClass(int value) {
    if (value == 12) return 'بكالوريا';
    if (value > 12) return 'جامعة';
    const classes = [
      '',
      'الصف الأول',
      'الصف الثاني',
      'الصف الثالث',
      'الصف الرابع',
      'الصف الخامس',
      'الصف السادس',
      'الصف السابع',
      'الصف الثامن',
      'الصف التاسع',
      'الصف العاشر',
      'الصف الحادي عشر',
      'الصف الثاني عشر',
    ];
    if (value >= 1 && value <= 12) return classes[value];
    return value.toString();
  }

  String formatParentStatus(String status) {
    switch (status) {
      case 'ALIVE':
        return 'موجود';
      case 'MISSED':
        return 'مفقود';
      case 'DEAD':
        return 'متوفى';
      default:
        return status;
    }
  }

  String formatMarriageStatus(String status) {
    switch (status) {
      case 'DEVORCED':
        return 'مطلقان';
      case 'MARRIED':
        return 'متزوجان';
      default:
        return status;
    }
  }

  String formatBirthDate(String? iso) {
    if (iso == null || iso.isEmpty) return '-';
    try {
      final date = DateTime.parse(iso);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return iso;
    }
  }

  final info = [
    {'label': 'الاسم الأول', 'value': student.firstName},
    {'label': 'اسم العائلة', 'value': student.lastName},
    {'label': 'اسم المسجد الحالي', 'value': student.currentMosqueName},
    {
      'label': 'الصف الدراسي',
      'value': formatEducationalClass(student.educationalClass),
    },
    {'label': 'تاريخ الميلاد', 'value': formatBirthDate(student.birthDate)},
    {'label': 'رقم جوال الطالب', 'value': student.studentMobile},
    {'label': 'المدرسة', 'value': student.school},
    {'label': 'الحالة الصحية', 'value': student.studentHealthStatus},
    {'label': 'موهبة خاصة', 'value': student.specialTalent},
    {'label': 'اسم الأب', 'value': student.fatherName},
    {'label': 'حالة الأب', 'value': formatParentStatus(student.fatherStatus)},
    {'label': 'وظيفة الأب', 'value': student.fatherJob},
    {'label': 'مستوى دخل الأب', 'value': student.fatherIncomeLevel},
    {'label': 'مستوى تعليم الأب', 'value': student.fatherEducationLevel},
    {'label': 'الحالة الصحية للأب', 'value': student.fatherHealthStatus},
    {'label': 'رقم جوال الأب', 'value': student.fatherPhoneNumber},
    {'label': 'اسم الأم', 'value': student.motherName},
    {'label': 'حالة الأم', 'value': formatParentStatus(student.motherStatus)},
    {'label': 'وظيفة الأم', 'value': student.motherJob},
    {'label': 'مستوى دخل الأم', 'value': student.motherIncomeLevel ?? '-'},
    {'label': 'مستوى تعليم الأم', 'value': student.motherEducationLevel},
    {'label': 'الحالة الصحية للأم', 'value': student.motherHealthStatus},
    {'label': 'رقم جوال الأم', 'value': student.motherPhoneNumber},
    {
      'label': 'الحالة الاجتماعية للأبوين',
      'value': formatMarriageStatus(student.parentMaritalStatus),
    },
    {'label': 'عدد الأجزاء المحفوظة', 'value': student.preservedParts},
    {
      'label': 'الأجزاء المختبرة من الأوقاف',
      'value': student.partsTestedByTheEndowments,
    },
  ];
  return info;
}
