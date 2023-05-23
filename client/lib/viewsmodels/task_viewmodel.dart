import 'package:client/models/task_model.dart';
import 'package:flutter/cupertino.dart';

import '../repository/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  List taskListData = [];

  Future getTask() async {
    var tasks = await repository.getTask();
    for (var item in tasks) {
      var newitem = TaskModel.fromJson(item);
      taskListData.add(newitem);
    }
    notifyListeners();
  }
}
