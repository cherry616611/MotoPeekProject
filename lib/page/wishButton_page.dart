import 'package:flutter/material.dart';

class WishButtonPage extends StatelessWidget {
  final List<Map<String, dynamic>> cars = [
    {
      'image': 'https://www.heydealer.com/blog/wp-content/uploads/2023/07/1850095711_DTPRtOhJ_1-1.jpg', // 웹 이미지 주소
      'company': '현대',
      'model': 'LF 소나타',
      'likes': 105,
      'rating': 4.5,
    },
    {
      'image': 'https://dimg.donga.com/wps/NEWS/IMAGE/2013/10/14/58194939.2.jpg',
      'company': '기아',
      'model': '올 뉴 쏘울',
      'likes': 220,
      'rating': 4.8,
    },
    {
      'image': 'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_uyh_a.png.thumb.1280.720.png',
      'company': '제네시스',
      'model': 'G80',
      'likes': 340,
      'rating': 4.9,
    },
    // 더 많은 차량 데이터를 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Wish List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 한 줄에 두 개의 아이템을 표시
            crossAxisSpacing: 8.0, // 아이템 간 가로 간격
            mainAxisSpacing: 8.0, // 아이템 간 세로 간격
            childAspectRatio: 0.95, // 카드의 가로 세로 비율 조정
          ),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            return Card(
              color: Colors.white,
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      car['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${car['company']}', style: TextStyle(fontSize: 13)),
                        Text('${car['model']}', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 16),
                            SizedBox(width: 4),
                            Text('${car['likes']}'),
                            SizedBox(width: 10),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text('${car['rating']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
