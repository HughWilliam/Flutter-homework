import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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

  void _submit() {
    if (_emailFormKey.currentState!.validate() &&
        _passwordFormKey.currentState!.validate()) {
      print('Both email and password are valid');
    }
  }

  String? _checkEmail(String? value) {
    return _emailController.text.isEmpty ? 'Please enter your email' : null;
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Image(
              height: 180,
              width: double.infinity,
              image: NetworkImage(
                  'https://i.ibb.co/jVPrFbM/Gray-and-Black-Simple-Studio-Logo-1.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _emailFormKey,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  prefixIcon: const Icon(
                    Icons.email,
                    size: 18,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
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
                cursorColor: Colors.black,
                validator: _validateEmail,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _passwordFormKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
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
                obscureText: _obscureText,
                cursorColor: Colors.black,
                validator: _validatePassword,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý đăng nhập ở đây
                  _submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(1),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Điều chỉnh bán kính ở đây
                  ),
                ),
                child: Text(
                  'Log in',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.4),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/fb_icon.png',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Log in with Facebook',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Xử lý quên mật khẩu ở đây
                  if (kDebugMode) {
                    print('Forgot password button pressed');
                  }
                },
                child: Text(
                  'Forgot password?',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {
                  // Xử lý quên mật khẩu ở đây
                  print('Forgot password button pressed');
                },
                child: Text(
                  'Create new account',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Get to app',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, right: 35, top: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Image(
                      width: double.infinity,
                      image: NetworkImage(
                          'https://static.cdninstagram.com/rsrc.php/v3/yt/r/Yfc020c87j0.png'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Image(
                      width: double.infinity,
                      image: NetworkImage(
                          'https://static.cdninstagram.com/rsrc.php/v3/yz/r/c5Rp7Ym-Klz.png'),
                    ),
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
