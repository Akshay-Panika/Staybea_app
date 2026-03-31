import 'package:translator/translator.dart';

class TranslationService {
  static final TranslationService _instance =
  TranslationService._internal();

  factory TranslationService() => _instance;

  TranslationService._internal();

  final GoogleTranslator _translator = GoogleTranslator();

  String currentLang = "en";

  Future<String> translate(String text) async {
    if (currentLang == "en") return text;

    try {
      final result =
      await _translator.translate(text, to: currentLang);
      return result.text;
    } catch (e) {
      return text;
    }
  }
}