import 'package:flutter/material.dart';

class CarDetailPage extends StatefulWidget {
  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final String carName = '제네시스 G80';
  final String priceRange = '1,652 ~ 7,670만 원';
  // 초기 차량 이미지 URL
  String carImageUrl = 'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_uyh_a.png.thumb.1280.720.png';
  // 선택된 색상 인덱스
  int selectedColorIndex = 0;

  final List<String> carOptions = [
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_uyh_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_sss_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_ncm_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_ph3_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_ura_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_mdy_a.png.thumb.1280.720.png',
    'https://www.genesis.com/content/dam/genesis-p2/kr/bto/jj/a/jj_brn_a.png.thumb.1280.720.png',
  ];

  // 컬러 옵션 이미지
  final List<Color> colorOptions = [
    Color(0xFFFAFAFA),
    Color(0xFFE0E0E0),
    Color(0xFF616161),
    Color(0xFF212121),
    Color(0xFF006064),
    Color(0xFF263238),
    Color(0xFF3E2723)
    // 추가 색상 이미지 URL
  ];

  // 외장 컬러 이름
  final List<String> colorNames = [
    '우유니 화이트',
    '세빌 실버',
    '마칼루 그레이',
    '비크 블랙',
    '태즈먼 블루',
    '한라산 그린',
    '브루클린 브라운'
  ];

  final List<Map<String, dynamic>> newModelDetails = [
    {
      'model': 'G80',
      'release': '2024',
      'price': '5,890 ~ 6,830',
    },
    {
      'model': '일렉트리파이드 G80',
      'release': '2025',
      'price': '8,490',
    },
    // 추가 모델 정보
  ];

  final List<Map<String, dynamic>> usedModelDetails = [
    {
      'model': '일렉트리파이드\nG80 (RG3)',
      'release': '21년~현재',
      'price': '4,853 ~ 7,670',
    },
    {
      'model': 'G80 (RG3)',
      'release': '20년~현재',
      'price': '3,574 ~ 6,177',
    },
    {
      'model': 'G80',
      'release': '16년~20년',
      'price': '1,652 ~ 3,537',
    },
    // 추가 모델 정보
  ];

  final List<Map<String, dynamic>> rentModelDetails = [
    {
    'model': '2024년형 가솔린\n터보 2.5 AWD (A/T)',
    'release': '2023.12. 출시',
    'price': '412,984',
    },
  ];

  final List<Map<String, dynamic>> leaseModelDetails = [
    {
      'model': '2024년형 가솔린\n터보 2.5 AWD (A/T)',
      'release': '2023.12. 출시',
      'price': '367,000',
    },
  ];

  // 유지비 관련 데이터를 위한 예시 데이터 리스트
  final List<Map<String, String>> maintenanceData = [
    {
      'type': '총 예상 유지비',
      'value': '약 500~700만원/년',
      'description': '연간 총 예상 유지비입니다.',
    },
    {
      'type': '연비',
      'value': '10 km/l',
      'description': '평균 연비입니다.',
    },
    {
      'type': '자동차세',
      'value': '약 60~100만원/년',
      'description': '연간 예상 세금입니다.',
    },
    {
      'type': '보험료',
      'value': '약 100~200만원/년',
      'description': '연간 예상 보험료입니다.',
    },
    {
      'type': '타이어 교체',
      'value': '약 100~150만원',
      'description': '예상 교체 비용입니다.',
    },
    {
      'type': '점검 및 정비',
      'value': '약 10~30만원',
      'description': '1회 방문시 예상 정비비입니다.',
    },
  ];

  // 유튜브 영상 데이터
  List<Map<String, String>> videoData = [
    {
      'title': 'G80 | 제네시스 라이브러리 | 제네시스',
      'channel': '제네시스 코리아',
      'date': '2024.01.18',
      'videoId': 'QSPrNkyGdfo',  // 유튜브 영상 ID
    },
    {
      'title': '고가의 제네시스 G80이 모닝보다 잘 팔리는 이유! 중고차 감가 얼마나 심하길래..',
      'channel': '중고차의모든것',
      'date': '2024.02.13',
      'videoId': 'cE9F3BTge3M',  // 유튜브 영상 ID
    },
    {
      'title': '제네시스 G80 페이스리프트 모든 버튼 기능설명+사용꿀팁ㅣ25분만 투자하시면 받자마자 "똑똑하게" 사용하실 수 있습니다',
      'channel': '블라인드_Car Story',
      'date': '2024.02.19',
      'videoId': '6WclvwCAzOE',
    },
    {
      'title': '제네시스(GENESIS) G80 시승 | 한국 럭셔리 세단의 자존심.. 페이스리프트후 더욱더 고급스러워진..',
      'channel': '차타TV',
      'date': '2024.09.27',
      'videoId': 'Wi4cGAnlxAg',
    },
    {
      'title': '제네시스 G80 시승기...벤츠 E클래스와는 다른 매력!',
      'channel': '김한용의 MOCAR',
      'date': '2024.01.26',
      'videoId': '4iHutNJtEn8',
    },
    // 추가 데이터 ...
  ];

