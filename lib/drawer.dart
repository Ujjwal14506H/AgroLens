// import 'package:flutter/material.dart';

// class DrawerPage extends StatefulWidget {
//   @override
//   _DrawerPageState createState() => _DrawerPageState();
// }

// class _DrawerPageState extends State<DrawerPage> {
//   void logout(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Logout"),
//           content: Text("Are you sure you want to logout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//             ),
//             TextButton(
//               child: Text("Yes"),
//               onPressed: () {
//                 // Add your logout logic here
//                 Navigator.of(context).pop(); // Dismiss the dialog after logout
//                 // For example: Navigator.pushReplacementNamed(context, '/login');
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       width: 245.0,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: Colors.blue),
//             accountName: Text("John Doe", style: TextStyle(fontSize: 18)),
//             accountEmail: Text("johndoe@example.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: NetworkImage(
//                 "https://www.w3schools.com/howto/img_avatar.png",
//               ), // Replace with your image URL
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text("Home"),
//             onTap: () {
//               Navigator.pop(context); // Close drawer
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("Settings"),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text("Logout"),
//             onTap: () {
//               logout(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.help,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'sigin.dart';
import 'package:page_transition/page_transition.dart';
import 'settings.dart';
// import 'privacy.dart';
import 'help_support.dart';
import 'about.dart';
// import 'wholesale_main.dart';
import 'selection_screen.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.6, // 60% of the screen width
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xff296e48),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://www.w3schools.com/howto/img_avatar.png",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ujjwal Lamba',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ujjwallamba584@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _drawerListTile(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _drawerListTile(
              icon: Icons.lightbulb_outline,
              title: 'Help & Support',
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: HelpAndSupportPage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            _drawerListTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: SettingsPage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
            _drawerListTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () => Navigator.pop(context),
            ),
            _drawerListTile(
              icon: Icons.share_outlined,
              title: 'Share',
              onTap: _shareAppLink,
            ),
            _drawerListTile(
              icon: Icons.person_outline,
              title: 'About',
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: AboutPage(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              },
            ),
            _drawerListTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  //func to make share functional
  void _shareAppLink() {
    Share.share(
      'Check out this amazing app: https://AgroLens.com',
      subject: 'Agriculture App',
    );
  }

  //func to make logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectionScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
