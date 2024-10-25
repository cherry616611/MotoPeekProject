import 'package:flutter/material.dart';

class ReviewButtonPage extends StatelessWidget {
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