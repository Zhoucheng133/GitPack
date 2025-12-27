import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpack/getx/controller.dart';
import 'package:gitpack/main_window.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(500, 500),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    title: "GitPack"
  );
  windowManager.setResizable(false);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  Get.put(Controller());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final brightness = MediaQuery.of(context).platformBrightness; 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        fontFamily: 'Noto', 
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: brightness,
        ),
        textTheme: brightness==Brightness.dark ? ThemeData.dark().textTheme.apply(
          fontFamily: 'Noto',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ) : ThemeData.light().textTheme.apply(
          fontFamily: 'Noto',
        ),
      ),
      home: const Scaffold(
        body: MainWindow()
      ),
    );
  }
}
