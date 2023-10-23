import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_app_version_mana/components/bar_button.dart';
import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_divider.dart';
import 'package:go_app_version_mana/components/custom_form_text_field.dart';
import 'package:go_app_version_mana/components/default_button.dart';
import 'package:go_app_version_mana/model/add_repo.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../model/repo_list/datum.dart';
import '../../store/repo_list_store.dart';

// ignore: must_be_immutable
class RepoInfoDialog extends StatefulWidget {
  RepoInfoDialog(
      {super.key,
      required this.tag,
      required this.title,
      this.data,
      this.operationType = 0});
  String tag;
  String title;
  Datum? data;
  int operationType; // 0 添加 1 编辑

  @override
  State<RepoInfoDialog> createState() => _RepoInfoDialogState();
}

class _RepoInfoDialogState extends State<RepoInfoDialog> {
  final TextEditingController _projectName = TextEditingController();
  final TextEditingController _serverName = TextEditingController();
  final TextEditingController _repoUrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      _projectName.text = widget.data!.projectName!;
      _serverName.text = widget.data!.serverName!;
      _repoUrl.text = widget.data!.repoUrl!;
    }

    var repoStore = Provider.of<RepoListStore>(context);

    return Container(
      height: 340,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                Text(widget.title, style: AppTheme.sizeTextStyle(16)),
                const Spacer(),
                BarButton(
                    icon: Resources.cancel,
                    onTap: () async {
                      await SmartDialog.dismiss(tag: widget.tag);
                    }),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const CustomDivider(),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _item('项目名称', _projectName, '请填写项目名称', true),
                _item('服务名称', _serverName, '请填写服务名称', true),
                _item('仓库地址', _repoUrl, '请填写仓库地址', true),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              PlainButton(
                name: '关闭',
                onPressed: () async {
                  await SmartDialog.dismiss(tag: widget.tag);
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '确定',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.operationType == 0) {
                      AddRepo repo = AddRepo();
                      repo.projectName = _projectName.text;
                      repo.serverName = _serverName.text;
                      repo.repoUrl = _repoUrl.text;

                      await repoStore.addRepo(repo);
                      await SmartDialog.dismiss(tag: widget.tag);
                    }
                  }
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  _item(
      String name, TextEditingController control, String hint, bool isHaveTo) {
    return Row(
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: CustomFormTextField(
            controller: control,
            title: name,
            titleWidth: 65,
            hintText: hint,
            isHaveTo: isHaveTo,
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}

Future<void> addRepo() async {
  await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_repo',
    builder: (context) {
      return RepoInfoDialog(tag: 'add_repo', title: '添加项目');
    },
  );
}

Future<void> editRepo(Datum data) async {
  await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_repo',
    builder: (context) {
      return RepoInfoDialog(tag: 'edit_repo', title: '修改项目信息', data: data);
    },
  );
}
