import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PageUpdateProfil extends StatefulWidget {
  @override
  _PageUpdateProfilState createState() => _PageUpdateProfilState();
}

class _PageUpdateProfilState extends State<PageUpdateProfil> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String? id;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = prefs.getString('username') ?? '';
      fullnameController.text = prefs.getString('fullname') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      id = prefs.getString('id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: fullnameController,
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(labelText: 'password'),
              ),
              SizedBox(height: 16.0),
              Text(
                'ID User: $id',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _editProfile();
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editProfile() async {
    final username = usernameController.text;
    final fullname = fullnameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // Validasi jika data kosong
    if (username.isEmpty || fullname.isEmpty || email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Isi Semua Data'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('YES'),
              ),
            ],
          );
        },
      );
      return; // Stop the execution flow
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id');

      final response = await http.post(
        Uri.parse('http://192.168.1.4/utsDb/updateUser.php'),
        body: {
          'id': id,
          'username': username,
          'fullname': fullname,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          prefs.setString('username', username);
          prefs.setString('fullname', fullname);
          prefs.setString('email', email);
          prefs.setString('password', password);

          Navigator.pop(context, true);

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Berhasil'),
                content: Text('Data berhasil diupdate.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Gagal'),
                content: Text('Gagal Edit data'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('YES'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception(
            'Gagal edit data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat mengedit profile.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('YES'),
              ),
            ],
          );
        },
      );
    }
  }
}