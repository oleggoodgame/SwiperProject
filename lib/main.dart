import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiper/provider/theme_provider.dart';
import 'package:swiper/screens/MainScreen.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(color: Colors.black, fontSize: 22),
              titleMedium: const TextStyle(color: Colors.black, fontSize: 18),
              titleSmall: const TextStyle(color: Colors.black, fontSize: 15),
            ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: const TextStyle(color: Colors.white, fontSize: 22),
              titleMedium: const TextStyle(color: Colors.white, fontSize: 18),
              titleSmall: const TextStyle(color: Colors.white, fontSize: 15),
            ),
      ),
      home: const MainScreen(),
    );
  }
}

class SwipeUpWidget extends StatefulWidget {
  const SwipeUpWidget({super.key});

  @override
  State<SwipeUpWidget> createState() => _SwipeUpWidgetState();
}

class _SwipeUpWidgetState extends State<SwipeUpWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1.5), // нижче екрана
      end: Offset(0, 0),     // центр
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward(); // запуск анімації одразу
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Hello!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
