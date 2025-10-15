abstract final class EndPoint {
  static const login = '/auth/login/teacher';
  static const profile = '/auth/profile';
  static const home = '/teachers/mobile/';
  static const campaigns = '/campaigns/my-campaigns';
  static const groups = '/groups/my-groups';
  static const getAttendance = '/attendance/batch-update';
  static const startListeningSession = '/start-listening-session';
  static const fetchListeningData = '/saving-sessions/filter';
  static String studentAttendance({
    required int groupId,
    required int studentId,
  }) {
    return '/attendance/group/$groupId/student/$studentId';
  }

  static const studentInfo = '/students/';
  static const myPermessions = '/auth/my-permissions';
  static const evaluations = '/evaluations';
  static const endSession = '/saving-sessions';
  static String fetchMistakes(int campaignId) {
    return '/mistakes/campaign/$campaignId';
  }

  static const fetchSurahs = '/session-surahs/surahs';
  static const fetchSurahTemplates = '/session-surahs/templates/surah';
  // static const fetchSurahsTemplates = 'https://api.alquran.cloud/v1/surah';

  static String getCurriculumTemplates(int groupId) {
    return '/curriculum-template/group/$groupId';
  }

  static const createLessonSession = '/curriculum-lesson-session';
}
