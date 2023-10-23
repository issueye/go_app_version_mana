import 'package:flutter/material.dart';
import 'package:go_app_version_mana/pages/manage/repo.dart';
import 'package:go_app_version_mana/pages/manage/repo_versioin.dart';
import 'package:go_app_version_mana/store/repo_list_store.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:provider/provider.dart';

class PageManage extends StatefulWidget {
  const PageManage({super.key});

  @override
  State<PageManage> createState() => _PageManageState();
}

class _PageManageState extends State<PageManage> {
  @override
  Widget build(BuildContext context) {
    var repo = Provider.of<RepoListStore>(context);
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
        repo.selectRepoId == null
            ? const Center(
                child: Text(
                  '没有数据',
                  style: AppTheme.defaultTextStyle,
                ),
              )
            : Expanded(
                child: RepoVersion(repoId: repo.selectRepoId ??= ''),
              ),
      ],
    );
  }
}
