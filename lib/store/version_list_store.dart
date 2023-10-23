import 'package:flutter/material.dart';
import 'package:go_app_version_mana/api/api.dart';
import 'package:go_app_version_mana/model/version_info/version_info.dart';
import '../model/add_repo.dart';
import '../utils/request/services.dart';

class VersionStore extends ChangeNotifier {
  VersionInfo? _listData;
  VersionInfo? get listData => _listData;   // 列表数据
  set listData(VersionInfo? data) {
    _listData = data;
    notifyListeners();
  }

  // 当前选择
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  VersionStore();

  int len() {
    if (listData == null) {
      return 0;
    } else {
      if (listData!.data == null) {
        return 0;
      } else {
        return listData!.data!.length;
      }
    }
  }

  Future<void> removeDataById(String id) async {
    await Api.deleteRepo(id);
  }

  Future<void> addRepo(AddRepo repo) async {
    await Api.addRepo(repo);
  }

  Future<void> getVersionList(String id) async {
    if (DioSingleton.baseUrl == '') return;
    var data = await Api.getVersionInfoList({'repo_id': id});
    listData = data;
  }
}
