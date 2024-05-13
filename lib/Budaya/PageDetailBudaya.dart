
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectuts/Model/BudayaModel.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // data!.judul,
          "Detail Budaya",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.1.4/utsDb/gambar_budaya/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle:
                Text(DateFormat().format(data?.tglMasuk ?? DateTime.now())),
            trailing: Icon(
              Icons.star,
              color: Colors.pink,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.isi ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}