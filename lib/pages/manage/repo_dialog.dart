import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_app_version_mana/components/custom_button.dart';

class RepoInfoDialog extends StatefulWidget {
  const RepoInfoDialog({super.key});

  @override
  State<RepoInfoDialog> createState() => _RepoInfoDialogState();
}

class _RepoInfoDialogState extends State<RepoInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text('123'),
          CustomButton(
              onPressed: () async {
                await SmartDialog.dismiss(tag: 'add_repo');
              },
              name: '关闭')
        ],
      ),
    );
  }
}

Future<void> addRepo() async {
  await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_repo',
    builder: (context) {
      return RepoInfoDialog();
    },
  );
}
