import 'package:flutter/material.dart';
import 'package:swiper/provider/favorite_provider.dart';
import 'package:swiper/widgets/DumbInformationCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chracters = ref.watch(characterProvider);
     return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: ListView.builder(
        itemCount: chracters.length,
        itemBuilder: (context, index) {
          final character = chracters[index];
          return DumbInformationCard(character: character);
        },
      ),
    );
  }
}
