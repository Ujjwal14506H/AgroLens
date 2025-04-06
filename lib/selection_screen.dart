import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'marketplace_screen.dart';
import 'sigin.dart';
import 'trasnlated.dart';

class SelectionScreen extends StatefulWidget {
  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool loadingHome = false;
  bool loadingMarket = false;

  void handleTap(Widget screen, bool isHome) async {
    setState(() {
      if (isHome) {
        loadingHome = true;
      } else {
        loadingMarket = true;
      }
    });

    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

    setState(() {
      loadingHome = false;
      loadingMarket = false;
    });
  }

  Widget buildButton(String label, bool isLoading, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? SpinKitFadingCircle(color: Colors.white, size: 30)
            : TranslatedText(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEEE1),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/customer.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                buildButton(
                    "Home", loadingHome, () => handleTap(SignIn(), true)),
                SizedBox(height: 20),
                buildButton("Market", loadingMarket,
                    () => handleTap(MarketplaceScreen(), false)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectionScreen extends StatefulWidget {
//   @override
//   _SelectionScreenState createState() => _SelectionScreenState();
// }

// class _SelectionScreenState extends State<SelectionScreen> {
//   bool isLoadingHome = false;
//   bool isLoadingMarket = false;

//   void navigateToScreen(Widget screen, bool isMarket) {
//     setState(() {
//       if (isMarket) {
//         isLoadingMarket = true;
//       } else {
//         isLoadingHome = true;
//       }
//     });

//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         isLoadingHome = false;
//         isLoadingMarket = false;
//       });

//       Navigator.of(context).push(
//         PageRouteBuilder(
//           transitionDuration: Duration(milliseconds: 500),
//           pageBuilder: (context, animation, secondaryAnimation) => screen,
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: child,
//             );
//           },
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/customer.png',
//               height: double.infinity,
//               // width: double.infinity,
//               // fit: BoxFit.cover,
//             ),
//           ),

//           // Content
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(height: 100), // Gives some spacing at the top
//               // Text(
//               //   // "Where do you want to go?",
//               //   style: TextStyle(
//               //       fontSize: 22,
//               //       fontWeight: FontWeight.bold,
//               //       color: Colors.white),
//               //   textAlign: TextAlign.center,
//               // ),
//               Spacer(),

//               // Buttons Section
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 50),
//                 child: Column(
//                   children: [
//                     buildButton("Go to Home", isLoadingHome,
//                         () => navigateToScreen(HomePage(), false)),
//                     SizedBox(height: 20),
//                     buildButton("Enter Market", isLoadingMarket,
//                         () => navigateToScreen(MarketplaceScreen(), true)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Reusable button widget
//   Widget buildButton(String text, bool isLoading, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         width: 250,
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.green[700],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Center(
//           child: isLoading
//               ? SpinKitThreeBounce(color: Colors.white, size: 20)
//               : Text(
//                   text,
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//         ),
//       ),
//     );
//   }
// }
