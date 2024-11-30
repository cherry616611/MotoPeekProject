import 'package:flutter/material.dart';

class CarDetailView extends StatefulWidget {
  final Map<String, dynamic> carData;
  final List<Map<String, dynamic>> colors;
  final List<Map<String, dynamic>> new_model_details;
  final List<Map<String, dynamic>> used_model_details;
  final List<Map<String, dynamic>> rent_model_details;
  final List<Map<String, dynamic>> lease_model_details;
  final TabController tabController;

  CarDetailView({
    required this.carData,
    required this.colors,
    required this.new_model_details,
    required this.used_model_details,
    required this.rent_model_details,
    required this.lease_model_details,
    required this.tabController
  });

  @override
  _CarDetailViewState createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  late int selectedColorIndex;
  late String carImageUrl;
  late List<String> colorNames;
  late List<String> colorImages;
  late List<Color> colorOptions;

  @override
  void initState() {
    super.initState();
    colorNames = widget.colors.map((doc) => doc['color'] as String).toList();
    colorImages = widget.colors.map((doc) => doc['image_url'] as String).toList();
    colorOptions = widget.colors.map((doc) {
      try {
        return Color(int.parse(doc['color_code']));
      } catch (e) {
        return Colors.grey; // color_code 변환 시 오류 발생 시 기본 색상을 사용
      }
    }).toList();
    selectedColorIndex = 0;
    carImageUrl = colorImages.isNotEmpty ? colorImages[0] : ''; // 첫 번째 색상의 이미지를 기본값으로 사용
  }

  @override
  Widget build(BuildContext context) {
    final carName = widget.carData['make'] + " " + widget.carData['name'];
    final priceRange = widget.carData['price_range'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // 위시리스트 기능 구현
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
              Text(carName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(priceRange, style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),

              // 차량 이미지
              Center(
                child: Image.network(
                  carImageUrl, // 첫 번째 색상의 이미지를 기본값으로 사용
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
                          carImageUrl = colorImages[index]; // 선택된 색상에 맞는 이미지로 변경
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
                controller: widget.tabController,
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
                height: 400,
                child: TabBarView(
                  controller: widget.tabController,
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
                            children: widget.new_model_details.map((model) {
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
                            children: widget.used_model_details.map((model) {
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
                            children: widget.rent_model_details.map((model) {
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
                            children: widget.lease_model_details.map((model) {
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


                    Center(child: Text('유지비 탭 내용')),
                    Center(child: Text('리뷰 탭 내용')),
                    Center(child: Text('영상 탭 내용')),
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
