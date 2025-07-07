import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'language_provider.dart';
import 'profile.dart';
import 'scan.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
// import 'Splash.dart';
import 'calendar.dart';
// import 'scan.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'drawer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String apiKey = "YOUR_API_KEY";
  String city = "Delhi";
  String currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());
  String temperature = 'Loading...';
  String windSpeed = 'Loading...';
  String humidity = 'Loading...';
  String airQuality = 'Loading...';
  String pestRisk = 'Low';
  String detectedLocale = "en";
  int _currentIndex = 0;

  bool isVisible = false;
  bool isMicopen = false;

  final iconList = [
    Icons.home_rounded,
    Icons.eco_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  stt.SpeechToText _speech = stt.SpeechToText();
  String recognizedText = "";

  Future<void> _requestMicPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isDenied) {
      print("Microphone permission denied.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _toggleMic() async {
    if (!isMicopen) {
      // check if the recognizer can be intialized
      bool isAvailable = await _speech.initialize(
        onStatus: (status) {
          //check if status = done then close the mic
          if (status == "done") {
            setState(() {
              isMicopen = false;
            });
          }
        },
        onError: (error) {
          setState(() {
            isMicopen = false;
          });
        },
      );

      if (isAvailable) {
        // fetch the list of available langauge and get the first one
        List<stt.LocaleName> locales = await _speech.locales();
        detectedLocale = locales.isNotEmpty ? locales.first.localeId : "en";

        setState(() {
          isMicopen = true;
        });

        _speech.listen(
          localeId: detectedLocale,
          onResult: (result) async {
            String command = result.recognizedWords.toLowerCase();

            if (command.isNotEmpty) {
              // update the text recognized
              setState(() {
                recognizedText = command;
              });

              // check if the command is not in english then translate it
              if (!detectedLocale.startsWith("en")) {
                final translation =
                    await GoogleTranslator().translate(command, to: 'en');
                command = translation.text.toLowerCase();
              }

              //process the command
              _handleVoiceCommand(command);

              // stop nd close the mic
              _speech.stop();
              setState(() {
                isMicopen = false;
              });
            }
          },
        );
      }
    } else {
      // if the mic is open stop nd close
      _speech.stop();
      setState(() {
        isMicopen = false;
      });
    }
  }

  void _handleVoiceCommand(String command) {
    if (command.contains("settings")) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    } else if (command.contains("profile")) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    } else if (command.contains("change language")) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    } else if (command.contains("home")) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      print("Command not recognized: $command"); // Optional
    }
  }

  // void _toggleMic() async {
  //   if (!isMicopen) {
  //     bool available = await _speech.initialize(
  //       onStatus: (status) {
  //         if (status == "done") {
  //           setState(() {
  //             isMicopen = false;
  //           });
  //         }
  //       },
  //     );

  //     if (available) {
  //       setState(() {
  //         isMicopen = true;
  //       });

  //       _speech.listen(
  //         onResult: (result) {
  //           setState(() {
  //             recognizedText = result.recognizedWords;
  //           });
  //           _handleVoiceCommand(recognizedText);
  //         },
  //       );
  //     }
  //   } else {
  //     _speech.stop();
  //     setState(() {
  //       isMicopen = false;
  //     });
  //   }
  // }

  // void _handleVoiceCommand(String command) {
  //   command = command.toLowerCase();

  //   if (command.contains("settings")) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SettingsPage()));
  //   } else if (command.contains("profile")) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => ProfilePage()));
  //   } else if (command.contains("home")) {
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   }
  //   // Add more commands as needed
  // }

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      fetchWeatherData();
      updateDate();
    });
  }

  void updateDate() {
    setState(() {
      currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());
    });
  }

  Future<void> fetchWeatherData() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          isVisible = false;
        });

        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            temperature = "${data['main']['temp']}°C";
            windSpeed = "${data['wind']['speed']} m/s";
            humidity = "${data['main']['humidity']}%";
            airQuality = "Good";
            pestRisk = (double.parse(data['main']['humidity'].toString()) > 70)
                ? "High"
                : "Low";
            isVisible = true;
          });

          _animationController.forward(from: 0);
        });
      } else {
        showError();
      }
    } catch (e) {
      showError();
    }
  }

  void showError() {
    setState(() {
      temperature = 'Error';
      windSpeed = 'Error';
      humidity = 'Error';
      airQuality = 'Error';
      pestRisk = 'Unknown';
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          "AgroLens",
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isMicopen ? Icons.mic : Icons.mic_off,
              color: Colors.black87,
            ),
            onPressed: _toggleMic,
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 800),
                        opacity: isVisible ? 1.0 : 0.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            currentDate,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // Align elements
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                weatherDetail(Icons.thermostat_rounded,
                                    'Temperature', temperature),
                                weatherDetail(
                                    Icons.invert_colors, 'Humidity', humidity),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                weatherDetail(
                                    Icons.air, 'Wind Speed', windSpeed),
                                weatherDetail(Icons.emoji_nature, 'Air Quality',
                                    airQuality),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text("Crop Health",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  cropHealthCard(Icons.eco, "Plant Growth", "Healthy"),
                  SizedBox(width: 8),
                  cropHealthCard(Icons.bug_report, "Pest Risk", pestRisk),
                ],
              ),
              SizedBox(height: 24),
              Text("Quick Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  quickActionCard(
                      Icons.camera_alt_rounded, "Scan Plant", context),
                  SizedBox(width: 8),
                  quickActionCard(
                      Icons.bug_report_rounded, "Scan Pest", context),
                  SizedBox(width: 8),
                  quickActionCard(Icons.book_rounded, "Guide", context),
                ],
              ),
              SizedBox(height: 24),
              Text("Today's Tasks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView(
                  children: [
                    taskCard(
                        Icons.grass, "Apply Fertilizer", "Field A - Morning"),
                    taskCard(Icons.waves, "Check Soil Moisture",
                        "Field B - Afternoon"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to camera page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScanPage()));
        },
        backgroundColor: Color(0xFF547D5B),
        splashColor: Color(0xff296e48),
        child: Icon(Icons.camera_alt_rounded, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 16,
        rightCornerRadius: 16,
        backgroundColor: Colors.white,
        activeColor: Color(0xff296e48),
        inactiveColor: Colors.black.withOpacity(.5),
        splashColor: Color(0xff296e48),
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 0) {
            // Navigate or stay on home
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
      // );
    );
  }

  Widget weatherDetail(IconData icon, String title, String value) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        width: 140,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Color(0xFF547D5B)),
            SizedBox(height: 6),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            SizedBox(height: 4),
            Text(value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget cropHealthCard(IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Container(
          height: 120,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Color(0xFF547D5B), size: 25),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget quickActionCard(IconData icon, String title, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == "Guide") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropAdvisor()),
            );
          }
          if (title == "Scan Plant") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanPage()),
            );
          }
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 30, color: Color(0xFF547D5B)),
                SizedBox(height: 4),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskCard(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        iconColor: Color(0xFF547D5B),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.black54)),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:intl/intl.dart';
