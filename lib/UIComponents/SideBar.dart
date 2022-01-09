// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Color firstGreen = const Color.fromARGB(255, 48, 176, 99);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 149,
            child: DrawerHeader(
              child: const Text(
                'Your Cool Sidebar',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: firstGreen,
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage('assets/images/cover.jpg'),
                // ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            title: const Text(
              'Write Drive',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              //UseGoogleDrive.instance.saveLibrary();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.file_download,
              color: Colors.white,
            ),
            title: const Text(
              'Read Drive',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.create,
              color: Colors.white,
            ),
            title: const Text(
              'Create JSON',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
