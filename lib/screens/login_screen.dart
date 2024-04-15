import 'package:flutter/material.dart';
import 'package:task1/screens/profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _validUsername = "minujadhav";
  final String _validPassword = "minu";
  bool _showUsernameError = false;
  bool _showPasswordError = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 70),
        child: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          children: [
            const Center(
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,fontFamily: 'FontMain',
                  fontSize: 24.0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Username TextField
            const Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Username Error Message
            if (_showUsernameError)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Invalid username',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 10),

            const Text(
              'Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding: const EdgeInsets.all(10.0),

                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            if (_showPasswordError)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Invalid password',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showUsernameError = false;
                  _showPasswordError = false;
                });
                _login();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    String enteredUsername = _usernameController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == _validUsername && enteredPassword == _validPassword) {
      // Navigate to the next screen if credentials are correct
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile_Page()),
      );
      // Optional: you can clear the text fields after successful login
      _usernameController.clear();
      _passwordController.clear();
      // Optional: you can also print a success message
      print('Login Successful');
    } else {
      if (enteredUsername != _validUsername) {
        setState(() {
          _showUsernameError = true;
        });
      }
      if (enteredPassword != _validPassword) {
        setState(() {
          _showPasswordError = true;
        });
      }
    }
  }
}
