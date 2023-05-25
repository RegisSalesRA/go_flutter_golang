import 'package:flutter/cupertino.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  List taskList = [];
  TaskModel? task;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

  void cleanFields() {
    title.clear();
    description.clear();
  }

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
    getTasks();
    notifyListeners();
  }

  Future deleteTask(id) async {
    await repository.deleteTask(id);
    getTasks();
    notifyListeners();
  }

  Future updateTask(id, data) async {
    await repository.updateTask(id, data);
    getTasks();
    notifyListeners();
  }

  Future updateTaskDone(id, data) async {
    await repository.updateTaskDone(id, data);
    getTasks();
    notifyListeners();
  }
}