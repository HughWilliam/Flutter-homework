import 'package:homework/listview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Product1(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginStage();
}

class _LoginStage extends State<Login> {
  bool _passwordVisible = true;
  final _emailFormkey = GlobalKey<FormState>();
  final _passwordFormkey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _loginAccount() {
    if (_emailFormkey.currentState!.validate() &&
        _passwordFormkey.currentState!.validate()) {
      setState(() {
        print('You are logined');
      });
    }
  }

  Future<void> launchMywebsite(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (err) {
      //dsd
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Form(
              key: _emailFormkey,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Icon(Icons.email, size: 20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: _validateEmail,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _passwordFormkey,
              child: TextFormField(
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Icon(Icons.lock, size: 20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _showPassword,
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: _validatePassword,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _loginAccount,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  //style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/fb_icon.png'),
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Log in with Facebook',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Create new account',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text('Get to app'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    alignment: Alignment.topLeft,
                    icon: const Image(
                      image: NetworkImage(
                          'https://static.cdninstagram.com/rsrc.php/v3/yt/r/Yfc020c87j0.png'),
                      width: 150,
                      height: 50,
                    ),
                    onPressed: () async {
                      launchMywebsite('https://www.apple.com/vn/app-store/');
                    },
                  ),
                  const SizedBox(width: 50),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: const Image(
                      image: NetworkImage(
                          'https://static.cdninstagram.com/rsrc.php/v3/yz/r/c5Rp7Ym-Klz.png'),
                      width: 150,
                      height: 50,
                    ),
                    onPressed: () async {
                      launchMywebsite(
                          'https://play.google.com/store/games?hl=vi');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
