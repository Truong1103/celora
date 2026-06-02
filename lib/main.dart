import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/main_shell.dart';
import 'theme/celora_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const CeloraApp());
}

class CeloraApp extends StatelessWidget {
  const CeloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'Celora',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: CeloraColors.paler,
          colorScheme: ColorScheme.fromSeed(
            seedColor: CeloraColors.mid,
            primary: CeloraColors.mid,
            surface: CeloraColors.paler,
          ),
          textTheme: GoogleFonts.notoSansTextTheme(),
        ),
        home: const MainShell(),
      ),
    );
  }
}
