// 마이 페이지 (임시 페이지)

import 'package:flutter/material.dart';
import 'design_materials.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '마이페이지', context: context, isHomePage: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '사용자 정보',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // User Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/user_profile.jpg'), // Replace with your user image URL
              ),
            ),
            const SizedBox(height: 16),
            // User Details
            const Text('이름: 홍길동', style: TextStyle(fontSize: 18)),
            const Text('이메일: hong@example.com', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Action Buttons
            ElevatedButton(
              onPressed: () {
                // Implement edit profile functionality
              },
              child: const Text('프로필 수정'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}