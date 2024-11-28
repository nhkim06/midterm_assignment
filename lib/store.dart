// 스토어 페이지 (임시 페이지)

import 'package:flutter/material.dart';
import 'design_materials.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    // Sample manufacturers
    final List<String> manufacturers = [
      '제조사 1',
      '제조사 2',
      '제조사 3',
      '제조사 4',
      '제조사 5',
    ];

    return Scaffold(
      appBar: CustomAppBar(title: '스토어', context: context, isHomePage: false),
      body: ListView.builder(
        itemCount: manufacturers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(manufacturers[index]),
            onTap: () {
              // Handle manufacturer selection
              Navigator.pop(context, manufacturers[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
