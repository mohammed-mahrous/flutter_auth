import 'package:flutter/material.dart';
import 'package:flutter_sanctum_auth_app/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ButtonBar(
            children: [
              IconButton(
                tooltip: 'logout',
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.popAndPushNamed(context, '/login');
                },
                icon: Icon(Icons.logout),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Consumer(
          builder: (context, Auth auth, child) {
            return ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Center(
        child: Text('homepage'),
      ),
    );
  }
}
