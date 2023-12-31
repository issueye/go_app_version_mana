import 'package:flutter/material.dart';
import 'package:go_app_version_mana/api/api.dart';
import '../model/add_repo.dart';
import '../model/repo_list/repo_list.dart';
import '../utils/request/services.dart';

class RepoListStore extends ChangeNotifier {
  RepoList? _listData;
  RepoList? get listData => _listData;   // 列表数据
  set listData(RepoList? data) {
    _listData = data;
    notifyListeners();
  }

  String? selectRepoId;

  // 当前选择
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  RepoListStore();

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

  Future<void> getRepoList() async {
    if (DioSingleton.baseUrl == '') return;
    var data = await Api.getRepoList();
    listData = data;
  }
}
