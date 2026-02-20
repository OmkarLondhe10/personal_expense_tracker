import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

      void signup() {
        final name = namecontroller.text.trim();
        final email = emailcontroller.text.trim();
        final password = passwordcontroller.text.trim();

        if (name.isEmpty || email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill all the fields')),
          );
          return;
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup Successful')),
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.person_add, size: 80),
            
            const SizedBox(height: 20),

            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                labelText: 'Full Name',
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.shadow,            
                  )
                )
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.shadow,
                  )
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                labelText: 'Password',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.shadow,
                  )
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary,
                ),
              ),
              onPressed: signup, 
              child: Text('Signup'),
            ),
          ],
        ),
        ),
    );
  }
}