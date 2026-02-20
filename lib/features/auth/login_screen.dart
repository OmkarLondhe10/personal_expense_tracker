import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/navigation/app_routes.dart';
import 'package:personal_expense_tracker/core/widgets/main_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future<void> _loginSubmitted() async{
    final username = usernamecontroller.text.trim();
    final password = passwordcontroller.text.trim();

    if(username.isEmpty || password .isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter the data'))
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);

    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_)=> const MainNavigation(),
        ), 
      (route)=> false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.login, size: 80),

          const SizedBox(height: 20),

          TextField(
            controller: usernamecontroller,
            decoration: InputDecoration(
              labelText: 'Username',
              hintStyle: TextStyle(),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: passwordcontroller,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: _loginSubmitted,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.tertiary,
              ),
            ), 
            child: const Text('Login'),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have a accout? "),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, AppRoutes.signup);
                }, child: Text('Sign Up')
              ),
            ],
          ),
          ],
        ),
        ),
    );
  }
}