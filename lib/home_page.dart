import 'package:flutter/material.dart';
import 'constant.dart';
import 'dashboard.dart';
import 'content_input_page.dart';
import 'Model/user_model.dart';
import 'package:provider/provider.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> getContents(BuildContext context) {
    return <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${Provider.of<UserModel>(context, listen: false).userEmail!}',
            style: kOptionStyle,
          ),
          Text(
            '${Provider.of<UserModel>(context, listen: false).userNick!}',
            style: kOptionStyle,
          ),
        ],
      ),

      DashBoard(),
      Text(
        'Index 2: Settings',
        style: kOptionStyle,
      ),
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
        title: const Text('Lawming'),
      ),
      body: Center(
        child: getContents(context).elementAt(_selectedIndex),
      ),
      floatingActionButton: Visibility(
        visible: _selectedIndex == 1 ? true : false,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ContentInputPage()));
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Lawming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