  // 리뷰 탭에 넣을 데이터
  final List<Map<String, dynamic>> reviews = [
    {
      'user': 'carLover123',
      'colorOption': '우유니 화이트',
      'rating': 4.5,
      'images': [
        'https://lh3.googleusercontent.com/proxy/WPGPCjALJPWkYOEDTs7GKnK_yIFoxKL6v11sYGljPxqxQInMGFayWEkSAlJLVRGZliDTJ2GgMz91ox7E93RsDFttKu-rU1ml_FRwaD1NgDpG8pgtMiAiJEBcNW9jf9keJNWoKok',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScixXqZCWOhYJpGev_X3CZBvSmC1YkUvJexw&s',
        'https://img.hankyung.com/photo/202312/01.35416483.1.jpg',
      ],
    },
    {
      'user': 'speedster92',
      'colorOption': '마칼루 그레이',
      'rating': 4.0,
      'images': [
        'https://d2yvw3vh7zamx3.cloudfront.net/data/tuningContents/carspace1263/ohcar_bi_5_222737026262.jpg',
        'https://d2yvw3vh7zamx3.cloudfront.net/data/tuningContents/carspace114/ohcar_bi_3_223024111113.jpg',
        'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/422/c2491fe7b62cf80361cab046a36c63c7_res.jpeg',
      ],
    },
    {
      'user': 'rideKing007',
      'colorOption': '브루클린 브라운',
      'rating': 4.8,
      'images': [
        'https://mblogthumb-phinf.pstatic.net/MjAyNDA3MTRfMTY5/MDAxNzIwOTQwMDM2ODQ5.YNrBPbE3Qgc92UlKuhaPGbrJJzKbV_CQIkyJaZNtwFMg.OGz_amzBgD7Hb0prJTSdh7ik87jcb3ZcHFNv7ZTbZesg.JPEG/IMG_6268.JPG?type=w800',
        'https://mblogthumb-phinf.pstatic.net/MjAyNDA3MTRfMTY5/MDAxNzIwOTQwMDM2ODQ5.YNrBPbE3Qgc92UlKuhaPGbrJJzKbV_CQIkyJaZNtwFMg.OGz_amzBgD7Hb0prJTSdh7ik87jcb3ZcHFNv7ZTbZesg.JPEG/IMG_6268.JPG?type=w800',
        'https://mblogthumb-phinf.pstatic.net/MjAyNDA3MTRfMjM2/MDAxNzIwOTQwMDM2MzM4.-v_2SjDig0tFWN_fSGphVQPMmItKuiAWJ3j8cc6OeUEg.thJubEaqO8BfaqX2VB4gtBLzRKmroB4JF0pQ4cAf3ZQg.JPEG/IMG_6306.JPG?type=w800',
      ],
    },
  ];


