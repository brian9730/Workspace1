void main() {
  var input = '2025-03-11'; // 입력값
  var date = DateTime.parse(input); // 입력 문자열을 DateTime 객체로 변환
  var weekdays = ['월', '화', '수', '목', '금', '토', '일']; // 요일 배열
  print(weekdays[date.weekday - 1]); // 요일 출력 date.weekday를 이용해 날짜의 요일(월, 화, 수 등)을 숫자로 가져옴  
}
