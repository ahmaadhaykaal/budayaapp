import 'package:flutter/material.dart';
import 'package:projectuts/PageUpdateProfil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageProfil extends StatefulWidget {
  @override
  _PageProfilState createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  late String username;
  late String fullname;
  late String email;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      fullname = prefs.getString('fullname') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Detail Data ' + data!.nama, style: TextStyle(color: Colors.white),), //data!.nama
        title: Text(
          'Info Profile',
          style: TextStyle(color: Colors.white),
        ), //data!.nama
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        // backgroundColor: Colors.pink.withOpacity(0.5),
      ),
      body: Center(
        child: Card(
          color: Color.fromARGB(255, 255, 246, 249),
          shadowColor: Colors.grey,
          margin: EdgeInsets.all(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.green, // Warna latar belakang avatar
                radius: 70, // ukuran avatar
                child: Icon(
                  Icons.person, // Ikon persona
                  color: Colors.white, // warna ikon
                  size: 70, // ukuran ikon
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  '$fullname',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                ),
                subtitle: Text(
                  'Username : $username\n' + 'Email : $email',
                  maxLines: 4,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageUpdateProfil()),
                    ).then((value) {
                      if (value != null && value) {
                        _loadProfile();
                      }
                    });
                  },
                ),
              ),
              Divider(height: 30, thickness: 1.5, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
