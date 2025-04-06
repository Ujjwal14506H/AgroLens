import 'dart:io';

import 'package:flutter/material.dart';
import 'trasnlated.dart';
import 'package:provider/provider.dart';
// import 'main.dart'; //
import 'homepage.dart';
import 'language_provider.dart';
import 'signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _handleSignIn() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showDialog("Please fill all the fields!");
    } else {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          PageTransition(
            child: HomePage(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TranslatedText("Alert"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: TranslatedText("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Preload image after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/login.png'), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final languageCode = languageProvider.languageCode;
    // final languageCode = Provider.of<LanguageProvider>(context).languageCode;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: const AssetImage('assets/images/login.png'),
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                TranslatedText(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                // TextField(
                //   controller: _emailController,
                //   decoration: InputDecoration(
                //     hintText: 'Enter Email',
                //     prefixIcon: const Icon(Icons.alternate_email),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: languageProvider.getTranslatedText(
                      'Enter Email', // English
                      'ईमेल दर्ज करें', // Hindi
                      'ਈਮੇਲ ਦਰਜ ਕਰੋ', // Punjabi
                      languageCode,
                    ),
                    prefixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: languageProvider.getTranslatedText(
                      'Enter Password',
                      'पासवर्ड दर्ज करें',
                      'ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ',
                      languageCode,
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _handleSignIn,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff296e48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SpinKitFadingCircle(
                              color: Colors.white,
                              size: 30.0,
                            )
                          : TranslatedText(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Add forgot password functionality here
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14.0),
                        children: [
                          WidgetSpan(
                            child: TranslatedText(
                              'Forgot Password? ',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                          WidgetSpan(
                            child: TranslatedText(
                              'Reset Here',
                              style: const TextStyle(color: Color(0xff296e48)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff296e48)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/google.png'),
                      ),
                      TranslatedText(
                        'Sign In with Google',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const SignUp(),
                        type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14.0),
                        children: [
                          WidgetSpan(
                            child: TranslatedText(
                              "New to AgroLens",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                          WidgetSpan(
                            child: TranslatedText(
                              'Register',
                              style: const TextStyle(color: Color(0xff296e48)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'signup.dart';
// import 'main.dart';
// // You can change this import if you have a dedicated home page after login.
// // import 'otppage.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // Controllers for username and password
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // State to toggle password visibility
//   bool _isPasswordHidden = true;

//   // State to simulate loading animation on login button press
//   bool _isLoading = false;

//   // Simulated login function
//   void _login() {
//     setState(() {
//       _isLoading = true;
//     });
//     // Simulate a network call or authentication delay
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         _isLoading = false;
//       });

//       // Navigate to another page after login logic is complete.
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomePage()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // Removes the default back button
//         backgroundColor: Colors.transparent, // Transparent AppBar
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//             horizontal: 20.0), // Horizontal padding for better layout
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image at the top
//             Container(
//               width: double.infinity,
//               height: 250, // Adjusted height for the image
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/Login.png'),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30), // Rounded bottom-left corner
//                   bottomRight:
//                       Radius.circular(30), // Rounded bottom-right corner
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Centered welcome message
//             Center(
//               child: Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF503AB2), // Contrast color for the text
//                 ),
//               ),
//             ),
//             SizedBox(height: 40), // Increased spacing before login section
//             Text(
//               'Login',
//               style: TextStyle(
//                 fontSize: 32, // Increased font size for better readability
//                 fontWeight: FontWeight.bold,
//                 color: Color(
//                     0xFF6C63FF), // Added contrast color for better visibility
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Please enter your username and password',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 20),
//             // Username Input Field
//             TextField(
//               controller: usernameController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: 'Enter your username',
//                 labelText: 'Username',
//                 prefixIcon: Icon(Icons.person, color: Color(0xFF6C63FF)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Password Input Field with Visibility Toggle
//             TextField(
//               controller: passwordController,
//               obscureText: _isPasswordHidden,
//               decoration: InputDecoration(
//                 hintText: 'Enter your password',
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.lock, color: Color(0xFF6C63FF)),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
//                     color: Colors.black54,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isPasswordHidden = !_isPasswordHidden;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Login Button with Circular Animation
//             Center(
//               child: SizedBox(
//                 width: 250, // Custom width for the login button
//                 height: 50, // Height for the button
//                 child: TextButton(
//                   onPressed: _isLoading ? null : _login,
//                   style: TextButton.styleFrom(
//                     backgroundColor: Color(0xFF6C63FF),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     textStyle:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   child: _isLoading
//                       ? CircularProgressIndicator(
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                         )
//                       : Text('Login'),
//                 ),
//               ),
//             ),
//             SizedBox(height: 25),
//             // OR Divider
//             Row(
//               children: [
//                 Expanded(child: Divider()), // Divider before "OR"
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     'OR',
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(child: Divider()), // Divider after "OR"
//               ],
//             ),
//             SizedBox(height: 25),
//             // Google Sign-In Button
//             SizedBox(
//               width: double.infinity,
//               height: 50, // Height for the button
//               child: TextButton.icon(
//                 onPressed: () {
//                   // Add Google sign-in logic here
//                 },
//                 icon: Image.asset(
//                   'assets/images/google.png', // Assuming you have a Google logo image
//                   height: 30,
//                 ),
//                 label: Text(
//                   'Sign in with Google',
//                   style: TextStyle(
//                     color: Colors.black, // Text color will be black
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.white, // White background
//                   foregroundColor:
//                       Colors.black54, // Text color (Google Sign-In text)
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                         color: Colors.black, width: 2), // Black border color
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 25),
//             // New User sign up option
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'New to AgroLens? ',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RegisterPage()),
//                     );
//                   },
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF6C63FF),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'signup.dart';
// import 'main.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _userCtrl = TextEditingController();
//   final _passCtrl = TextEditingController();
//   bool _hidePass = true, _loading = false;

//   void _login() {
//     setState(() => _loading = true);
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() => _loading = false);
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => HomePage()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/Login.png'),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius:
//                             BorderRadius.vertical(bottom: Radius.circular(30)),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: Text('Welcome Back!',
//                           style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF503AB2))),
//                     ),
//                     SizedBox(height: 40),
//                     Text('Login',
//                         style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF6C63FF))),
//                     SizedBox(height: 10),
//                     Text('Enter your username and password',
//                         style: TextStyle(fontSize: 14, color: Colors.black54)),
//                     SizedBox(height: 20),
//                     TextField(
//                       controller: _userCtrl,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         hintText: 'Username',
//                         prefixIcon:
//                             Icon(Icons.person, color: Color(0xFF6C63FF)),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 BorderSide(color: Color(0xFF6C63FF), width: 2)),
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       controller: _passCtrl,
//                       obscureText: _hidePass,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         prefixIcon: Icon(Icons.lock, color: Color(0xFF6C63FF)),
//                         suffixIcon: IconButton(
//                           icon: Icon(_hidePass
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                           color: Colors.black54,
//                           onPressed: () =>
//                               setState(() => _hidePass = !_hidePass),
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 BorderSide(color: Color(0xFF6C63FF), width: 2)),
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextButton(
//                           onPressed: _loading ? null : _login,
//                           style: TextButton.styleFrom(
//                             backgroundColor: Color(0xFF6C63FF),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             textStyle: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           child: _loading
//                               ? CircularProgressIndicator(
//                                   valueColor:
//                                       AlwaysStoppedAnimation(Colors.white))
//                               : Text('Login'),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25),
//                     Row(
//                       children: [
//                         Expanded(child: Divider()),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Text('OR',
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                         Expanded(child: Divider()),
//                       ],
//                     ),
//                     SizedBox(height: 25),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: TextButton.icon(
//                         onPressed: () {},
//                         icon:
//                             Image.asset('assets/images/google.png', height: 30),
//                         label: Text('Sign in with Google',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16)),
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.black54,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             side: BorderSide(color: Colors.black, width: 2),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('New to AgroLens? ',
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.black)),
//                         GestureDetector(
//                           onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => RegisterPage())),
//                           child: Text('Sign Up',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0xFF6C63FF),
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
