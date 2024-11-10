import 'package:flutter/material.dart';

class ProfileButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Page',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'user1234',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('user12348@gmail.com', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // 나의 활동 버튼 클릭 시 동작
                        },
                        child: Text(
                          '나의 활동',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.announcement, color: Colors.black),
                    title: Text('공지사항'),
                    onTap: () {
                      // 공지사항 클릭 시 동작
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent, color: Colors.black),
                    title: Text('고객센터'),
                    onTap: () {
                      // 고객센터 클릭 시 동작
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.black),
                    title: Text('설정'),
                    onTap: () {
                      // 설정 클릭 시 동작
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
