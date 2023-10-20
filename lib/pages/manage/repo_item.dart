import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_app_version_mana/model/repo_list/datum.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';

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

  Color _getBorderColor() {
    if (widget.isSelect) {
      return Colors.blue;
    }

    if (isHover) {
      return AppTheme.mainColor;
    } else {
      return AppTheme.dividerColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        hoverColor: Color.fromARGB(166, 240, 239, 242),
        borderRadius: BorderRadius.circular(4),
        onTap: widget.onSelect,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: Container(
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: _getBorderColor(),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              _cardTileHeight,
              Row(
                children: [
                  _cardTileSpace,
                  Text(
                    widget.data.projectName!,
                    style: AppTheme.defaultTextStyle,
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      height: 20,
                      width: 20,
                      child: Resources.edit,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      height: 20,
                      width: 20,
                      child: Resources.delete,
                    ),
                    onTap: () {},
                  ),
                  _cardTileSpace,
                ],
              ),
              _cardTileHeight,
              Container(
                height: 1,
                color: AppTheme.dividerColor,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  _cardTileSpace,
                  Text('创建时间: ${widget.data.createAt!}', style: AppTheme.defaultTextStyle),
                ],
              ),
              _cardTileHeight,
            ],
          ),
        ),
      ),
    );
  }
}
