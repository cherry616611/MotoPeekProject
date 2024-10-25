import 'package:flutter/material.dart';

class HomeButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 타이틀 이미지
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset('assets/title_image.png'), // title_image 추가
          ),
          SizedBox(height: 10.0), // 이미지 아래 여백 추가

          SearchBar(), // 차량 검색창

          // 최근 검색한 차량 제목
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '최근 검색한 차량',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

        // 최근 검색한 차량 리스트 가로 스크롤
          Container(
            height: 150, // 가로 스크롤 리스트 높이 지정
            child: ListView(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              children: [
                buildCarItem(
                  context,
                  '제네시스 G80',
                  'https://img.danawa.com/cp_images/service/33/5492340/a79a3779.jpg',
                ),
                buildCarItem(
                  context,
                  '현대 아반떼',
                  'https://res.heraldm.com/content/image/2024/05/11/20240511050016_0.jpg',
                ),
                buildCarItem(
                  context,
                  '기아 쏘렌토',
                  'https://www.kia.com/content/dam/kwp/kr/ko/vehicles/sorento/24pe/content/sorento_safety_lfa_hda_sm.jpg',
                ),
                buildCarItem(
                  context,
                  'BMW 320i',
                  'https://cdn.top-rider.com/news/photo/202003/28873_107726_842.jpg',
                ),
                buildCarItem(
                  context,
                  '벤츠 E-Class',
                  'https://i.namu.wiki/i/6SGvjx4StCUe4Nzu8Cvgc_romqByXaqwQd6wUVJRI1CHf7b6O80xpe_o-RpugZCxHsa9X9ahwivdADvM6Yspsw.webp',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 개별 차량 위젯 생성 함수
  Widget buildCarItem(BuildContext context, String carName, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 설정
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            carName,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// 검색창 생성 함수
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '어떤 차량을 검색 할까요?',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.black, // 테두리 색상 투명
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.black, // 선택 시 테두리 색상 투명
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}