// import 'Splash.dart';
// import 'calendar.dart';
// import 'drawer.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   String apiKey = "f698e0e393067c15dbf3a620ecf44a14";
//   String city = "Delhi";
//   String currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());

//   String temperature = 'Loading...';
//   String windSpeed = 'Loading...';
//   String humidity = 'Loading...';
//   String airQuality = 'Loading...';
//   String pestRisk = 'Low';

//   bool isVisible = false;

//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchWeatherData();

//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 0.2),
//       end: Offset(0, 0),
//     ).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );

//     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
//       fetchWeatherData();
//       updateDate();
//     });
//   }

//   void updateDate() {
//     setState(() {
//       currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());
//     });
//   }

//   Future<void> fetchWeatherData() async {
//     final url = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         setState(() {
//           isVisible = false;
//         });

//         Future.delayed(Duration(milliseconds: 500), () {
//           setState(() {
//             temperature = "${data['main']['temp']}°C";
//             windSpeed = "${data['wind']['speed']} m/s";
//             humidity = "${data['main']['humidity']}%";
//             airQuality = "Good";
//             pestRisk = (double.parse(data['main']['humidity'].toString()) > 70)
//                 ? "High"
//                 : "Low";
//             isVisible = true;
//           });

//           _animationController.forward(from: 0);
//         });
//       } else {
//         showError();
//       }
//     } catch (e) {
//       showError();
//     }
//   }

