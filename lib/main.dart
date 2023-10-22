import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_app_version_mana/init/index.dart';
import 'package:go_app_version_mana/router/index.dart';
import 'package:go_app_version_mana/store/demo.dart';
import 'package:flutter/material.dart';
import 'package:go_app_version_mana/store/repo_list_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 窗体初始化
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DemoStore>(create: (_) => DemoStore()),
        ChangeNotifierProvider<RepoListStore>(create: (_) => RepoListStore()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRoutes.router,
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
