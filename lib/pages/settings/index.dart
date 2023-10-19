import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_form_text_field.dart';
import 'package:go_app_version_mana/pages/settings/route.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: SettingsRoutes.router,
    );
  }
}
