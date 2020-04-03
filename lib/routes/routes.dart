/// Defines routes used in the app
library router_routes;

import 'package:openinventory_staff_app/views/pages/home.dart';
import 'package:openinventory_staff_app/views/pages/login.dart';
import 'package:openinventory_staff_app/views/pages/profile.dart';
import 'package:openinventory_staff_app/views/pages/splash.dart';

import 'router.dart';

/// List of routes in the app
void defineAllRoutes() {
  AppRouter router = AppRouter();
  router.defineRoute(path: "/", handler: (_, __) => SplashScreen());
  router.defineRoute(path: "/home", handler: (_, __) => HomePage());
  router.defineRoute(path: "/login", handler: (_, __) => LoginPage());
  router.defineRoute(path: "/profile", handler: (_, __) => ProfilePage());
}
