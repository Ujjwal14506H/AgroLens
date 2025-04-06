import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'language_provider.dart';

class TranslatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const TranslatedText(this.text, {this.style, Key? key}) : super(key: key);

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  String translatedText = '';
  final translator = GoogleTranslator();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translate();
  }

  @override
  void didUpdateWidget(covariant TranslatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _translate();
  }

  Future<void> _translate() async {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final langCode = langProvider.languageCode;

    final result = await translator.translate(widget.text, to: langCode);
    if (mounted) {
      setState(() {
        translatedText = result.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      translatedText.isNotEmpty ? translatedText : widget.text,
      style: widget.style,
    );
  }
}
