import 'package:flutter/material.dart';
import 'package:swiper/data/data.dart';

class DumbInformationCard extends StatelessWidget {
  const DumbInformationCard({
    super.key,
    required this.character,
    // required this.onTap,
  });

  final Character character;
  // final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        // onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  character.photoPath,
                  width: 80,
                  height: 100, 
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NAME: ${character.name}",
                      style:Theme.of(context).textTheme.titleMedium
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "AGE: ${character.name}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'RESIDENCE: ${character.residence}',
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'INFORMATION: ${character.information}',
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
