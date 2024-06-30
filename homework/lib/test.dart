import 'package:flutter/material.dart';

Widget buildLoginScreen() {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Image(
            image: NetworkImage(
                'https://i.ibb.co/jVPrFbM/Gray-and-Black-Simple-Studio-Logo-1.png'),
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Icon(Icons.email, size: 20),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
