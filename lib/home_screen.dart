import 'package:flutter/material.dart';
import 'package:capston/camera_vision_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SearchPage(),
    ReviewPage(), // 차량 리뷰 게시글 페이지
    WishListPage(),
    NoticePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        title: Text("Moto Peek!"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My',
          ),
        ],
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 차량 리뷰 게시글을 리스트로 표시 (예시)
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        PostCard(
          imageUrl: 'https://jmagazine.joins.com/_data/photo/2020/04/3698936108_gHdfGr42_1.jpg',
          userName: 'User1',
          review: '이 차는 정말 훌륭해요!',
          carModel: "제네시스 G80",
        ),
        PostCard(
          imageUrl: 'https://www.hyundai.co.kr/image/upload/asset_library/MDA00000000000033027/bebeb59b7c7447f7be0a1f8238821cce.jpg',
          userName: 'User2',
          review: '연비가 좋고 디자인이 예뻐요.',
          carModel: "현대 더 뉴 아반떼",
        ),
        // 더 많은 게시글 추가
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String review;
  final String carModel;

  PostCard({required this.imageUrl, required this.userName, required this.review, required this.carModel,});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('차종: $carModel', style: TextStyle(fontSize: 16, color: Colors.grey)), // 차종 정보 표시
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(review),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CameraScreen(), // CameraScreen을 body로 설정
    );
  }
}

class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Wish List Page'));
  }
}

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notice Page'));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}