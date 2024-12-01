import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'api/vision_api_service.dart';
import 'package:capston/page/carDetail_page.dart';

Future<void> _requestPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _result; // 분석 결과
  final VisionApiService _visionApiService = VisionApiService(); // Vision API 서비스
  List<String> validResults = ["Car", "Tire", "Automotive parking light", "Wheel"]; // API 분석 결과

  @override
  void initState() {
    super.initState();
    _initializeCamera(); // 카메라 초기화
  }

  // 카메라 초기화 함수
  void _initializeCamera() async {
    try {
      await _requestPermission(); // 권한 요청 후 초기화
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
      setState(() {}); // 초기화가 완료되면 UI 업데이트
    } catch (e) {
      print("카메라 초기화 오류: $e");
    }
  }

  // 사진 촬영 및 분석 함수
  Future<void> _takePictureAndAnalyze(BuildContext context) async {
    try {
      await _initializeControllerFuture;

      // 사진 촬영
      final XFile image = await _controller.takePicture();

      // 촬영한 이미지를 저장할 경로 지정
      final directory = await getTemporaryDirectory();
      final path = join(directory.path, '${DateTime.now()}.png');

      // 파일로 저장
      File imageFile = File(image.path);
      imageFile.copy(path);

      // 촬영한 이미지를 Google Cloud Vision API로 분석
      final result = await _visionApiService.analyzeImage(imageFile.path);
      setState(() {
        _result = result; // 분석 결과 저장
      });

      // 결과가 validResults에 포함되어 있는지 확인하고 페이지 이동
      if (validResults.contains(_result)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetailPage(docId: "hyundai_LFsonata"),
            ),
          );
      };
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // 카메라 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 카메라 화면 미리보기
            return Stack(
              children: [
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // _result가 null이면 아무 것도 표시되지 않음
                      if (_result != null)
                         Text(
                          validResults.contains(_result)
                              ? '' // 조건에 맞으면 빈 문자열 (아무 것도 표시되지 않음)
                              : '차량을 다시 촬영해주세요',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _takePictureAndAnalyze(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 배경 색 설정
                          side: BorderSide(color: Colors.white, width: 2), // 테두리 색과 두께 설정
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Row의 크기를 버튼 크기에 맞게 설정
                          children: [
                            Icon(Icons.camera_alt, color: Colors.white), // 카메라 아이콘 추가
                            SizedBox(width: 8), // 아이콘과 텍스트 사이의 간격
                            Text(
                              '차량 분석',
                              style: TextStyle(color: Colors.white), // 글자 색 설정
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            );
          } else {
            // 카메라 초기화 중 로딩 표시
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}