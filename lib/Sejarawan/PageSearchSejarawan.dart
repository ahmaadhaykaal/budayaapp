import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectuts/Model/SejarawanModel.dart';
import 'package:projectuts/Sejarawan/PageListDetailSejarawan.dart';

class PageSearchSejarawan extends StatefulWidget {
  const PageSearchSejarawan({Key? key});

  @override
  State<PageSearchSejarawan> createState() => _PageSearchSejarawanState();
}

class _PageSearchSejarawanState extends State<PageSearchSejarawan> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _sejarawanList = [];
  List<dynamic> _filteredSejarawanList = [];

  @override
  void initState() {
    super.initState();
    fetchSejarawan();
  }

  Future<void> fetchSejarawan() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.4/utsDb/getSejarawan.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _sejarawanList = responseData['data'];
        _filteredSejarawanList = _sejarawanList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterSejarawan(String query) {
    setState(() {
      _filteredSejarawanList = _sejarawanList
          .where((nama) =>
              nama['nama'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic sejarawanData) {
  Datum? sejarawan = Datum.fromJson(sejarawanData); // Mengonversi JSON menjadi objek Datum
  if (sejarawan != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageDetailSejarawan(sejarawan)),
    );
  } else {
    // Handle error or show message that data is not available
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Info Seputar Sejarawan',
          style: TextStyle(color: Color.fromARGB(255, 74, 48, 0), fontSize: 18),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 74, 48, 0)),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterSejarawan(value);
              },
              decoration: InputDecoration(
                labelText: 'search',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 192, 178, 52)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSejarawanList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      _filteredSejarawanList[index]['nama'],
                      style: TextStyle(color: Color.fromARGB(255, 74, 48, 0)),
                    ),
                    onTap: () => _navigateToDetail(_filteredSejarawanList[index]), 
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}