import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final dummyItems = [
  'https://cdn.pixabay.com/photo/2018/11/12/18/44/thanksgiving-3811492_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/10/30/15/33/tajikistan-4589831_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/11/25/16/15/sfari-4652364_1280.jpg',
];

void main() {
  runApp(MyApp());
}

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _pages = [Page1(), Page2(), Page3()]; // 페이지들 선언을 수정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('복잡한 UI'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_index], // 페이지 변경 시 _pages 사용
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '이용서비스', icon: Icon(Icons.assignment)),
          BottomNavigationBarItem(
            label: '내 정보',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[_buildTop(), _buildMiddle(), _buildBottom()],
    );
  }

  Widget _buildTop() {
    return Padding(
      padding: const EdgeInsets.all(16.0), // 전체 여백 추가
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('택시 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('택시'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('블랙 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('블랙'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('바이크 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('바이크'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('대리 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('대리'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // 두 줄 사이에 여백 추가
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('택시 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('택시'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('블랙 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('블랙'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('바이크 클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.local_taxi, size: 40),
                    Text('바이크'),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.0, // 이 부분은 여전히 보이지 않게 처리됩니다.
                child: GestureDetector(
                  onTap: () {
                    print('택시 클릭');
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.local_taxi, size: 40),
                      Text('택시'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
      ),
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,  // BoxFit.cover로 수정
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom() {
    final items = List.generate(10, (i) {
      return ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[이벤트] 이것은 공지사항입니다'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: items,
    );
  }
}

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
