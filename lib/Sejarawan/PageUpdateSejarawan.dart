import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projectuts/Sejarawan/PageListSejarawan.dart';

class updateSejarawan extends StatefulWidget {
  final Map ListData;
  const updateSejarawan({Key? key, required this.ListData}) : super(key: key);
  // const updateSejarawan({super.key});

  @override
  State<updateSejarawan> createState() => _updateSejarawanState();
}

class _updateSejarawanState extends State<updateSejarawan> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController foto = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController asal = TextEditingController();
  // TextEditingController jk = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  String? selectedGender;
  bool imageUploaded = false;

  // Future<void> _getImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     File imageFile = File(pickedImage.path);
  //     if (await imageFile.exists()) {
  //       // File exists, proceed with reading it
  //       List<int> imageBytes = imageFile.readAsBytesSync();
  //       // Continue with your logic here
  //       setState(() {
  //         imageUploaded = true;
  //         // Menyimpan path gambar ke controller foto untuk menampilkan gambar di UI
  //         foto.text = pickedImage.path;
  //       });
  //     } else {
  //       // File doesn't exist
  //       print("File not found");
  //     }
  //   }
  // }

  Future<void> _getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      if (await imageFile.exists()) {
        // File exists, proceed with reading it
        List<int> imageBytes = imageFile.readAsBytesSync();
        // Continue with your logic here
        setState(() {
          imageUploaded = true;
          // Menyimpan path gambar ke controller foto untuk menampilkan gambar di UI
          foto.text = pickedImage.path;
        });
      } else {
        // File doesn't exist
        print("File not found");
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        tgl_lahir.text = formattedDate;
        // Konversi tanggal yang dipilih menjadi objek DateTime sebelum disimpan di widget.ListData
        widget.ListData['tgl_lahir'] = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    id.text = widget.ListData['id'];
    nama.text = widget.ListData['nama'];
    foto.text = widget.ListData['foto'];
    DateTime tglLahir = widget.ListData['tgl_lahir'];
    String formattedDate = DateFormat('yyyy-MM-dd').format(tglLahir);
    tgl_lahir.text = formattedDate;
    asal.text = widget.ListData['asal'];
    deskripsi.text = widget.ListData['deskripsi'];
    // Set nilai awal selectedGender berdasarkan nilai yang sudah ada sebelumnya
    selectedGender = widget.ListData['jk'];
  }

  Future _update() async {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(tgl_lahir.text));

    File imageFile = File(foto.text);

    if (imageUploaded) {
      if (await imageFile.exists()) {
      // File exists, proceed with reading it
      List<int> imageBytes = imageFile.readAsBytesSync();
      // Continue with your logic here
      String base64Image = base64Encode(imageBytes);

      // Kirim data foto yang diunggah ke server
      final response = await http.post(
          Uri.parse('http://192.168.1.3/utsDb/updateSejarawan.php'),
          body: {
            "id": id.text.toString(),
            "nama": nama.text.toString(),
            "tgl_lahir": formattedDate,
            "asal": asal.text.toString(),
            "jk": selectedGender ?? "",
            "deskripsi": deskripsi.text.toString(),
            "foto": base64Image, // Mengirim data foto yang diunggah
          });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final value = responseData['value'];

        return value ?? 0;
      } else {
        return 0;
      }
    } else {
      // File doesn't exist
      print("File not found");
    }
    } else {
      // Jika gambar belum diunggah, kirim data tanpa perubahan foto
      final response = await http.post(
          Uri.parse('http://192.168.1.3/utsDb/updateSejarawan.php'),
          body: {
            "id": id.text.toString(),
            "nama": nama.text.toString(),
            "tgl_lahir": formattedDate,
            "asal": asal.text.toString(),
            "jk": selectedGender ?? "",
            "deskripsi": deskripsi.text.toString(),
            "foto": foto.text, // Mengirim data foto yang sudah ada
          });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final value = responseData['value'];

        return value ?? 0;
      } else {
        return 0;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Update Sejarawan',
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
              // Container(
              //   width: double.infinity,
              //   height: 40,
              //   color: Color.fromARGB(255, 255, 213, 97),
              //   padding: EdgeInsets.only(left: 8, top: 8, right: 8),
              // ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(30),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
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
                            SizedBox(
                              height: 10,
                            ),
                            // TextFormField(
                            //   controller: foto,
                            //   decoration: InputDecoration(
                            //     hintText: "Foto",
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
                            ElevatedButton(
                              onPressed: _getImage,
                              child: Text('Upload Foto'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: tgl_lahir,
                              // readOnly:
                              //     true, // Set to true to prevent manual input
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
                            SizedBox(
                              height: 10,
                            ),
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
                            SizedBox(
                              height: 10,
                            ),

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
                                  Text(
                                    "Laki-laki",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Radio<String>(
                                    value: "perempuan",
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Perempuan",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            // TextFormField(
                            //   controller: jk,
                            //   decoration: InputDecoration(
                            //     hintText: "Jenis Kelamin",
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
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: deskripsi,
                              maxLines: null, // memungkinkan input teks panjang
                              keyboardType:
                                  TextInputType.multiline, // input teks panjang
                              decoration: InputDecoration(
                                hintText: "Deskripsi Singkat",
                                hintStyle: TextStyle(fontSize: 14),
                                // border: UnderlineInputBorder(
                                //   borderSide: BorderSide(),
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
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Colors.green,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  _update().then((value) {
                                    if (value == 1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Berhasil edit Sejarawan!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  PageListSejarawan())),
                                          (route) => false);
                                    } else if (value == 2) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'email telah digunakan. gagal edit Sejarawan'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (value == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Gagal edit Sejarawan'),
                                          backgroundColor: Colors.deepOrange,
                                        ),
                                      );
                                    } else {}
                                  });
                                }
                              },
                              child: Text(
                                "Update Data",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
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