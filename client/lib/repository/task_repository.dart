import 'package:client/repository/task_repository_interface.dart';

import '../app/constants/endpoints.dart';
import '../services/http_service.dart';

class TaskRepository implements IApiTask {
  final ClientHttpService client;

  TaskRepository(this.client);

  @override
  Future getTaskRepository(int id) async {
    var request = await client.get("${Endpoints.taskGet}$id");
    return request;
  }

  @override
  Future getTasksDoneRepository() async {
    var request = await client.get(Endpoints.taskGetListDone);
    return request;
  }

  @override
  Future getTasksRepository() async {
    var request = await client.get(Endpoints.taskGetList); 
    return request;
  }

  @override
  Future createTaskRepository(dynamic data) async {
    await client.post(Endpoints.taskCreate, data);
  }

  @override
  Future updateTaskRepository(int id, dynamic data) async {
    await client.update("${Endpoints.taskUpdate}$id", data);
  }

  @override
  Future updateTaskDoneRepository(int id, dynamic data) async {
    await client.update("${Endpoints.taskDoneUpdate}$id", data);
  }

  @override
  Future deleteTaskRepository(int id) async {
    await client.delete("${Endpoints.taskDelete}$id");
  }
}
