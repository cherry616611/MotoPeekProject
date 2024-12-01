import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capston/page/carDetail_page.dart';

class WishButtonPage extends StatelessWidget {
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cars')
              .where('wish', isEqualTo: true) // wish가 true인 데이터만 가져옴
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('위시리스트가 비어 있습니다.'),
              );
            }

            final cars = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 두 개의 아이템을 표시
                crossAxisSpacing: 8.0, // 아이템 간 가로 간격
                mainAxisSpacing: 8.0, // 아이템 간 세로 간격
                childAspectRatio: 0.95, // 카드의 가로 세로 비율 조정
              ),
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final carDoc = cars[index];
                final car = carDoc.data() as Map<String, dynamic>;
                final documentId = carDoc.id;

                return InkWell(
                  onTap: () {
                    // CarDetailPage로 이동하면서 documentId 전달
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetailPage(docId: documentId),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            car['imageUrl'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
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
                              Text('${car['make']}', style: TextStyle(fontSize: 13)),
                              Text('${car['name']}',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
