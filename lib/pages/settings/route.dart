import 'package:go_app_version_mana/pages/settings/server.dart';
import 'package:go_router/go_router.dart';

class SettingsRoutes {
  static const String serverPath = '/'; // 根路由
  static const String serverNamed = 'server';

  static GoRouter router = GoRouter(initialLocation: serverPath, routes: [
    GoRoute(
      name: serverNamed,
      path: serverPath,
      builder: (context, state) {
        return const ServerSettingsPage();
      },
    ),
  ]);
}
