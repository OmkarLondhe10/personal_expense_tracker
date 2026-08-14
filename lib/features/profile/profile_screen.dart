import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../provider/app_settings_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              user?.displayName?.isNotEmpty == true
                  ? user!.displayName!
                  : (user?.email ?? "No Name"),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (user?.email != null) ...[
            const SizedBox(height: 4),
            Center(
              child: Text(
                user!.email!,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ],
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
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
