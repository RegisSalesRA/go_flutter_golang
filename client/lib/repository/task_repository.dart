import 'package:client/repository/task_repository_interface.dart';

import '../app/constants/endpoints.dart';
import '../services/http_service.dart';

class TaskRepository implements IApiTask {
  final ClientHttpService client;

  TaskRepository(this.client);

  @override
  Future getTask() async {
    var request = await client.get(Endpoints.taskGetList);
    return request;
  }
}
