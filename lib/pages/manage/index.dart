import 'package:flutter/material.dart';
import 'package:go_app_version_mana/pages/manage/repo.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';

class PageManage extends StatefulWidget {
  const PageManage({super.key});

  @override
  State<PageManage> createState() => _PageManageState();
}

class _PageManageState extends State<PageManage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 300,
          child: RepoPage(),
        ),
        Container(
          width: 1,
          color: AppTheme.dividerColor,
        ),
        const Expanded(
          child: Center(
            child: Text('项目'),
          ),
        ),
      ],
    );
  }
}
