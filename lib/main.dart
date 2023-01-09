import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Common/Utils/router.dart';
import 'package:whisper/Common/Widgets/error_screen.dart';
import 'package:whisper/Features/Auth/controllers/auth_controller.dart';
import 'package:whisper/Features/Landing/landing_screen.dart';
import 'package:whisper/Features/Views/screens/mobile_layout_screen.dart';
import 'package:whisper/Features/Views/screens/web_layout_screen.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whisper',
        theme: ThemeData.dark().copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(color: AppColors.appBarColor),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.transparent,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
            data: ((user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const ResponsiveLayout(
                mobileScreenLayout: MobileLayoutScreen(),
                webScreenLayout: WebLayoutScreen(),
              );
            }),
            error: ((error, stackTrace) {
              return ErrorScreen(error: error.toString());
            }),
            loading: (() => const Loader())));
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
