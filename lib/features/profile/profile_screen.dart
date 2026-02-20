import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "John Doe",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),

          SwitchListTile(
            value: settings.darkmode,
            title: const Text("Dark Mode"),
            secondary: const Icon(Icons.dark_mode),
            onChanged: (value) {
              settings.tottgleDarkMode(value);
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Expense Tracker",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Your Company",
              );
            },
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('loggedIn');

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
