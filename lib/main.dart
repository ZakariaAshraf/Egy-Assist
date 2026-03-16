import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/widgets/connectivity_overlay.dart';
import 'package:study_path/features/favorite/cubit/favourite_cubit.dart';
import 'package:study_path/features/notification/data/services/notification_services.dart';
import 'package:study_path/features/settings/presentation/Cubit/user_cubit.dart';
import 'core/locale/providers/locale_provider.dart';
import 'core/themes/providers/theme_provider.dart';
import 'core/themes/text_theme.dart';
import 'features/authenticate/data/repositories/auth_repository_impl.dart';
import 'features/authenticate/domain/use_cases/auth_usecases.dart';
import 'features/authenticate/presentation/manager/auth_cubit.dart';
import 'features/authenticate/presentation/pages/sign_in.dart';
import 'features/authenticate/presentation/pages/sign_up.dart';
import 'features/home/presentation/cubit/programs_cubit.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'l10n/app_localizations.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
 NotificationServices.init();
 await CacheHelper.init();
  bool? onBoarding = CacheHelper.getBool(key: CacheKeys.isOnBoardingSeen);
  String? uId = CacheHelper.getString(key: CacheKeys.uId);
  bool? isGuestMode = CacheHelper.getBool(key: CacheKeys.isGuestMode);
  Widget startWidget;
  if (onBoarding == true) {
    if (uId != null) {
      startWidget = const MainScreen();
    } else if (isGuestMode == true) {
      startWidget = const MainScreen();
    } else {
      startWidget = const SignIn();
    }
  } else {
    startWidget = OnboardingScreen();
  }
  runApp(ProviderScope(child: MyApp(startWidget:startWidget)));
}

class MyApp extends ConsumerWidget {
  final Widget startWidget;
    const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,ref) {
    final theme =ref.watch(themeProvider);
    final locale =ref.watch(localeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            signInUseCase: SignInUseCase(FirebaseAuthRepository()),
            registerUseCase: RegisterUseCase(FirebaseAuthRepository()),
          ),

        ),
        BlocProvider(
          create: (context) => ProgramsCubit(),
        ),
        BlocProvider(
          create: (context) {
            final cubit = UserCubit();
            final uId = CacheHelper.getString(key: CacheKeys.uId);
            if (uId != null) {
              cubit.listenToFirebaseStream(uId);
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = FavouriteCubit();
            final uId = CacheHelper.getString(key: CacheKeys.uId);
            if (uId != null) {
              cubit.listenToFavorites();
            }
            return cubit;
          },
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          final currentTheme = Theme.of(context);
          final isDark = currentTheme.brightness == Brightness.dark;
          final textDirection = locale?.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr;
          return Directionality(
            textDirection: textDirection,
            child: Theme(
              data: currentTheme.copyWith(
                textTheme: isDark
                    ? AppTextTheme.darkTextTheme(context)
                    : AppTextTheme.lightTextTheme(context),
              ),
              child: ConnectivityOverlay(child: child!),
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        themeMode: theme,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        title: 'Egy Assist',
        home:startWidget,
        // home:OnboardingScreen(),
        routes: {
          // "/": (context) => OnboardingScreen(),
          "/signIn": (context) => const SignIn(),
          "/signUp": (context) => const SignUp(),
          // "/wrapper": (context) => const AuthWrapper(),
          "/home": (context) => HomeScreen(),
          "/main_screen": (context) => const MainScreen(),
        },
      ),
    );
  }
}
// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const OnboardingScreen();
//         }
//         if (snapshot.hasData) {
//           return MainScreen();
//         } else {
//           return SignIn();
//         }
//       },
//     );
//   }
// }