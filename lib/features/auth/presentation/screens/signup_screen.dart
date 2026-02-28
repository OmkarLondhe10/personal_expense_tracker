import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/navigation/app_routes.dart';
import 'package:personal_expense_tracker/features/auth/presentation/screens/login_screen.dart';

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
              cursorColor: Theme.of(context).colorScheme.shadow,
              decoration: InputDecoration(
                hintText: 'Full Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.shadow
                  )
                )
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailcontroller,
              cursorColor: Theme.of(context).colorScheme.shadow,
              decoration: InputDecoration(
                hintText: 'Email',
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
              cursorColor: Theme.of(context).colorScheme.shadow,
              decoration: InputDecoration(
                hintText: 'Password',
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Alredy have a accout?"),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, AppRoutes.login);
                }, child: Text('Login')
                ),
              ],
            ),

          ],
        ),
        ),
    );
  }
}