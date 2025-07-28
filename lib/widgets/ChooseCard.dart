import 'package:flutter/material.dart';
import 'package:swiper/data/data.dart';
import 'package:transparent_image/transparent_image.dart';

class Choosecard extends StatelessWidget {
  const Choosecard({
    super.key,
    required this.character,
    // required this.onSelect,
  });

  final Character character;
  // final void Function(Character character)onSelect; // і напевно це треба буде забрати

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 2,
      child: InkWell(
        // тут напевно на GestureDetector поміняти але можливо в ChooseScreen
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(character.photoPath),
                fit: BoxFit.fitHeight,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),

                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      character.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    Text(
                      character.age.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
