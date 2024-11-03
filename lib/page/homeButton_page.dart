import 'package:flutter/material.dart';
import 'package:capston/page/carDetail_page.dart';

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

          // 최근 검색한 차량 섹션
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '최근 검색한 차량',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150, // 가로 스크롤 리스트 높이 지정
            child: ListView(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              children: [
                buildCarItem(context, '제네시스 G80', 'https://cdn.hankyung.com/photo/202401/06.35551589.1.jpg'),
                buildCarItem(context, '현대 아반떼', 'https://res.heraldm.com/content/image/2024/05/11/20240511050016_0.jpg'),
                buildCarItem(context, '기아 쏘렌토', 'https://www.kia.com/content/dam/kwp/kr/ko/vehicles/sorento/24pe/content/sorento_safety_lfa_hda_sm.jpg'),
                buildCarItem(context, 'BMW 320i', 'https://cdn.top-rider.com/news/photo/202003/28873_107726_842.jpg'),
                buildCarItem(context, '벤츠 E-Class', 'https://i.namu.wiki/i/6SGvjx4StCUe4Nzu8Cvgc_romqByXaqwQd6wUVJRI1CHf7b6O80xpe_o-RpugZCxHsa9X9ahwivdADvM6Yspsw.webp'),
              ],
            ),
          ),

          SizedBox(height: 20.0), // 여백 추가

          // 맞춤형 추천 차량 섹션
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '내가 관심 있을 만한 차량 추천',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150, // 가로 스크롤 리스트 높이 지정
            child: ListView(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              children: [
                buildCarItem(context, '현대 캐스퍼', 'https://contents-cdn.viewus.co.kr/image/2024/07/CP-2023-0096/image-b868c07a-8a04-44cc-9f07-a591905a3680.jpeg'),
                buildCarItem(context, '현대 쏘나타 디엣지', 'https://i.namu.wiki/i/48AmSGHd7s9-Vov2VuWOhMK1sC-NnPsDOwsWb-jNnvLc-EOy2ay2gjIs2aoL-GrylnEnOE9rEeL_P7YfxFDmoA.webp'),
                buildCarItem(context, '기아 k5', 'https://i.namu.wiki/i/AbegGaJhwDZkGgjv1_qvBN-SB4YdVWMgC9PN_JKPyz_hy8sfzgv_GOrkUWJ0hOvGOAULb9fvND79ZM2WocgtQK50Sm1d2otoavVEGX6WxIJcvqkb71JrcDTriEykKBldfBlb2GMV4Y1LpkGqs_6zJw.webp'),
                buildCarItem(context, '기아 k8', 'https://i.namu.wiki/i/28lgcdzUQRdFHt44yosn6iADzenfuD36D8PzoOwuqWS-1dK__qGIClDCrLJFCW9MNwCA0W5DxBrzVQyOXcIgFA.webp'),
                buildCarItem(context, '현대 그랜저', 'https://i.namu.wiki/i/wkefWbpUvEIQO59-Y3Vdnbyk38YIrl6Dcnbf4MUjR7VQnkY4jaSUJJiq6iuBlSXd0OhBROER4E71r-5UNVS9ormzXfLryPUaMRmVi2_cvqEqaQvGSfKJqJ_n-RDtGfS1zzL7AFYkQ0pO1Awy249QiA.webp'),
              ],
            ),
          ),
          SizedBox(height: 20.0), // 여백 추가

          // 맞춤 중고차 정보 섹션
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '맞춤형 중고차 정보',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100, // 높이를 적절히 설정
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              child: Row(
                children: [
                  buildCarCard(
                  context,
                  '현대 LF 쏘나타(2017년식)',
                  '약 1,010만 원 ~ 1,440만 원',
                  '4.8 (123명)',
                  'https://dzqerse1lankl.cloudfront.net/carsdata/idb/SU/2262.jpg',
                  ),
                  buildCarCard(
                    context,
                    '아반떼 6세대(2018년식)',
                    '약 700만 원 ~ 1,300만 원',
                    '4.6 (98명)',
                    'https://i.namu.wiki/i/6Qe-qb3mpFqyPDdCKHVKPuTMOGvKrXU5bwjDDm32pgXhFsZ0UerCKkwnDng-_pAmlU2b-EF_FzVcxkl4pJKYLw.webp',
                  ),
                  buildCarCard(
                    context,
                    '제네시스 G80(2020년식)',
                    '약 3,950만 원 ~ 4,401만 원',
                    '4.9 (210명)',
                    'https://www.genesis.com/content/dam/genesis-p2/kr/admin/board-management/pr-center/media-gallery/20210416/cs-pr-center-genesis-g80-03-1080-pc-mo.jpg',
                  ),
                  buildCarCard(
                    context,
                    '기아 레이(2022년식)',
                    '약 1,213만 원 ~ 1,805만 원',
                    '4.7 (189명)',
                    'https://cdn.autotribune.co.kr/news/photo/202107/5633_33978_5116.jpg',
                  ),
                  buildCarCard(
                    context,
                    '싼타페 5세대(2023년식)',
                    '약 3,380만 원 ~ 4,620만 원',
                    '4.5 (76명)',
                    'https://cfnimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20230718085103026607de3572ddd611027288.jpg&nmt=18',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.0), // 여백 추가

          // 차량 구매 TOP 섹션
          CarPurchaseTopPage()
        ],
      ),
    );
  }

  // 개별 차량 위젯 생성 함수(차량 이미지, 차량 이름)
  Widget buildCarItem(BuildContext context, String carName, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          // CarDetailPage로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetailPage(),
            ),
          );
        },
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
      ),
    );
  }

  // 개별 차량 정보를 받아 카드 UI를 생성하는 함수(차량 이미지, 차량 이름, 차량 시세, 별점 점수)
  Widget buildCarCard(BuildContext context, String carName, String price, String rating, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 300, // 아이템의 가로 크기 설정
        decoration: BoxDecoration(
          color: Colors.white, // 카드 배경색
          borderRadius: BorderRadius.circular(8.0), // 테두리 모서리를 둥글게
          border: Border.all(
            color: Colors.grey.shade400, // 테두리 색상 설정
            width: 1.0, // 테두리 두께 설정
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                ),
              ),
              SizedBox(width: 10), // 이미지와 텍스트 간 간격
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3),
                    Text(
                      carName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text(rating),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

// 차량 구매 TOP 3
class CarPurchaseTopPage extends StatelessWidget {
  // 차량 정보를 담은 리스트
  final List<Map<String, dynamic>> carData = [
    {
      'rank': 1,
      'name': '현대 그랜저 HG 모델',
      'imageUrl': 'https://i.namu.wiki/i/Yw5SlOO8aIK0GKPEhwjhIqcKRLP9fDIMP-9dvdwSXeuOmDJ_F4c1imbVA94oRpaNiR2WcverTBMxFU3oXEz1rQ.webp',
      'price': '약 896만 원 ~',
      'rating': '4.8 (523명)',
    },
    {
      'rank': 2,
      'name': '기아 카니발',
      'imageUrl': 'https://jasonryu.net/wp-content/uploads/2021/07/2022-kia-carnival-hi-limousine-4-seater-01.jpg?w=1024',
      'price': '약 2,631만 원 ~',
      'rating': '4.6 (412명)',
    },
    {
      'rank': 3,
      'name': '벤츠 E-Class(W213)',
      'imageUrl': 'https://i.namu.wiki/i/MHWRQ95YkvcziNj0lFjXK6eszjpVXGr6Mvwch72-cVlbd4kU2fHqjn6Stdj86AACTPC8HkqIj5P6D5SzDyhG8yQTRMDxb93V_WmEIkNDf6S9KnUWKym9UnPfMPj1ploc7CV8U_pQXZNZ5dCRfwOaZg.webp',
      'price': '약 3,290만 원 ~',
      'rating': '4.9 (678명)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Text(
              '차량 구매 TOP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Text(
              '최근 한 달간 구매 많은 순 추천',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // 부모의 스크롤을 따르도록 설정
            itemCount: carData.length, // 리스트의 길이
            itemBuilder: (context, index) {
              final car = carData[index];
              return Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0), // 테두리 둥글기 설정
                            child: Image.network(
                              car['imageUrl'], // 차량 이미지 URL
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 3,
                            top: 3,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              radius: 12,
                              child: Text(
                                '${car['rank']}', // 순위 표시
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10), // 이미지와 텍스트 간의 간격 조정
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['name'], // 차량 이름
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow, size: 16),
                                Text(' ${car['rating']}'), // 평점
                              ],
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end, // 텍스트를 우측 정렬
                              children: [
                                Text(
                                  car['price'], // 차량 가격
                                  style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              );
            },
          ),
        ],
      ),
    );
  }
}

