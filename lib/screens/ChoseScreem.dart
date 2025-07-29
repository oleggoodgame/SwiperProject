import 'package:flutter/material.dart';
import 'package:swiper/data/data.dart';
import 'package:swiper/provider/animation_provider.dart';
import 'package:swiper/provider/characters_provider.dart';
import 'package:swiper/provider/favorite_provider.dart';
import 'package:swiper/widgets/ChooseCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseScreen extends ConsumerStatefulWidget {
  const ChooseScreen({super.key});

  @override
  ConsumerState<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends ConsumerState<ChooseScreen>
    with TickerProviderStateMixin {
  //Offset — це клас, який зберігає зсув (відстань) по горизонталі (X) та вертикалі (Y).
  //Тобто: Offset(50, 20) означає, що елемент буде зміщено на 50 пікселів вправо і на 20 пікселів вниз.
  late List<Character> listCharacters;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
int _index = 0;
  @override
  void initState() {
    super.initState();
    final characters = ref.read(characterListProvider);
    print("CharacterProvider has ${characters.length} characters");
    listCharacters = [...characters];
    listCharacters.shuffle();
    _controller = AnimationController(
      vsync:
          this, // означає, що цей клас знає, коли кадри оновлюються (завдяки TickerProviderStateMixin)
      duration: Duration(milliseconds: 800), // скільки триває анімація
    );

    playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playAnimation() {
    _controller.reset();
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0))
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        ); // налаштування до анімації
    _controller.forward(); //Це запускає анімацію.
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chooseScreenProvider);
    final notifier = ref.read(chooseScreenProvider.notifier);

    final _dragOffset = state.dragOffset;
    final screenWidth = MediaQuery.of(context).size.width;
    double opacity = (_dragOffset.dx.abs() / screenWidth).clamp(
      0.0,
      1.0,
    ); //  Це означає: чим далі ти тягнеш картку, тим менш прозорий стає напис LIKE / DISLIKE.
    bool isRight = _dragOffset.dx > 0;
    int fifi = _index+1;
    if (fifi > listCharacters.length) {
      return const Center(child: Text("There is nothing"));
    }
    print("----");
    print(listCharacters.length);
    print("----");
    print(_index);
    print("----");
    print(ref.read(chooseScreenProvider).index);
    print("----");
    return GestureDetector(
      onPanUpdate: (details) {
        // Це об'єкт типу DragUpdateDetails, який:

        // містить інформацію про рух пальця на екрані,

        // має details.delta, що каже, наскільки палець зсунувся від попередньої позиції.
        // onPanUpdate викликається кожен раз, коли палець рухається по екрану.
        notifier.updateOffset(
          ref.read(chooseScreenProvider).dragOffset + details.delta,
        );
      },
      onPanEnd: (details) {
        if (_dragOffset.dx.abs() > 150) {
          if (isRight) {
            ref
                .watch(characterProvider.notifier)
                .addCharacter(listCharacters[_index]);
            ref
                .read(characterListProvider.notifier)
                .removeCharacter(listCharacters[_index]);
          }
          
          notifier.nextIndex();
          playAnimation();
        } else {
          notifier.resetOffset();
        }
        _index++;
      },

      child: Transform.translate(
        // Це переміщує весь вміст на заданий Offset
        offset: _dragOffset,
        child: Stack(
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: Choosecard(character: listCharacters[_index]),
            ),

            // Overlay: LIKE / DISLIKE
            if (_dragOffset.dx != 0)
              Positioned(
                // Цей віджет дозволяє розмістити елемент точно вказаними координатами всередині Stack
                top: 40,
                left: isRight ? 20 : null,
                right: isRight ? null : 20,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isRight
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      // поясни це детальніше
                      children: [
                        Icon(
                          isRight ? Icons.thumb_up : Icons.thumb_down,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isRight ? 'LIKE' : 'DISLIKE',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
