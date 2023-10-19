import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_form_text_field.dart';

class ServerSettingsPage extends StatefulWidget {
  const ServerSettingsPage({super.key});

  @override
  State<ServerSettingsPage> createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  final TextEditingController _serverHostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomFormTextField(
            controller: _serverHostController,
            title: '服务地址',
            hintText: '请输入服务地址',
          ),
          CustomButton(onPressed: () {}, name: '确定'),
        ],
      ),
    );
  }
}
