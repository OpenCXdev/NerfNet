import 'package:cognitivestudio/screen/upload/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

// /// for management user
final mainRouteMap = RouteMap(
  onUnknownRoute: (route) => const Redirect('/'),
  routes: {
    '/': (route) => const MaterialPage<dynamic>(
          child: UploadScreen(),
        ),
    '/home': (route) => const MaterialPage<dynamic>(
          child: UploadScreen(),
        ),
  },
);

final routeMasterDelegateProvider = StateProvider<RoutemasterDelegate>((ref) {
  return RoutemasterDelegate(
    routesBuilder: (context) => mainRouteMap,
  );
});
