import 'package:flutter/cupertino.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  List taskList = [];
  TaskModel? task;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future getTask(int id) async {
    var request = await repository.getTask(id);
    task = TaskModel.fromJson(request);
    notifyListeners();
  }

  Future getTasks() async {
    var tasks = await repository.getTasks();
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

  Future updateTaskDone(id, data) async {
    await repository.updateTaskDone(id, data);
  }
}
