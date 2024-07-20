import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projectuts/Sejarawan/PageListSejarawan.dart';

class createSejarawan extends StatefulWidget {
  const createSejarawan({super.key});

  @override
  State<createSejarawan> createState() => _createSejarawanState();
}

class _createSejarawanState extends State<createSejarawan> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController foto = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController asal = TextEditingController();
  TextEditingController jk = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  String? selectedGender;

  //image
  Future<void> _getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        // Baca gambar sebagai bytes
        List<int> imageBytes = File(pickedImage.path).readAsBytesSync();
        // Konversi bytes menjadi base64
        foto.text = base64Encode(imageBytes);
      });
    }
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != tgl_lahir.text) {
      setState(() {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        tgl_lahir.text = formatter.format(picked);
      });
    }
  }

  Future<int> _simpan() async {
    // Cetak data sebelum dikirim ke server
    // print('Data yang dikirim ke server:');
    // print('Nama: ${nama.text}');
    // print('Tanggal Lahir: ${tgl_lahir.text}');
    // print('Asal: ${asal.text}');
    // print('Jenis Kelamin: ${jk.text}');
    // print('Deskripsi: ${deskripsi.text}');
    // print('Foto: ${foto.text}');

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(tgl_lahir.text));

    final response = await http.post(
        Uri.parse('http://192.168.1.3/utsDb/createSejarawan.php'),
        body: {
          "nama": nama.text,
          "tgl_lahir": formattedDate,
          "asal": asal.text,
          "jk": selectedGender ?? "",
          "deskripsi": deskripsi.text,
          "foto": foto.text,
        });

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);
        final value = responseData['value'];

        return value ?? 0;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 0;
      }
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Create Data Sejarawan',
            style: TextStyle(color: Colors.white),
          ),
        toolbarHeight: 50,
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 74, 48, 0)),
      ),
      body: Container(
        height: 1000,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(30),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        TextFormField(
                          controller: nama,
                          decoration: InputDecoration(
                            hintText: "Nama",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama tidak boleh kosong";
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        // TextFormField(
                        //   controller: foto,
                        //   decoration: InputDecoration(
                        //     hintText: "Foto .jpeg",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Foto tidak boleh kosong";
                        //     }
                        //   },
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Text("Foto Sejarawan"),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onPressed: _getImage,
                              child: Text('Upload Foto Sejarawan'),
                            )
                          ],
                        ),
                        // Image.memory(
                        //   base64Decode(foto.text),
                        //   fit: BoxFit.cover,
                        //   width: 100, // Sesuaikan dengan kebutuhan Anda
                        //   height: 100, // Sesuaikan dengan kebutuhan Anda
                        // ),
                        foto.text.isNotEmpty
                            ? Image.memory(
                                base64Decode(foto.text),
                                fit: BoxFit.cover,
                                width: 100, // Sesuaikan dengan kebutuhan Anda
                                height: 100, // Sesuaikan dengan kebutuhan Anda
                              )
                            : SizedBox.shrink(),

                        SizedBox(height: 10),
                        TextFormField(
                          controller: tgl_lahir,
                          readOnly: true, // Set to true to prevent manual input
                          onTap: () {
                            _selectDate(context);
                          },
                          decoration: InputDecoration(
                            hintText: "Tanggal Lahir",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Tanggal Lahir tidak boleh kosong";
                            }
                          },
                        ),
                        // TextFormField(
                        //   controller: tgl_lahir,
                        //   decoration: InputDecoration(
                        //     hintText: "Tanggal Lahir, ex : 2001-21-12",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Tanggal Lahir tidak boleh kosong";
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: asal,
                          decoration: InputDecoration(
                            hintText: "Asal",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Asal tidak boleh kosong";
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        // TextFormField(
                        //   controller: jk,
                        //   decoration: InputDecoration(
                        //     hintText:
                        //         "Jenis Kelamin, ex : laki-laki atau perempuan",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Jenis Kelamin tidak boleh kosong";
                        //     }
                        //   },
                        // ),
                        ListTile(
                          title: Text(
                            "Jenis Kelamin",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                          subtitle: Row(
                            children: [
                              Radio<String>(
                                value: "laki-laki",
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              Text("Laki-laki"),
                              Radio<String>(
                                value: "perempuan",
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              Text("Perempuan"),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: deskripsi,
                          maxLines: null, // memungkinkan input teks panjang
                          keyboardType:
                              TextInputType.multiline, // input teks panjang
                          decoration: InputDecoration(
                            hintText: "Deskripsi Singkat",
                            hintStyle: TextStyle(fontSize: 14),
                            // border: UnderlineInputBorder(
                            //   borderSide:
                            //       BorderSide(),
                            // ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Deskripsi tidak boleh kosong";
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color.fromARGB(255, 192, 178, 52),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _simpan().then((value) {
                                if (value == 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Berhasil tambah data Sejarawan!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          PageListSejarawan()),
                                    ),
                                    (route) => false,
                                  );
                                } else if (value == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Nama telah digunakan!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (value == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Gagal tambah data Sejarawan'),
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            "Simpan Data",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}