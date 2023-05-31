import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  List taskList = [];
  List taskListDone = [];
  TaskModel? task;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

  void cleanFields() {
    title.clear();
    description.clear();
  }

  void initTasks() async {
    await getTasks();
    await getTasksDone();
  }

  Future getTask(int id) async {
    var request = await repository.getTaskRepository(id);
    task = TaskModel.fromJson(request);
    notifyListeners();
  }

  Future getTasks() async {
    var tasks = await repository.getTasksRepository();
    taskList.clear();
    if (tasks != null) {
      var taskListRep = [for (var item in tasks) TaskModel.fromJson(item)];
      taskList = [...taskListRep];
    }
    notifyListeners();
  }

  Future getTasksDone() async {
    var tasks = await repository.getTasksDoneRepository();
    taskListDone = [];
    if (tasks != null) {
      var taskListRep = [for (var item in tasks) TaskModel.fromJson(item)];
      taskListDone = [...taskListRep];
    }
    notifyListeners();
  }

  Future createTask(data) async {
    await repository.createTaskRepository(data);
    initTasks();
    notifyListeners();
  }

  Future deleteTask(id) async {
    await repository.deleteTaskRepository(id);
    initTasks();
    notifyListeners();
  }

  Future updateTask(id, data) async {
    await repository.updateTaskRepository(id, data);
    initTasks();
    notifyListeners();
  }

  Future updateTaskDone(id, data) async {
    await repository.updateTaskDoneRepository(id, data);
    initTasks();
    notifyListeners();
  }
}
