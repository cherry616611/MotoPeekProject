import 'package:capston/page/profileButton_page.dart';
import 'package:capston/page/wishButton_page.dart';
import 'package:flutter/material.dart';
import 'package:capston/camera_vision_controller.dart';
import 'package:capston/page/homeButton_page.dart';
import 'package:capston/page/reviewButton_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),       // 메인 홈 페이지
    SearchPage(),     // 카메라 차량검색 페이지
    ReviewPage(),     // 차량 리뷰 게시글 페이지
    WishListPage(),   // 위시리스트 페이지
    ProfilePage(),    //개인 페이지
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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
            icon: Icon(Icons.person),
            label: 'My',
          ),
        ],
      ),
    );
  }
}

// 홈 페이지
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(""),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: HomeButtonPage(), // HomeButtonPage를 body로 설정
    );
  }
}

// 카메라 차량검색 페이지
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CameraScreen(), // CameraScreen을 body로 설정
    );
  }
}

// 사용자 리뷰 페이지
class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: null,
      body: ReviewButtonPage(), // reviewButtonPage를 body로 설정
    );
  }
}

// 위시리스트 페이지
class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: null,
      body: WishButtonPage(), // reviewButtonPage를 body로 설정
    );
  }
}

// 개인 페이지
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: null,
      body: ProfileButtonPage(), // reviewButtonPage를 body로 설정
    );
  }
}