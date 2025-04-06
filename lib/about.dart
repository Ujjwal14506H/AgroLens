// import 'package:flutter/material.dart';

// class AboutPage extends StatefulWidget {
//   @override
//   _AboutPageState createState() => _AboutPageState();
// }

// class _AboutPageState extends State<AboutPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.blueAccent,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "About Page",
//           style: TextStyle(
//             fontFamily: "Roboto",
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "About the App",
//                 style: TextStyle(
//                   fontFamily: "Roboto",
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "This app is built using Flutter and is designed to provide a seamless experience for managing daily tasks, accessing real-time data, and keeping track of important events. It includes features such as weather updates, crop monitoring, and quick access to essential tools—all wrapped up in an elegant, modern design.",
//                 style: TextStyle(
//                   fontFamily: "Roboto",
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Our Team",
//                 style: TextStyle(
//                   fontFamily: "Roboto",
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               SizedBox(height: 10),
//               _buildBulletItem("Ujjwal Lamba"),
//               _buildBulletItem("Mudit"),
//               _buildBulletItem("Yogya Chugh"),
//               _buildBulletItem("Bhavya Sehgal"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBulletItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "\u2022",
//             style: TextStyle(
//               fontSize: 20,
//               height: 1.55,
//               fontFamily: "Roboto",
//               color: Colors.black87,
//             ),
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: "Roboto",
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800]),
              ),
              SizedBox(height: 16),
              Text(
                'Our app empowers farmers and gardeners with cutting-edge tools for pest and disease identification. '
                'By harnessing advanced image processing and machine learning, we deliver real-time diagnoses to protect your crops and promote plant health. '
                'If you encounter pest invasions or notice early disease symptoms, our solution provides actionable insights and expert guidance to help your green spaces thrive.',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    height: 1.6,
                    color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                'Our Team:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                '• MR.Ujjwal Lamba\n'
                '• MR.Mudit Goswami\n'
                '• MR.Yogya Chugh\n'
                '• MS.Bhavya Sehgal',
                style: TextStyle(
                    fontSize: 17, fontFamily: 'Roboto', color: Colors.black54),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5)),
                  ],
                ),
                child: Text(
                  'Join us in our journey to transform plant care with innovative pest and disease detection technology. Let’s collaborate to nurture a greener tomorrow.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.green[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
