import 'package:auto_route/annotations.dart';
import 'package:notes/presentation/home/home_page.dart';
import 'package:notes/presentation/sign_in/sign_in_page.dart';
import 'package:notes/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}
