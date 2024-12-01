import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewButtonPage extends StatefulWidget {
  @override
  _ReviewButtonPageState createState() => _ReviewButtonPageState();
}

class _ReviewButtonPageState extends State<ReviewButtonPage> {
  int _currentPage = 0; // 이미지 슬라이더 현재 페이지
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Reviews',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cars').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('리뷰가 없습니다.'),
            );
          }

          final carDocuments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: carDocuments.length,
            itemBuilder: (context, carIndex) {
              final carDoc = carDocuments[carIndex];
              final carId = carDoc.id;
              final carName = carDoc['name'];

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cars')
                    .doc(carId)
                    .collection('reviews')
                    .snapshots(),
                builder: (context, reviewSnapshot) {
                  if (reviewSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox.shrink();
                  }

                  if (!reviewSnapshot.hasData ||
                      reviewSnapshot.data!.docs.isEmpty) {
                    return SizedBox.shrink();
                  }

                  final reviews = reviewSnapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...reviews.map((reviewDoc) {
                        final review = reviewDoc.data() as Map<String, dynamic>;

                        // 이미지 URL 리스트 구성
                        final List<String> imageUrls = [];
                        for (int i = 1; i <= 3; i++) {
                          if (review['imageUrl_$i'] != null) {
                            imageUrls.add(review['imageUrl_$i']);
                          }
                        }

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
                                    review['user'] ?? 'Unknown User',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                // 차량 모델 이름, 컬러 옵션, 별점
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                  child: Row(
                                    children: [
                                      // 차량 모델 이름
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          review['modelName'] ?? 'N/A',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      // 컬러 옵션
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          review['colorOption'] ?? 'N/A',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      // 별점
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            SizedBox(width: 4),
                                            Text(review['rating'] ?? '0'),
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
                                    StatefulBuilder(
                                      builder: (context, setState) {
                                        int _currentPage = 0; // 슬라이더 내부에서 관리되는 현재 페이지 상태
                                        final PageController _pageController = PageController();

                                        return Column(
                                          children: [
                                            Container(
                                              height: 300, // 이미지 높이 조절
                                              child: PageView.builder(
                                                controller: _pageController,
                                                itemCount: imageUrls.length,
                                                onPageChanged: (index) {
                                                  // setState로 현재 페이지 상태를 업데이트
                                                  setState(() {
                                                    _currentPage = index;
                                                  });
                                                },
                                                itemBuilder: (context, index) {
                                                  return Image.network(
                                                    imageUrls[index],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Center(
                                                        child: Icon(Icons.broken_image, size: 50),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // Dot Indicator: 현재 페이지 표시
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: List.generate(imageUrls.length, (index) {
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
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                // 좋아요 수, 댓글 수
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 3.0),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.favorite,
                                              color: Colors.red, size: 20),
                                          SizedBox(width: 4),
                                          Text('30'), // 좋아요 수 (임의 데이터)
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.comment,
                                              color: Colors.grey, size: 20),
                                          SizedBox(width: 4),
                                          Text('8'), // 댓글 수 (임의 데이터)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // 작성글
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: Text(review['text'] ?? ''),
                                ),
                                // 작성일
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 8.0),
                                  child: Text(
                                    review['date'] ?? '',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              );
            },
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
