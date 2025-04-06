import 'package:flutter/material.dart';
import 'privacy.dart';
import 'profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Logout.dart';
import 'language.dart';
import 'language_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileMenu(
              text: "Dark Mode",
              icon: Icons.dark_mode,
              press: () {},
            ),
            ProfileMenu(
              text: "Change Language",
              icon: Icons.language,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectorPage(
                      onLanguageChanged: (String langCode) async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('selected_lang', langCode);

                        final provider = Provider.of<LanguageProvider>(context,
                            listen: false);
                        provider.changeLanguage(langCode);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Language changed to $langCode"),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            ProfileMenu(
              text: "Manage Profile",
              icon: Icons.manage_accounts,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ProfileMenu(
              text: "Privacy Policy",
              icon: Icons.lock,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),
            ProfileMenu(
              text: "Sign Out",
              icon: Icons.exit_to_app,
              press: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFFF7643),
              size: 22,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// // SettingsPage Widget: Represents the settings screen.
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDarkMode = false; // Tracks the state of the Dark Mode toggle.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Settings",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//             color: Colors.black,
//             fontFamily: 'SF Pro Display',
//           ),
//         ),
//         centerTitle: true, // Centers the title on the AppBar.
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Preferences",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'SF Pro Display',
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Builds a tile for Dark Mode toggle.
//             buildPreferenceTile(
//               title: "Dark Mode",
//               icon: Icons.dark_mode,
//               trailing: Switch(
//                 value: isDarkMode,
//                 activeColor: Colors.black,
//                 onChanged: (value) {
//                   setState(() {
//                     isDarkMode = value; // Updates the Dark Mode state.
//                   });
//                 },
//               ),
//             ),
//             buildPreferenceTile(
//               title: "Change Location",
//               icon: Icons.location_on,
//               onTap: () {
//                 // Handle location change logic here.
//               },
//             ),
//             buildPreferenceTile(
//               title: "Change Language",
//               icon: Icons.language,
//               onTap: () {
//                 // Handle language change logic here.
//               },
//             ),
//             buildPreferenceTile(
//               title: "Manage Profile",
//               icon: Icons.person,
//               onTap: () {
//                 // Handle profile management logic here.
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Custom reusable tile widget for preferences.
//   Widget buildPreferenceTile({
//     required String title,
//     required IconData icon,
//     Widget? trailing,
//     VoidCallback? onTap,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Icon(icon, color: Colors.black, size: 28),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           fontFamily: 'SF Pro Display',
//         ),
//       ),
//       trailing: trailing ??
//           const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//       onTap: onTap,
//     );
//   }
// }
//
