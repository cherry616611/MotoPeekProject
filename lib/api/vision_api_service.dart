import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VisionApiService {
  final String _apiKey = 'AIzaSyAR7xy84-r0xOf7kfJG8y-XnJykbsN0DBg';  // Google Cloud API 키

  // 이미지 분석하는 함수
  Future<String> analyzeImage(String imagePath) async {
    // 이미지 파일을 읽어서 Base64로 인코딩
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // 요청 바디 생성
    final body = jsonEncode({
      'requests': [
        {
          'image': {
            'content': base64Image
          },
          'features': [
            {
              'type': 'LABEL_DETECTION',
              'maxResults': 5  // 최대 5개의 라벨 반환
            }
          ]
        }
      ]
    });

    // API 호출
    final response = await http.post(
      Uri.parse('https://vision.googleapis.com/v1/images:annotate?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    // 응답이 성공적일 경우
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // 응답 데이터의 라벨 설명 추출
      if (data['responses'][0]['labelAnnotations'] != null) {
        final label = data['responses'][0]['labelAnnotations'][0]['description'];
        return label;
      } else {
        throw Exception('No labels found in the response.');
      }
    } else {
      // 실패할 경우 오류 반환
      throw Exception('Failed to analyze image: ${response.statusCode}, ${response.body}');
    }
  }
}
