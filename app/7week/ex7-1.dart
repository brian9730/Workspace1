import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 데이터 정의
final menuItems = [
  {'icon': Icons.local_taxi, 'label': '택시'},
  {'icon': Icons.local_taxi, 'label': '블랙'},
  {'icon': Icons.local_taxi, 'label': '바이크'},
  {'icon': Icons.local_taxi, 'label': '대리'},
];

final carouselItems = [
  'https://cdn.pixabay.com/photo/2018/11/12/18/44/thanksgiving-3811492_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/10/30/15/33/tajikistan-4589831_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/11/25/16/15/sfari-4652364_1280.jpg',
];

final noticeItems = List.generate(10, (i) => '[이벤트] 이것은 공지사항입니다');

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final _pages = [Page1(), Page2(), Page3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('복잡한 UI'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: [
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '이용서비스', icon: Icon(Icons.assignment)),
          BottomNavigationBarItem(label: '내 정보', icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}

// 홈 화면
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MenuGrid(menuItems: menuItems),
        ImageCarousel(items: carouselItems),
        NoticeList(notices: noticeItems),
      ],
    );
  }
}

// 메뉴 그리드 위젯
class MenuGrid extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;

  MenuGrid({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    final rows = List.generate(2, (row) {
      final rowItems = menuItems.skip(row * 4).take(4).toList();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems.map((item) {
          return GestureDetector(
            onTap: () => print('${item['label']} 클릭'),
            child: Column(
              children: [
                Icon(item['icon'], size: 40),
                Text(item['label']),
              ],
            ),
          );
        }).toList()
          ..addAll(List.generate(4 - rowItems.length, (_) => Opacity(opacity: 0.0, child: Icon(Icons.local_taxi, size: 40)))),
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: rows
            .expand((row) => [row, SizedBox(height: 20)])
            .toList()
          ..removeLast(),
      ),
    );
  }
}

// 캐러셀 위젯
class ImageCarousel extends StatelessWidget {
  final List<String> items;

  ImageCarousel({required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 150, autoPlay: true),
      items: items.map((url) {
        return Builder(
          builder: (context) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(url, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// 공지 리스트 위젯
class NoticeList extends StatelessWidget {
  final List<String> notices;

  NoticeList({required this.notices});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: notices
          .map((notice) => ListTile(
                leading: Icon(Icons.notifications_none),
                title: Text(notice),
              ))
          .toList(),
    );
  }
}

// 기타 페이지
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('이용서비스', style: TextStyle(fontSize: 40)));
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('내 정보', style: TextStyle(fontSize: 40)));
  }
}
