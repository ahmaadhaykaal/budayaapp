import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:projectuts/Model/SejarawanModel.dart';
import 'package:projectuts/Sejarawan/PageCreateSejarawan.dart';
import 'package:projectuts/Sejarawan/PageListDetailSejarawan.dart';
import 'package:projectuts/Sejarawan/PageSearchSejarawan.dart';
import 'package:projectuts/main.dart';

class PageListSejarawan extends StatefulWidget {
  const PageListSejarawan({super.key});

  @override
  State<PageListSejarawan> createState() => _PageListSejarawanState();
}

class _PageListSejarawanState extends State<PageListSejarawan> {
  Future<List<Datum>?> getSejarawan() async {
    try {
      http.Response res = await http
          .get(Uri.parse('http://192.168.1.4/utsDb/getSejarawan.php'));
      return sejarawanModelFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future _delete(String id) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.1.4/utsDb/deleteSejarawan.php'),
          body: {
            "id": id,
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sejarawan',
            style: TextStyle(color: Colors.white),
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 74, 48, 0)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageSearchSejarawan();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return createSejarawan();
                }));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            // color: Color.fromARGB(255, 255, 213, 97),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: FutureBuilder(
                    future: getSejarawan(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Datum>?> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            Datum? data = snapshot.data?[index];
                            return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageDetailSejarawan(data)));
                                  },
                                  child: Card(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'http://192.168.1.4/utsDb/gambar_sejarawan/${data?.foto}',
                                            // fit: BoxFit.fill,
                                            height: 250,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          "${data?.nama}",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 74, 48, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "${data?.asal}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black54),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Color.fromARGB(255, 74, 48, 0),
                                          iconSize: 20,
                                          onPressed: () {
                                            // Aksi yang dijalankan saat tombol hapus ditekan
                                            // _deleteItem(data);
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Apakah yakin menghapus data?",style: TextStyle(color: Color.fromARGB(255, 74, 48, 0)),),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            _delete(data!.id)
                                                                .then((value) {
                                                              if (value) {
                                                                final snackBar =
                                                                    SnackBar(
                                                                  content:
                                                                      const Text(
                                                                          'Data Berhasil Dihapus'),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);
                                                              } else {
                                                                final snackBar =
                                                                    SnackBar(
                                                                  content:
                                                                      const Text(
                                                                          'Data Gagal Dihapus'),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);
                                                              }
                                                            });
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        ((context) =>
                                                                            PageListSejarawan())),
                                                                (route) =>
                                                                    false);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green, // Background color of the button
                                                          ),
                                                          child: Text(
                                                            "Hapus",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        74,
                                                                        48,
                                                                        0)),
                                                          )),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Batal",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        74,
                                                                        48,
                                                                        0)),
                                                          )),
                                                    ],
                                                  );
                                                }));
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                                ));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.orange,
                        ));
                      }
                    }),
              )),
        ));
  }
}