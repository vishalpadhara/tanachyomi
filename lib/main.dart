import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/splash_screen.dart';
import 'package:tanachyomi/utils/theme.dart';


// class MyAudioHandler extends BaseAudioHandler
//     with QueueHandler, // mix in default queue callback implementations
//         SeekHandler { // mix in default seek callback implementations
//
//   // The most common callbacks:
//   Future<void> play() async {
//     // All 'play' requests from all origins route to here. Implement this
//     // callback to start playing audio appropriate to your app. e.g. music.
//   }
//   Future<void> pause() async {}
//   Future<void> stop() async {}
//   Future<void> seek(Duration position) async {}
//   Future<void> skipToQueueItem(int i) async {}
// }
//
// late AudioHandler _audioHandler;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CountryCodes.init();
  await FlutterDownloader.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  // await FlutterDownloader.initialize(
  //     debug: true, // optional: set to false to disable printing logs to console (default: true)
  //     ignoreSsl: true // option: set to false to disable working with http links (default: false)
  // );

  // _audioHandler = await AudioService.init(
  //   builder: () => MyAudioHandler(),
  //   config: AudioServiceConfig(
  //     androidNotificationChannelId: 'com.app.nachyomi.channel.audio',
  //     androidNotificationChannelName: 'Music playback',
  //   ),
  // );
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: SplashScreen(),
        );
      },
    );
  }
}
