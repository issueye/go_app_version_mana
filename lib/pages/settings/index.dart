import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_divider.dart';
import 'package:go_app_version_mana/components/custom_form_text_field.dart';
import 'package:go_app_version_mana/pages/settings/server.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:go_app_version_mana/utils/db/config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _serverHostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  Future<void> _initConfig() async {
    var serverHost = await ConfigDB.getStr('server_host');
    _serverHostController.text = serverHost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            ServerSettingsPage(),
          ],
        ),
      ),
    );
  }
}
