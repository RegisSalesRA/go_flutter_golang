abstract class IApiTask {
  Future getTasksRepository();
  Future getTasksDoneRepository();
  Future getTaskRepository(int id);
  Future createTaskRepository(dynamic data);
  Future deleteTaskRepository(int id);
  Future updateTaskRepository(int id, dynamic data);
  Future updateTaskDoneRepository(int id, dynamic data);
}