//   void showError() {
//     setState(() {
//       temperature = 'Error';
//       windSpeed = 'Error';
//       humidity = 'Error';
//       airQuality = 'Error';
//       pestRisk = 'Unknown';
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//         title: Text(
//           "AgroLens",
//           style: TextStyle(
//             fontFamily: 'Helvetica',
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       drawer: CustomDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Material(
//                 elevation: 2.0,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AnimatedOpacity(
//                         duration: Duration(milliseconds: 800),
//                         opacity: isVisible ? 1.0 : 0.0,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           child: Text(
//                             currentDate,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SlideTransition(
//                         position: _slideAnimation,
//                         child: Wrap(
//                           spacing: 12,
//                           runSpacing: 12,
//                           alignment: WrapAlignment.center,
//                           children: [
//                             weatherDetail(Icons.thermostat_rounded,
//                                 'Temperature', temperature),
//                             weatherDetail(Icons.air, 'Wind Speed', windSpeed),
//                             weatherDetail(
//                                 Icons.invert_colors, 'Humidity', humidity),
//                             weatherDetail(
//                                 Icons.emoji_nature, 'Air Quality', airQuality),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               Text("Crop Health",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   cropHealthCard(Icons.eco, "Plant Growth", "Healthy"),
//                   SizedBox(width: 8),
//                   cropHealthCard(Icons.bug_report, "Pest Risk", pestRisk),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Text("Quick Actions",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   quickActionCard(Icons.camera_alt, "Scan Plant", context),
//                   SizedBox(width: 8),
//                   quickActionCard(Icons.water_drop, "Irrigation", context),
//                   SizedBox(width: 8),
//                   quickActionCard(Icons.book, "Guide", context),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Text("Today's Tasks",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               SizedBox(
//                 height: 150,
//                 child: ListView(
//                   children: [
//                     taskCard(
//                         Icons.grass, "Apply Fertilizer", "Field A - Morning"),
//                     taskCard(Icons.waves, "Check Soil Moisture",
//                         "Field B - Afternoon"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.transparent,
//         color: Colors.green,
//         height: 50,
//         items: [
//           Icon(Icons.home_rounded, color: Colors.white, size: 30),
//           Icon(Icons.camera_alt_rounded, color: Colors.white, size: 30),
//           Icon(Icons.person_rounded, color: Colors.white, size: 30),
//         ],
//         onTap: (index) {
//           // Handle navigation tap if needed
//         },
//       ),
//     );
//   }

//   Widget weatherDetail(IconData icon, String title, String value) {
//     return AnimatedOpacity(
//       duration: Duration(milliseconds: 500),
//       opacity: isVisible ? 1.0 : 0.0,
//       child: Container(
//         width: 140,
//         padding: EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: Colors.blue),
//             SizedBox(height: 6),
//             Text(title,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
//             SizedBox(height: 4),
//             Text(value,
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget cropHealthCard(IconData icon, String title, String value) {
//     return Expanded(
//       child: Card(
//         color: Colors.white,
//         child: Container(
//           height: 120, // Set a fixed height for consistency
//           padding: EdgeInsets.all(8), // Adjust the padding as needed
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: Colors.green),
//               SizedBox(height: 8),
//               Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 4),
//               Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget quickActionCard(IconData icon, String title, BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (title == "Guide") {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CropAdvisor()),
//             );
//           }
//         },
//         child: Card(
//           color: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon, size: 30),
//                 SizedBox(height: 4),
//                 Text(title),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget taskCard(IconData icon, String title, String subtitle) {
//     return Card(
//       color: Colors.white,
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(subtitle, style: TextStyle(color: Colors.black54)),
//       ),
//     );
//   }
// }
