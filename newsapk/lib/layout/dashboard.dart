import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapk/bloc/listnews_bloc.dart';
import 'package:newsapk/layout/adddataform.dart';
import '../bloc/login_bloc.dart';
import 'listnewsstate.dart';

class WelcomeScreen extends StatefulWidget {
  final String sessionToken;

  WelcomeScreen({required this.sessionToken});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      WelcomePage(sessionToken: widget.sessionToken),
      AboutPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final String sessionToken;

  WelcomePage({required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome!'),
          Text('Session Token: $sessionToken'),
          ElevatedButton(
            onPressed: () {
              // Dispatch logout event to bloc
              context.read<LoginBloc>().add(const ProsesLogout());
            },
            child: Text('Logout'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDataForm()),
              );
            },
            child: Text("Tambah Data"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListNewsState()),
              );
            },
            child: Text("Lihat Data"),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright by Kelompok 5',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Anggota:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aldi Permana Kusuma_21552011155',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Syifa Reviana H.P_21552011435',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Sri Cahya Kurniati_21552011429',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
