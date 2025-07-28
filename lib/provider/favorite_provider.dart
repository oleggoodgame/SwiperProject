import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiper/data/data.dart';

class CharacterNotifier extends StateNotifier<List<Character>> {
  CharacterNotifier()
    : super([]);
  void addCharacter(Character character){
    state = [...state, character];

  }


  void clearCharacters() {
    state = [];
  }
}

final characterProvider = StateNotifierProvider<CharacterNotifier, List<Character>>((ref) {
  return CharacterNotifier();
});
