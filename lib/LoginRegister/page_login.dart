import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectuts/LoginRegister/page_register.dart';
import 'package:projectuts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final username = txtUsername.text;
    final password = txtPassword.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.3/utsDb/login.php'),
        body: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', txtUsername.text);
          prefs.setString('password', txtPassword.text);
          prefs.setString('email', responseData['data']['email']);
          prefs.setString('fullname', responseData['data']['fullname']);
          prefs.setString('id', responseData['data']['id']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageUtama()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Gagal'),
                content: Text('Username atau Password salah.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat melakukan login.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // backgroundColor: Colors.blue,
      //     // title: Text('Login Form'),
      //     ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffd4f2ae), // Warna utama di tengah
                Color(0xffa1b884), // Warna transparan di pinggir
                Color(0xffa1b884), // Warna transparan di pinggir
                Color(0xffd4f2ae), // Warna utama di tengah// Warna utama di tengah
              ],
              stops: [0.1, 0.4, 0.6, 0.9], // Menentukan ukuran masing-masing warna
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        child: Center(
          child: Card(
            color: const Color.fromARGB(255, 240, 240, 240),
            margin: EdgeInsets.all(100),
            child: Form(
              key: keyForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:
                    EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Sign in', // Judul
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh kosong" : null;
                        },
                        controller: txtUsername,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        obscureText: true,
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh kosong" : null;
                        },
                        controller: txtPassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: UnderlineInputBorder()),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MaterialButton(
                        onPressed: isLoading ? null : () => _login(),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                        // child: Text('Login'),
                        color: Colors.green,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Belum Punya Akun? ',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Silahkan Register',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.blue, // Warna teks kedua
                              ),
                              // event handler jika teks kedua ditekan
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PageRegister()),
                                      (route) => false);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}