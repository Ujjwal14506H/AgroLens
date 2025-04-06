import 'package:flutter/material.dart';
import 'privacy.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Find answers to common questions or contact our support team.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildSupportOption(
                    icon: Icons.help_outline,
                    title: "FAQs",
                    subtitle: "Find answers to frequently asked questions.",
                                        onTap: () => Navigator.of(context)

                  ),
                  _buildSupportOption(
                    icon: Icons.email_outlined,
                    title: "Contact Us",
                    subtitle: "Send us an email for further assistance.",
                                        onTap: () => Navigator.of(context)

                  ),
                  _buildSupportOption(
                    icon: Icons.chat_bubble_outline,
                    title: "Live Chat", //todo: make it functional
                    subtitle: "Chat with our support team in real-time.",
                    onTap: () => Navigator.of(context)
                  ),
                  _buildSupportOption(
                      icon: Icons.security,
                      title: "Privacy & Security",
                      subtitle: "Learn how we protect your data and privacy.",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage()),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff296e48)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
