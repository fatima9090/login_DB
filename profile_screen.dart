import 'package:flutter/material.dart';
import 'database_helper.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({required this.email,super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    var user = await _dbHelper.getUser(widget.email);
    if (user != null) {
      setState(() {
        _email = user['email'];
        _password = user['password'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _email == null
            ? Center(child: CircularProgressIndicator()) // Jab tak data load na ho, loading indicator show hoga
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $_email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Password: $_password', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Back to login screen
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
