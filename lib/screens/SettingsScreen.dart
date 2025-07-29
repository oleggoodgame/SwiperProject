import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiper/models/characters.dart';
import 'package:swiper/provider/characters_provider.dart';
import 'package:swiper/provider/favorite_provider.dart';
import 'package:swiper/provider/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  bool isDarkModeActive(BuildContext context, ThemeMode mode) {
    if (mode == ThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;//  це доступ до інформації про поточне середовище (екран, розмір, орієнтація, яскравість тощо).
      return brightness == Brightness.dark;// що це робить?
    }
    return mode == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = isDarkModeActive(context, themeMode);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/characters/just_photo.webp",
                  width: 250,
                  height: 250,
                ),
                Text(
                  "Shrek tinder ❤️",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          SwitchListTile(
            title: const Text("Dark mode"),
            value: isDarkMode,
            onChanged: (isDark) {
              ref.read(themeProvider.notifier).toggle(isDark);
            },
          ),

          const Divider(),

          // Очистити улюблені
          ListTile(
            title: const Text('Clear Favorites'),
            leading: const Icon(Icons.favorite),
            onTap: () {
              ref.read(characterProvider.notifier).clearCharacters();
              ref.read(characterListProvider.notifier).reset(characters);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favorites cleared')),
              );
            },
          ),

          // Очистити видалені,
          // ListTile(
          //   title: const Text('Clear Deleted'),
          //   leading: const Icon(Icons.delete),
          //   onTap: () {
          //     ref.read(characterProvider.notifier).clearCharacters();
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('Deleted characters cleared')),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
