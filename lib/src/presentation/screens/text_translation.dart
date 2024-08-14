import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightDeepColor,
      appBar: AppBar(
        backgroundColor: kDeepPurpleColor,
        title:
            Text('Text Translation', style: MyTextStyles.kIntroTextStyle(context)),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TextTranslationState(),
        child: const TextTranslationPage(),
      ),
    );
  }
}

class TextTranslationState extends ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  String _inputText = '';
  String get inputText => _inputText;

  String _translatedText = '';
  String get translatedText => _translatedText;

  String _fromLanguageCode = 'en';
  String get fromLanguageCode => _fromLanguageCode;

  String _toLanguageCode = 'pa';
  String get toLanguageCode => _toLanguageCode;

  Map<String, String> languageMap = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh-cn': 'Chinese',
    'ar': 'Arabic',
    'ur': 'Urdu',
    "pa": "Punjabi",
    "hi": "Hindi",
    "ru": "Russian",
    "tr": "Turkish",
    "bn": "Bengali",
    "pt": "Portuguese",
    "nl": "Dutch",
    "id": "Indonesian",
     "fa": "Persian",
    "el": "Greek",
  };

  void translateText(String text) async {
    try {
      Translation translation = await _translator.translate(text,
          from: _fromLanguageCode, to: _toLanguageCode);
      _translatedText = translation.toString();
      notifyListeners();
    } catch (e) {
      print('Translation Error: $e');
    }
  }

  void selectLanguage(BuildContext context, bool isFrom, String languageCode) {
    if (isFrom) {
      _fromLanguageCode = languageCode;
    } else {
      _toLanguageCode = languageCode;
    }
    if (_inputText.isNotEmpty) {
      translateText(_inputText);
    }
    notifyListeners();
  }

  void updateInputText(String text) {
    _inputText = text;
    notifyListeners();
  }
}

class TextTranslationPage extends StatelessWidget {
  const TextTranslationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translationState = Provider.of<TextTranslationState>(context);

    return Padding(
      padding: 16.0.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: (text) => translationState.updateInputText(text),
            decoration: const InputDecoration(labelText: 'Enter Text'),
          ),
          16.ph,
          DropdownButtonFormField<String>(
            value: translationState.fromLanguageCode,
            onChanged: (value) {
              translationState.selectLanguage(context, true, value!);
            },
            items: translationState.languageMap.entries
                .map((entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ))
                .toList(),
            decoration: const InputDecoration(labelText: 'From Language'),
          ),
          16.ph,
          DropdownButtonFormField<String>(
            value: translationState.toLanguageCode,
            onChanged: (value) {
              translationState.selectLanguage(context, false, value!);
            },
            items: translationState.languageMap.entries
                .map((entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ))
                .toList(),
            decoration: const InputDecoration(labelText: 'To Language'),
          ),
          16.ph,
          ElevatedButton(
            onPressed: () {
              translationState.translateText(translationState.inputText);
            },
            child: const Text('Translate'),
          ),
          16.ph,
          TextField(
            readOnly: true,
            controller:
                TextEditingController(text: translationState.translatedText),
            decoration: const InputDecoration(labelText: 'Translated Text'),
          ),
        ],
      ),
    );
  }
}
