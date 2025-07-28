import 'package:flutter/material.dart';
import 'package:swiper/data/data.dart';
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
  int _index = 0;
  Offset _dragOffset = Offset
      .zero; //Offset — це клас, який зберігає зсув (відстань) по горизонталі (X) та вертикалі (Y).
  //Тобто: Offset(50, 20) означає, що елемент буде зміщено на 50 пікселів вправо і на 20 пікселів вниз.
  late List<Character> listCharacters;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    final characters = ref.read(characterListProvider);
    print("CharacterProvider has ${characters.length} characters");
    listCharacters = [...characters];
    listCharacters.shuffle();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
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
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double opacity = (_dragOffset.dx.abs() / screenWidth).clamp(
      0.0,
      1.0,
    ); //  Це означає: чим далі ти тягнеш картку, тим менш прозорий стає напис LIKE / DISLIKE.
    bool isRight = _dragOffset.dx > 0;
    if (_index >= listCharacters.length) {
      return const Center(child: Text("There is nothing"));
    }

    return GestureDetector(
      onPanUpdate: (details) {
        // onPanUpdate викликається кожен раз, коли палець рухається по екрану.
        setState(() {
          _dragOffset += details.delta;
        });
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

          setState(() {
            _index++;
            _dragOffset = Offset.zero;
            playAnimation(); // ✅ Ось це головне
          });
        } else {
          setState(() {
            _dragOffset = Offset.zero;
          });
        }
      },

      child: Transform.translate(
        // Це переміщує весь вміст на заданий Offset
        offset: _dragOffset,
        child: Stack(
          children: [
            // Карта персонажа
            SlideTransition(
              position: _slideAnimation,
              child: Choosecard(character: listCharacters[_index]),
            ),

            // Overlay: LIKE / DISLIKE
            if (_dragOffset.dx != 0)
              Positioned(
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
