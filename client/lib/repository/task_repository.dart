import 'package:client/repository/task_repository_interface.dart';

import '../app/constants/endpoints.dart';
import '../services/http_service.dart';

class TaskRepository implements IApiTask {
  final ClientHttpService client;

  TaskRepository(this.client);

  @override
  Future getTask(int id) async {
    var request = await client.get("${Endpoints.taskGet}$id");
    return request;
  }

  @override
  Future getTasks() async {
    var request = await client.get(Endpoints.taskGetList);
    return request;
  }

  @override
  Future createTask(dynamic data) async {
    await client.post(Endpoints.taskCreate, data);
  }

  @override
  Future updateTask(int id, dynamic data) async {
    await client.update("${Endpoints.taskUpdate}$id", data);
  }

  @override
  Future deleteTask(int id) async {
    await client.delete("${Endpoints.taskDelete}$id");
  }
}
