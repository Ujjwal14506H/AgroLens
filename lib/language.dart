import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectorPage extends StatefulWidget {
  final Function(String langCode) onLanguageChanged;

  const LanguageSelectorPage({required this.onLanguageChanged, Key? key})
      : super(key: key);

  @override
  _LanguageSelectorPageState createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _getSavedLanguage();
  }

  //func to fetch the saved lang
  void _getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //default lang is english
      selectedLanguage = prefs.getString('language') ?? 'en'; 
    });
  }

  // func. to save the lang
  void _changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);

    setState(() {
      selectedLanguage = langCode;
    });

    widget.onLanguageChanged(langCode);
    Navigator.pop(context);
  }

  //func. to create button for lang
  Widget _buildLanguageButton(String label, String langCode) {
    final isSelected = selectedLanguage == langCode;

    return GestureDetector(
      onTap: () => _changeLanguage(langCode),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (isSelected) 
  const Icon(Icons.check, color: Colors.white),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildLanguageButton('English', 'en'),
          _buildLanguageButton('हिन्दी', 'hi'),
          _buildLanguageButton('ਪੰਜਾਬੀ', 'pa'),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Update Langauge for better use.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
