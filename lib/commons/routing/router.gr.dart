// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:portal/data/models/user_model.dart' as _i7;
import 'package:portal/presentations/pages/all_documents_screen.dart' as _i2;
import 'package:portal/presentations/pages/calendar_screen.dart' as _i4;
import 'package:portal/presentations/pages/home_screen.dart' as _i3;
import 'package:portal/presentations/pages/main_screen.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainScreen(),
      );
    },
    AllDocumentsRoute.name: (routeData) {
      final args = routeData.argsAs<AllDocumentsRouteArgs>(
          orElse: () => const AllDocumentsRouteArgs());
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.AllDocumentsScreen(
          key: args.key,
          userModel: args.userModel,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.CalendarScreen(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i5.RouteConfig(
              CalendarRoute.name,
              path: 'calendar',
              parent: MainRoute.name,
            ),
            _i5.RouteConfig(
              '*#redirect',
              path: '*',
              parent: MainRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i5.RouteConfig(
          AllDocumentsRoute.name,
          path: '/allDocument/:listDocument',
        ),
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.AllDocumentsScreen]
class AllDocumentsRoute extends _i5.PageRouteInfo<AllDocumentsRouteArgs> {
  AllDocumentsRoute({
    _i6.Key? key,
    _i7.UserModel? userModel,
  }) : super(
          AllDocumentsRoute.name,
          path: '/allDocument/:listDocument',
          args: AllDocumentsRouteArgs(
            key: key,
            userModel: userModel,
          ),
        );

  static const String name = 'AllDocumentsRoute';
}

class AllDocumentsRouteArgs {
  const AllDocumentsRouteArgs({
    this.key,
    this.userModel,
  });

  final _i6.Key? key;

  final _i7.UserModel? userModel;

  @override
  String toString() {
    return 'AllDocumentsRouteArgs{key: $key, userModel: $userModel}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.CalendarScreen]
class CalendarRoute extends _i5.PageRouteInfo<void> {
  const CalendarRoute()
      : super(
          CalendarRoute.name,
          path: 'calendar',
        );

  static const String name = 'CalendarRoute';
}
