enum AttendanceEnumStatus { attend, miss, delay, notTaken }

extension AttendanceEnumHelper on AttendanceEnumStatus {
  String get apiStatus => toString().split('.').last;

  int get delay {
    switch (this) {
      case AttendanceEnumStatus.attend:
      case AttendanceEnumStatus.miss:
      case AttendanceEnumStatus.notTaken:
        return 0;
      case AttendanceEnumStatus.delay:
        return 5;
    }
  }

  static AttendanceEnumStatus fromDelay(int delay) {
    if (delay == 0) return AttendanceEnumStatus.attend;
    if (delay == 1000) return AttendanceEnumStatus.miss;
    if (delay > 0 && delay <= 90) return AttendanceEnumStatus.delay;
    return AttendanceEnumStatus.notTaken;
  }
}
