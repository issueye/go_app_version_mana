import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_text_field.dart';
import 'package:go_app_version_mana/pages/manage/repo_dialog.dart';
import 'package:go_app_version_mana/pages/manage/repo_item.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:go_app_version_mana/utils/request/services.dart';

import '../../api/api.dart';
import '../../model/repo_list/datum.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final TextEditingController _qryControl = TextEditingController();
  List<Datum> tableData = List<Datum>.empty();
  int selectIndex = 0;

  Future<void> _getRepoList() async {
    if (DioSingleton.baseUrl == '') return;

    var data = await Api.getRepoList();
    tableData = data.data!;
  }

  @override
  void initState() {
    super.initState();

    var widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) async {
      await _getRepoList();
      setState(() {});
    });
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
                  onPressed: () async {
                    await _getRepoList();
                    setState(() {});
                  },
                  name: '查询'),
              const SizedBox(width: 10),
              CustomButton(
                  onPressed: () async {
                    await addRepo();
                  },
                  name: '添加'),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: _getRepo(tableData),
          ),
        ],
      ),
    );
  }

  _getRepo(List<Datum> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data.isNotEmpty) {
            return RepoItem(
              data: data[index],
              isSelect: selectIndex == index,
              onSelect: () {
                selectIndex = index;
                debugPrint('$selectIndex');
                setState(() {});
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
