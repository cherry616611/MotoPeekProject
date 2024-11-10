import 'package:flutter/material.dart';

class ReviewButtonPage extends StatefulWidget {
  @override
  _ReviewButtonPageState createState() => _ReviewButtonPageState();
}

class _ReviewButtonPageState extends State<ReviewButtonPage> {
  int _currentPage = 0; // 현재 페이지 인덱스
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> reviews = [
    {
      'username': 'user1234',
      'imageUrls': [
        'https://www.testdrive.or.kr/files/attach/images/52626/114/413/004/5c6f92ec713cedf257dca055d103b620.jpg',
        'https://www.testdrive.or.kr/files/attach/images/52626/114/413/004/a0ee06ad56f6786a98d64f593dfe72fd.jpg',
        'https://www.testdrive.or.kr/files/attach/images/52626/114/413/004/b058ce015065ba146303f62feae04368.jpg',
      ],
      'colorOption': '플래티넘 골드',
      'rating': '4.5',
      'reviewText': '이 차량은 정말 좋습니다.',
      'date': '10월 26일',
      'modelName': '쏘울 부스터 EV',
    },
    // 다른 리뷰 추가 가능
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Review',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: (){
              // 검색 아이콘 클릭시 동작 추가
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 사용자 정보
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                          review['username'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                    ),
                  // 차량 모델 이름과 컬러 옵션 및 별점
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Row(
                      children: [
                        // 차량 모델 이름
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            review['modelName'],
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                          ),
                        ),
                        SizedBox(width: 8),
                        //컬러 옵션
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            review['colorOption'],
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                          ),
                        ),
                        SizedBox(width: 8),
                        // 별점
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(review['rating']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // 리뷰 이미지 가로 스크롤
                Column(
                  children: [
                    // PageView: 이미지 슬라이드
                    Container(
                      height: 300, // 이미지 높이 조절
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: review['imageUrls'].length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index; // 페이지 인덱스 업데이트
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            review['imageUrls'][index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    // Dot Indicator: 현재 페이지 표시
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(review['imageUrls'].length, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 12.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                  // 좋아요 수, 댓글 수
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
                    child: Row(
                      children: [
                        // 좋아요 수
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 20),
                            SizedBox(width: 4),
                            Text('30'), // 좋아요 수 (임의의 데이터)
                          ],
                        ),
                        SizedBox(width: 10),
                        // 댓글 수
                        Row(
                          children: [
                            Icon(Icons.comment, color: Colors.grey, size: 20),
                            SizedBox(width: 4),
                            Text('8'), // 댓글 수 (임의의 데이터)
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 작성글
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(review['reviewText']),
                  ),
                  // 작성일
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
                    child: Text(
                      review['date'],
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // 글쓰기 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글쓰기 버튼 클릭 시 동작 추가
        },
        backgroundColor: Colors.black, // 버튼 색상
        child: Icon(Icons.edit, color: Colors.white), // 아이콘 설정
      ),
    );
  }
}
