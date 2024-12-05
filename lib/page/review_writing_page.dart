import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ReviewWritingPage extends StatefulWidget {
  @override
  _ReviewWritingPageState createState() => _ReviewWritingPageState();
}

class _ReviewWritingPageState extends State<ReviewWritingPage> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedColor;
  double selectedRating = 0.0;
  String reviewText = ""; // 리뷰 텍스트 저장
  List<File> _selectedImages = [];  // 선택된 이미지를 저장할 리스트

  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스 생성

  // 브랜드와 모델 데이터를 정의
  final Map<String, List<String>> vehicleData = {
    '기아': ['K5', 'K8', '쏘렌토'],
    '현대': ['아반떼', '캐스퍼', '쏘나타 디엣지', '그랜저', 'LF쏘나타'],
    '제네시스': ['G80'],
    'BMW': ['320i'],
    '벤츠': ['E-Class']
  };

  // 모델별 색상 데이터 정의
  final Map<String, List<String>> colorData = {
    '캐스퍼': ['언블리치드 아이보리', '아틀라스 화이트', '비자림 카키 매트', '톰보이 카키'],
  };

  // 카메라 촬영 또는 앨범에서 이미지 선택
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  // 이미지 삭제 기능
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);  // 선택된 이미지를 리스트에서 삭제
    });
  }

  // 오늘 날짜 가져오는 함수
  String getTodayDate() {
    final now = DateTime.now();
    return DateFormat('M월 d일').format(now); // 예: "12월 5일"
  }

  // Firestore와 Storage에 데이터를 업로드하는 함수
  Future<void> uploadReviewData({
    required String modelName,
    required String colorOption,
    required double rating,
    required String text,
    required String user,
    required List<File> images, // 업로드할 이미지 파일 리스트
    required String date, // 작성 날짜
  }) async {
    try {
      // Firestore 컬렉션의 경로
      String collectionPath = 'cars/hyundai_casper/reviews'; // 현대 캐스퍼 데이터 입력(임의)

      // Firestore에 문서 추가 (리뷰 데이터)
      final docRef = await FirebaseFirestore.instance.collection(collectionPath).add({
        'modelName': modelName,
        'colorOption': colorOption,
        'rating': rating.toString(),
        'text': text,
        'user': user,
        'date': date,
        'wish': false, // 기본 값
        // 임의의 이미지 데이터
        'imageUrl_1': "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/BB1p8YOW.img?w=386&h=257&m=6",
        'imageUrl_2': "https://cdn.motorgraph.com/news/photo/202406/40469_201416_5232.jpg",
        'imageUrl_3': "https://contents-cdn.viewus.co.kr/image/2024/06/CP-2023-0047/image-f74d4f2c-8ee4-4373-9a69-7d8baedfb942.jpeg",
      });
      print('데이터를 성공적으로 업로드했습니다.');
    } catch (e) {
      print('업로드 중 오류 발생: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '리뷰 작성',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 브랜드 선택 Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: '브랜드를 선택하세요'),
                dropdownColor: Colors.white,
                value: selectedBrand,
                items: vehicleData.keys
                    .map((brand) => DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBrand = value;
                    selectedModel = null; // 브랜드 변경 시 모델 초기화
                    selectedColor = null; // 색상도 초기화
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // 모델 선택 Dropdown
              if (selectedBrand != null)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: '모델을 선택하세요'),
                  dropdownColor: Colors.white,
                  value: selectedModel,
                  items: vehicleData[selectedBrand]!
                      .map((model) => DropdownMenuItem(
                    value: model,
                    child: Text(model),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedModel = value;
                      selectedColor = null; // 모델 변경 시 색상 초기화
                    });
                  },
                ),
              const SizedBox(height: 16.0),

              // 색상 선택 Dropdown
              if (selectedModel != null && colorData.containsKey(selectedModel!))
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: '색상을 선택하세요'),
                  dropdownColor: Colors.white,
                  value: selectedColor,
                  items: colorData[selectedModel]!
                      .map((color) => DropdownMenuItem(
                    value: color,
                    child: Text(color),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedColor = value;
                    });
                  },
                ),
              const SizedBox(height: 16.0),

              // 별점 입력
              if (selectedColor != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '별점을 입력하세요:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    RatingBar.builder(
                      initialRating: selectedRating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          selectedRating = rating;
                        });
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),

              // 리뷰 텍스트 입력 + 사진 추가
              if (selectedColor != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '리뷰를 작성하세요',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          reviewText = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // 이미지 버튼 및 선택된 이미지 리스트
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showImageSourceActionSheet();  // 이미지 선택 방법 선택
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Icon(Icons.add_a_photo, size: 40),
                          ),
                        ),
                        SizedBox(width: 16),
                        // 선택된 이미지가 있을 때만 보여주기 (최대 3장)
                        Expanded(
                          child: Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 16),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Image.file(_selectedImages[index], fit: BoxFit.cover),
                                    ),
                                    // 이미지 삭제 버튼
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () => _removeImage(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                          child: Icon(Icons.close, color: Colors.white, size: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      // 하단 고정된 작성완료 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(16),
            shape: StadiumBorder(),
          ),
          onPressed: () async {
            if (selectedBrand != null &&
                selectedModel != null &&
                selectedColor != null &&
                selectedRating > 0 &&
                reviewText.isNotEmpty) {
              try {
                await uploadReviewData(
                  modelName: selectedBrand! + " " + selectedModel!, // 브랜드 + 모델명
                  colorOption: selectedColor!, // 예: "우유니 화이트"
                  rating: selectedRating, // 별점 값
                  text: reviewText, // 리뷰 내용
                  user: "user1234", // 사용자 이름
                  images: _selectedImages, // 선택된 이미지 리스트
                  date: getTodayDate(), // 오늘 날짜 자동 입력
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('리뷰가 성공적으로 업로드되었습니다!')),
                );
                Navigator.pop(context); // 화면 닫기
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('업로드 중 오류가 발생했습니다: $e')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('모든 필드를 작성해주세요!')),
              );
            }
            // 작성완료 기능
            //Navigator.pop(context); // 현재 화면 닫기
          },
          child: Text('작성 완료', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  // 이미지 소스 선택 다이얼로그 (카메라 or 갤러리)
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('카메라로 촬영'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);  // 카메라 촬영
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('앨범에서 선택'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);  // 갤러리에서 이미지 선택
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
