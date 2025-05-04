import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, // This makes the drawer icon white
          ),
          title: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true, // This makes the drawer icon white
        ),
      body: Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}