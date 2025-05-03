
  import 'package:flutter/material.dart';

Drawer drawers(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
          ),
          ListTile(
            leading: Icon(
              Icons.label,
              color: Colors.black, // White icon for drawer item
            ),
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black, // White icon for drawer item
            ),
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }