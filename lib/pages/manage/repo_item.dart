import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/bar_button.dart';
import 'package:go_app_version_mana/model/repo_list/datum.dart';
import 'package:go_app_version_mana/pages/manage/repo_dialog.dart';
import 'package:go_app_version_mana/store/repo_list_store.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../components/message_dialog.dart';

class RepoItem extends StatefulWidget {
  const RepoItem(
      {super.key, required this.data, this.isSelect = false, this.onSelect});
  final Datum data;
  final bool isSelect;
  final Function()? onSelect;

  @override
  State<RepoItem> createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoItem> {
  bool isHover = false;
  final SizedBox _cardTileHeight = const SizedBox(height: 10);
  final SizedBox _cardTileSpace = const SizedBox(width: 10);

  Color _getBorderColor(int type) {
    switch (type) {
      case 0:
        return Colors.blue;
      case 1:
        return AppTheme.mainColor;
      default:
        return AppTheme.dividerColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var repoStore = Provider.of<RepoListStore>(context);
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        hoverColor: const Color.fromARGB(166, 240, 239, 242),
        borderRadius: BorderRadius.circular(4),
        onTap: widget.onSelect,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: Consumer<RepoListStore>(
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: _getBorderColor(widget.isSelect
                        ? 0
                        : isHover
                            ? 1
                            : 2),
                    width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  _cardTileHeight,
                  _barButtons(repoStore),
                  _cardTileHeight,
                  Container(
                    height: 1,
                    color: AppTheme.dividerColor,
                  ),
                  const SizedBox(height: 10),
                  _itemText(
                      '仓库地址: ${widget.data.repoUrl!}', widget.data.repoUrl!),
                  const SizedBox(height: 5),
                  _itemText(
                      '创建时间: ${widget.data.createAt!}', ''),
                  _cardTileHeight,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _itemText(String txt, String message) {
    return Row(
      children: [
        _cardTileSpace,
        Expanded(
          child: Tooltip(
            preferBelow: false,
            verticalOffset: 8,
            message: message,
            child: Text(
              txt,
              maxLines: 1,
              style: AppTheme.sizeTextStyle(11),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  _barButtons(RepoListStore repo) {
    return Row(
      children: [
        _cardTileSpace,
        Text(
          widget.data.projectName!,
          style: AppTheme.sizeTextStyle(16),
        ),
        const Spacer(),
        BarButton(
            icon: Resources.edit,
            tipMessage: '编辑',
            onTap: () async {
              await editRepo(widget.data);
            }),
        const SizedBox(width: 10),
        BarButton(
            icon: Resources.delete,
            tipMessage: '删除',
            onTap: () async {
              await showMessageBox('删除', '''
是否删除 ${widget.data.projectName} ?
''').then((value) async {
                debugPrint('then -> $value');
                if (value) {
                  await repo.removeDataById(widget.data.id!);
                  await repo.getRepoList();
                }
              });
            }),
        _cardTileSpace,
      ],
    );
  }
}
