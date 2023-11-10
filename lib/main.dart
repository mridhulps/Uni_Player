import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:uniplayer/core/controllbinding/binding.dart';


import 'view/screens/splash_screen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
   
    androidShowNotificationBadge: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: initialcontroll(),
      home: const SplashScreen(),
    );
  }
}
