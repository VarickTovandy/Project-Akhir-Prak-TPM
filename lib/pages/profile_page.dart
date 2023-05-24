import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.blue.withOpacity(0.3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pinimg.com/564x/a8/b5/30/a8b530d8936c9f5ff9fbc6ade1eb81c2.jpg",
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Varick Tovandy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Pada semester 6, saya mendapatkan pengalaman yang sangat berharga dalam mempelajari Teknologi Pemrograman Mobile. Mata kuliah ini memberikan pemahaman yang lebih mendalam tentang pengembangan aplikasi mobile menggunakan framework Flutter.',
              style: TextStyle(fontSize: 16, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
