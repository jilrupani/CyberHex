import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'utils/game_storage.dart';

void main() async {
  // Ensure widget bindings are initialised before async assets/prefs call
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set orientation lock to portrait for clean screen aspect designs
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialise local preferences cache
  await GameStorage.init();

  runApp(const CyberHexApp());
}

class CyberHexApp extends StatelessWidget {
  const CyberHexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberHex: Node Hacker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070913),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFCC),
          secondary: Color(0xFFFF007F),
          surface: Color(0xFF101426),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
