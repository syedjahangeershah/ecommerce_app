void main() async {
  print(a(1));
}

String a(int supplementMedTimeOfDayId) {
  final list = [{}];
  for (int i = 0; i < list.length; i++) {
    if (list[i]['supplement_med_time_of_day_id'] == supplementMedTimeOfDayId) {
      return list[i]['time_of_day_name'];
    }
  }
  return 'null';
}