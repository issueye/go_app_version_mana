import 'package:flutter/material.dart';
import '../model/repo_list/repo_list.dart';

class RepoListStore with ChangeNotifier {
  RepoList? listData;
  RepoListStore();

  void setData(RepoList list) {
    listData = list;
    notifyListeners();
  }

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

  void removeDataById(String id) {
    if (listData == null) return;
    listData!.data!.removeWhere((element) => element.id == id);

    notifyListeners();
  }
}
