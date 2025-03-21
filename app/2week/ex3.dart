void main() {
  // 날짜를 문자열로 변수에 저장
  var input = '2025-03-11';

  // 입력값을 '-'를 기준으로 분리
  List<String> parts = input.split('-');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);

  // DateTime 객체로 요일 계산
  DateTime date = DateTime(year, month, day);

  // 요일 배열
  List<String> weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

  // 결과 출력
  print('${weekdays[date.weekday - 1]}');
}