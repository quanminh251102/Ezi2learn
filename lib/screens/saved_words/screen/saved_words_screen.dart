import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:rive_animation/screens/saved_words/model/saved_words_screen_model.dart';
import 'package:rive_animation/screens/saved_words/service/saved_words_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SavedWordsScreen extends StatefulWidget {
  const SavedWordsScreen({super.key});

  @override
  State<SavedWordsScreen> createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {
  // Begin : Text To Speech
  bool isSpeaking = false;
  final FlutterTts flutterTts = FlutterTts();
  speak(String text, double speech) async {
    setState(() {
      isSpeaking = true;
    });
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(speech);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      isSpeaking = false;
    });
  }
  // End : Text To Speech

  bool isLoading = false;
  SavedWordsModel? savedWordsModel;
  List<String> words = [];
  List<String> meanings = [];
  List<String> _searchResult_words = [];
  List<String> _searchResult_meanings = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      isLoading = true;
    });

    SavedWordsService.Read().then((value) {
      setState(() {
        savedWordsModel = value[0];
        print(savedWordsModel?.toJson());
        words = value[0].words;
        meanings = value[0].meanings;
        _searchResult_meanings = value[0].meanings;
        _searchResult_words = value[0].words;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search words in list"),
                  onChanged: (value) {
                    List<String> newWords = [];
                    List<String> newMeanings = [];
                    for (int i = 0; i < words.length; i++) {
                      if (words[i].contains(value.trim())) {
                        newWords.add(words[i]);
                        newMeanings.add(meanings[i]);
                      }
                    }
                    setState(() {
                      _searchResult_words = newWords;
                      _searchResult_meanings = newMeanings;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomCard(
                  height: 440,
                  borderRadius: 12,
                  color: Colors.white,
                  childPadding: 4,
                  child: (_searchResult_words.isEmpty)
                      ? const Center(
                          child: Text('List is empty'),
                        )
                      : ListView(children: [
                          for (int i = 0;
                              i < _searchResult_words.length;
                              i++) ...{
                            ListTile(
                              leading: CustomCard(
                                borderRadius: 80,
                                child: const Icon(
                                  Icons.volume_up,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  speak(words[i], 0.8);
                                },
                              ),
                              title: Text("Từ : ${words[i]}"),
                              subtitle: Text("Nghĩa : ${meanings[i]}"),
                            ),
                            Container(
                              color: Colors.grey.shade300,
                              height: 1,
                            ),
                          }
                        ]),
                ),
              ],
            ),
          );
  }
}
