import 'package:flutter/cupertino.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  List taskList = [];

  Future getTask() async {
    var tasks = await repository.getTask();
    var taskListRep = [for (var item in tasks) TaskModel.fromJson(item)];
    taskList = [...taskListRep];
    notifyListeners();
  }

  Future createTask(data) async {
    await repository.createTask(data);
  }

  Future deleteTask(id) async {
    await repository.deleteTask(id);
  }

  Future updateTask(id, data) async {
    await repository.updateTask(id, data);
  }
}
