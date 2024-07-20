import 'dart:convert';
import 'dart:core'; //validasi format email

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectuts/LoginRegister/page_login.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtFullName = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  // Definisi regex untuk memeriksa format email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<int> _register() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.3/utsDb/register.php'),
        body: {
          "username": txtUsername.text,
          "email": txtEmail.text,
          "password": txtPassword.text,
          "fullname": txtFullName.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final registerStatus = responseData['value'];

        return registerStatus ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text('Register Form'),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0d8f56), // Warna utama di tengah
                Color(0xff1bfa98), // Warna transparan di pinggir
                Color(0xff1bfa98), // Warna transparan di pinggir
                Color(0xff0d8f56), // Warna utama di tengah// Warna utama di tengah
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
                      'Register Akun', // Judul
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
                      controller: txtFullName,
                      decoration: InputDecoration(
                          hintText: "Full Name",
                          border: UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
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
                          hintText: "Username", border: UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Tidak Boleh kosong";
                        } else if (!emailRegex.hasMatch(val)) {
                          return "ex: ex@mail.com";
                        }
                        return null;
                      },
                      controller: txtEmail,
                      decoration: InputDecoration(
                          hintText: "Email", border: UnderlineInputBorder()),
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
                          hintText: "Password", border: UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (keyForm.currentState?.validate() == true) {
                          _register().then((registerStatus) {
                            if (registerStatus == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Berhasil didaftarkan!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushReplacementNamed(
                                  context, '/PageLogin');
                            } else if (registerStatus == 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Username atau email telah digunakan!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (registerStatus == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal didaftarkan'),
                                  backgroundColor: Colors.deepOrange,
                                ),
                              );
                            } else {}
                          }).catchError((error) {
                            print("Error during login: $error");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'An error occurred during login. Please try again later.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        }
                      },
                      child: Text('Register'),
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Sudah Punya Akun? ',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Silahkan Login',
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
                                        builder: (context) => PageLogin()),
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
    ));
  }
}
