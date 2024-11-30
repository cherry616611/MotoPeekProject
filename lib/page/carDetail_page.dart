import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capston/page/car_detail_view_page.dart';

class CarDetailPage extends StatefulWidget {
  final String docId; // 문서 ID를 전달받음
  CarDetailPage({required this.docId});

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> carDataFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Firebase에서 carData와 colors 데이터를 병렬로 가져옴
    carDataFuture = fetchCarDataAndColors(widget.docId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchCarDataAndColors(String docId) async {
    // carData 가져오기
    final carDataSnapshot = await FirebaseFirestore.instance.collection('cars').doc(docId).get();
    if (!carDataSnapshot.exists) {
      throw Exception('문서가 존재하지 않습니다.');
    }
    final carData = carDataSnapshot.data()!;

    // colors 서브컬렉션 가져오기
    final colorsSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('colors')
        .get();
    final colors = colorsSnapshot.docs.map((doc) => doc.data()).toList();

    // new_model_details 서브컬렉션 가져오기
    final newModelSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('new_model_details')
        .get();
    final new_model_details = newModelSnapshot.docs.map((doc) => doc.data()).toList();

    // used_model_details 서브컬렉션 가져오기
    final usedModelSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('used_model_details')
        .get();
    final used_model_details = usedModelSnapshot.docs.map((doc) => doc.data()).toList();

    // rent_model_details 서브컬렉션 가져오기
    final rentModelSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('rent_model_details')
        .get();
    final rent_model_details = rentModelSnapshot.docs.map((doc) => doc.data()).toList();

    // lease_model_details 서브컬렉션 가져오기
    final leaseModelSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('rent_model_details')
        .get();
    final lease_model_details = leaseModelSnapshot.docs.map((doc) => doc.data()).toList();

    // maintenance_data 서브컬렉션 가져오기
    final maintenanceDataSnapshot = await FirebaseFirestore.instance
        .collection('cars')
        .doc(docId)
        .collection('maintenance_data')
        .get();
    final maintenance_data = maintenanceDataSnapshot.docs.map((doc) => doc.data()).toList();

    return {
      'carData': carData,
      'colors': colors,
      'new_model_details': new_model_details,
      'used_model_details': used_model_details,
      'rent_model_details': rent_model_details,
      'lease_model_details': lease_model_details,
      'maintenance_data': maintenance_data,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: carDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('오류 발생: ${snapshot.error}')));
        }
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text('데이터가 없습니다.')));
        }

        final carData = snapshot.data!['carData'] as Map<String, dynamic>;
        final colors = snapshot.data!['colors'] as List<Map<String, dynamic>>;
        final new_model_details = snapshot.data!['new_model_details'] as List<Map<String, dynamic>>;
        final used_model_details = snapshot.data!['used_model_details'] as List<Map<String, dynamic>>;
        final rent_model_details = snapshot.data!['rent_model_details'] as List<Map<String, dynamic>>;
        final lease_model_details = snapshot.data!['lease_model_details'] as List<Map<String, dynamic>>;
        final maintenance_data = snapshot.data!['maintenance_data'] as List<Map<String, dynamic>>;

        return CarDetailView(
            carData: carData,
            colors: colors,
            new_model_details: new_model_details,
            used_model_details: used_model_details,
            rent_model_details: rent_model_details,
            lease_model_details: lease_model_details,
            maintenance_data: maintenance_data,
            tabController: _tabController
        );
      },
    );
  }
}