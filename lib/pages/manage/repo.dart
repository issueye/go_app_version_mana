import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_text_field.dart';
import 'package:go_app_version_mana/pages/manage/repo_dialog.dart';
import 'package:go_app_version_mana/pages/manage/repo_item.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../store/repo_list_store.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final TextEditingController _qryControl = TextEditingController();
  late RepoListStore repo = RepoListStore();

  Future<void> _getRepoList() async {
    await repo.getRepoList();
  }

  @override
  void initState() {
    super.initState();
    repo = Provider.of<RepoListStore>(context, listen: false);
    _getRepoList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CustomTextField(controller: _qryControl),
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '查询',
                onPressed: () async {
                  await repo.getRepoList();
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '添加',
                onPressed: () async {
                  await addRepo();
                  await repo.getRepoList();
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Consumer<RepoListStore>(
              builder: (context, value, child) {
                return _getRepo();
              },
            ),
          ),
        ],
      ),
    );
  }

  _getRepo() {
    return ListView.builder(
        itemCount: repo.listData == null ? 0 : repo.listData!.data!.length,
        itemBuilder: (context, index) {
          var data = repo.listData!.data!;
          if (data.isNotEmpty) {
            return RepoItem(
              data: data[index],
              isSelect: repo.selectIndex == index,
              onSelect: () {
                repo.selectIndex = index;
                repo.selectRepoId = data[index].id;
              },
            );
          } else {
            return const Center(
              child: Text('没有数据', style: AppTheme.defaultTextStyle),
            );
          }
        });
  }
}
