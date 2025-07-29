import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiper/data/data.dart';
import 'package:swiper/models/characters.dart';

final charactersProvider = Provider((ref) {
  return characters;
});

class CharacterListNotifier extends StateNotifier<List<Character>> {
  CharacterListNotifier(List<Character> initialList) : super(initialList);

  void removeCharacter(Character character) {
    state = [...state]..remove(character);
  }

  void reset(List<Character> newList) {
    state = [...newList];
  }
}

final characterListProvider =
    StateNotifierProvider<CharacterListNotifier, List<Character>>(
  (ref) => CharacterListNotifier(characters),
);

