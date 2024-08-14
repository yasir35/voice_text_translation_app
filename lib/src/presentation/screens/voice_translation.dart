import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:voice_text_translation_app/src/presentation/utils/constants/constants.dart';
import 'package:voice_text_translation_app/src/presentation/utils/extention/extention.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class TranslationState extends ChangeNotifier {
  bool _isRecording = false;
  bool get isRecording => _isRecording;

  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedText = '';
  String get recognizedText => _recognizedText;

  final GoogleTranslator _translator = GoogleTranslator();
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

  void toggleRecording() async {
    if (!_isRecording) {
      bool available = await _speech.initialize();
      if (available) {
        _isRecording = true;
        resetTextFields();
        notifyListeners();
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              _speech.stop();
              _isRecording = false;
              _recognizedText = result.recognizedWords;
              _translateAndDisplay(_recognizedText);
              notifyListeners();
            }
          },
        );
      } else {
        print('Speech Recognition not available');
      }
    } else {
      _speech.stop();
      _isRecording = false;
      notifyListeners();
    }
  }

  Future<void> _translateAndDisplay(String text) async {
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
      if (!_isRecording && !_isRecording && _recognizedText.isNotEmpty) {
        _translateAndDisplay(_recognizedText);
      }
    }
    Navigator.of(context).pop();
    notifyListeners();
  }

  void resetTextFields() {
    _recognizedText = '';
    _translatedText = '';
    notifyListeners();
  }
}

class VoiceTranslation extends StatelessWidget {
  const VoiceTranslation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TranslationState(),
      child: _VoiceTranslation(),
    );
  }
}

class _VoiceTranslation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translationState = Provider.of<TranslationState>(context);

    return Scaffold(
      backgroundColor: kLightDeepColor,
      appBar: AppBar(
        backgroundColor: kDeepPurpleColor,
        title: Text('Voice Translation',
            style: MyTextStyles.kIntroTextStyle(context)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routename.textTranslation);
            },
            child: Text(
              'Text Translation?',
              style: TextStyle(
                  color: kBackgroundColor,
                  fontSize: context.responsiveTextSize * 0.5),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: 10.0.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectLanguage(context, true),
                  child: Text(
                      'From: ${translationState.languageMap[translationState.fromLanguageCode]}'),
                ),
                ElevatedButton(
                  onPressed: () => _selectLanguage(context, false),
                  child: Text(
                      'To: ${translationState.languageMap[translationState.toLanguageCode]}'),
                ),
              ],
            ),
            10.ph,
            Image.asset('assets/images/StT.png',
                width: context.mediaQueryWidth * 0.85,
                height: context.mediaQueryHeight * 0.1),
            5.ph,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: 16.0.padding,
                    alignment: Alignment.center,
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: translationState.recognizedText),
                      decoration: InputDecoration(
                        hintText: translationState.isRecording
                            ? 'Listening...'
                            : 'Tap the microphone to start listening...',
                        border: const OutlineInputBorder(),
                        labelText: 'Speech Text',
                      ),
                      style: const TextStyle(fontSize: 18.0),
                      maxLines: null,
                    ),
                  ),
                  20.ph,
                  Container(
                    padding: 16.0.padding,
                    alignment: Alignment.center,
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: translationState.translatedText),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Translated Text',
                      ),
                      style: const TextStyle(fontSize: 18.0),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => translationState.toggleRecording(),
        tooltip: 'Listen',
        child: Icon(
          translationState.isRecording ? Icons.stop : Icons.mic,
          color: translationState.isRecording ? Colors.red : kDeepPurpleColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _selectLanguage(BuildContext context, bool isFrom) async {
    final translationState =
        Provider.of<TranslationState>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isFrom ? 'Select From Language' : 'Select To Language'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: translationState.languageMap.length,
              itemBuilder: (BuildContext context, int index) {
                final languageCode =
                    translationState.languageMap.keys.elementAt(index);
                final languageName = translationState.languageMap[languageCode];
                return ListTile(
                  title: Text(languageName!),
                  onTap: () {
                    translationState.selectLanguage(
                        context, isFrom, languageCode);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
