import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              policySection("1. Introduction",
                  "We value your privacy and are committed to protecting your personal data."),
              policySection("2. Data Collection",
                  "We collect necessary data to provide better service."),
              policySection("3. Use of Data",
                  "Your data is used to improve our app experience."),
              policySection("4. Data Sharing",
                  "We do not sell or share your personal data with third parties."),
              policySection("5. Security Measures",
                  "We implement strong security measures to protect your data."),
              policySection("6. User Rights",
                  "You have the right to access, update, and delete your data."),
              policySection("7. Cookies Policy",
                  "We use cookies to enhance user experience."),
              policySection("8. Changes to Policy",
                  "We may update our policy, and changes will be reflected here."),
              policySection("9. Contact Us",
                  "For any privacy-related concerns, reach out to us."),
              policySection("10. Consent",
                  "By using our app, you consent to our Privacy Policy."),
            ],
          ),
        ),
      ),
    );
  }

  Widget policySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
