
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectuts/Model/SejarawanModel.dart';
import 'package:projectuts/Sejarawan/PageUpdateSejarawan.dart';

class PageDetailSejarawan extends StatelessWidget {
  final Datum? data;

  const PageDetailSejarawan(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail Sejarawan',
            style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 74, 48, 0)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.1.4/utsDb/gambar_sejarawan/${data?.foto}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.nama ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,),
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy').format(data?.tglLahir ?? DateTime.now()),
              style: TextStyle(
                fontSize: 11,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromARGB(255, 74, 48, 0),
              ),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return updateSejarawan(
                        ListData: {
                          "id": data?.id,
                          "nama": data?.nama,
                          "tgl_lahir": data?.tglLahir,
                          "asal": data?.asal,
                          "jk": data?.jk,
                          "deskripsi": data?.deskripsi,
                          "foto": data?.foto,
                        },
                      );
                    }));
              },
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                    top: Radius.circular(20),
                  ),
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Asal\t\t:",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 74, 48, 0)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          data?.asal ?? "\n",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 74, 48, 0)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Jenis Kelamin :",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 74, 48, 0)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          data?.jk ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 74, 48, 0)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data?.deskripsi ?? "",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 74, 48, 0)),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}