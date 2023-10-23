import 'package:flutter/material.dart';
import 'package:go_app_version_mana/components/custom_select.dart';
import 'package:go_app_version_mana/pages/manage/version_item.dart';
import 'package:provider/provider.dart';

import '../../store/version_list_store.dart';

class RepoVersion extends StatefulWidget {
  const RepoVersion({super.key, required this.repoId});
  final String repoId;

  @override
  State<RepoVersion> createState() => _RepoVersionState();
}

class _RepoVersionState extends State<RepoVersion> {
  final TextEditingController _selectQry = TextEditingController();
  final Map<String, dynamic> releaseType = {
    'alpha': 'alpha',
    'beta': 'beta',
    'rc': 'rc',
    'release': 'release'
  };

  late VersionStore version = VersionStore();

  Future<void> _getVersionList() async {
    await version.getVersionList(widget.repoId);
  }

  @override
  void initState() {
    super.initState();
    version = Provider.of<VersionStore>(context, listen: false);
    _getVersionList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 240,
                child: CustomSelect(
                  title: '发布类型',
                  data: releaseType,
                  selectData: _selectQry,
                  hint: '请选择发布类型',
                  onChanged: (value) {
                    setState(() {
                      _selectQry.text = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount:
                  version.listData == null ? 0 : version.listData!.data!.length,
              itemBuilder: (context, index) {
                var data = version.listData!.data!;
                debugPrint('${data[index]}');
                return VersionItem(data: data[index]);
                // return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