  // 영상 탭에서 유튜브 썸네일 구하는 메소드
  String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // 공유 기능 구현
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 차량 이름과 가격대
              Text(
                carName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '$priceRange',
                style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // 차량 이미지
              Center(
                child: Image.network(
                  carImageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),

              // 차량 외장 컬러 이름
              Center(
                child: Text(
                  colorNames[selectedColorIndex],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16),

              // 색상 옵션
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colorOptions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorIndex = index;
                          carImageUrl = carOptions[index]; // 선택된 색상에 맞는 이미지로 변경
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColorIndex == index ? Colors.blue : Colors.transparent,
                              width: 2, // 테두리 두께 설정
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: colorOptions[index],
                            radius: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // TabBar
              TabBar(
                controller: _tabController,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.red,
                tabs: [
                  Tab(text: '시세'),
                  Tab(text: '유지비'),
                  Tab(text: '리뷰'),
                  Tab(text: '영상'),
                ],
              ),
              SizedBox(height: 16),

              // TabBarView
              Container(
                height: 400, // TabBarView의 높이 지정
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 첫 번째 탭 내용 (차량 모델별 시세)
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 신차 모델별 시세 카드
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text(
                              '| 신차 시세',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: newModelDetails.map((model) {
                              return Card(
                                color: Colors.grey.shade50,
                                elevation: 1,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 모델명
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model['model'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            model['release'],
                                            style: TextStyle(fontSize: 13, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // 가격
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${model['price']}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '만원',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),

                          // 중고차 모델별 시세 카드
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text(
                              '| 중고차 시세',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: usedModelDetails.map((model) {
                              return Card(
                                color: Colors.grey.shade50,
                                elevation: 1,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 모델명
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model['model'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            model['release'],
                                            style: TextStyle(fontSize: 13, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // 가격
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${model['price']}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '만원',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),

                          // 렌트 모델별 시세 카드
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text(
                              '| 렌트 시세',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: rentModelDetails.map((model) {
                              return Card(
                                color: Colors.grey.shade50,
                                elevation: 1,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 모델명
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model['model'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            model['release'],
                                            style: TextStyle(fontSize: 13, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // 가격
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '월 ',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${model['price']}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '원',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16),

                          // 리스 모델별 시세 카드
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Text(
                              '| 리스 시세',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: leaseModelDetails.map((model) {
                              return Card(
                                color: Colors.grey.shade50,
                                elevation: 1,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 모델명
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model['model'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            model['release'],
                                            style: TextStyle(fontSize: 13, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          // 가격
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '월 ',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${model['price']}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '원',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey, // '만원' 글씨 색상 회색으로 변경
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),


                    // 두 번째 탭 내용 (유지비)
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: maintenanceData.asMap().entries.map((entry) {
                              int index = entry.key;
                              var data = entry.value;

                              return Container(
                                decoration: index == 0
                                    ? BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red, // 테두리 색상
                                    width: 1.0, // 테두리 두께
                                  ),
                                  borderRadius: BorderRadius.circular(8.0), // 테두리 모서리 둥글게
                                )
                                    : null, // index가 0이 아닐 때는 테두리를 설정하지 않음
                                child: Card(
                                  //color: index != 0 ? Colors.white : Colors.grey.shade50, // 첫 번째 데이터만 회색 배경
                                  //elevation: index != 0 ? 0 : 1, // 첫 번째 데이터만 elevation 설정
                                  color: Colors.white,
                                  elevation: 0,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['type'] ?? '',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              data['description'] ?? '',
                                              style: TextStyle(fontSize: 13, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data['value'] ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: index == 0 ? FontWeight.bold : null,
                                            //fontWeight: FontWeight.bold,
                                            color: index == 0 ? Colors.red : Colors.blue, // 첫 번째 데이터만 빨간색
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),


                    // 세 번째 탭 내용 (리뷰)
                    ListView(
                      padding: EdgeInsets.all(0.0),
                      children: reviews.map((review) => buildReviewCard(review)).toList(),
                    ),


                    // 네 번째 탭 내용 (영상)
                    SingleChildScrollView(
                      child: Column(
                        children: videoData.map((data) {
                          String videoId = data['videoId'] ?? '';
                          String thumbnailUrl = getThumbnailUrl(videoId);

                          return GestureDetector(
                            onTap: () {
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: Image.network(
                                          thumbnailUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              height: 200,
                                              child: Center(child: Icon(Icons.error)),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            //Icons.play_circle_outline,
                                            Icons.play_circle,
                                            color: Colors.red,
                                            size: 70.0,  // 아이콘 크기
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['title'] ?? '',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${data['channel']} • ${data['date']}',
                                          style: TextStyle(fontSize: 13, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          );
                        }).toList(),
                      ),
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


  // 리뷰 탭 ui 구성 메소드
  Widget buildReviewCard(Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review['user'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 자세히 보기 버튼
                    },
                    child: Text(
                      '리뷰 보기 >',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // 컬러 옵션 및 별점
              Row(
                children: [
                  // 컬러 옵션 텍스트
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
                  SizedBox(width: 10),
                  // 별점
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: null,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.star_border, color: Colors.yellow.shade800, size: 18), // 테두리 별
                            Icon(Icons.star, color: Colors.yellow.shade800, size: 16), // 채워진 별
                          ],
                        ),
                        Text(
                          ' ${review['rating']}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),

              // 리뷰 이미지
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1,
                ),
                itemCount: review['images'].length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      review['images'][index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  void main() {
    runApp(MaterialApp(
      home: CarDetailPage(),
  ));
}