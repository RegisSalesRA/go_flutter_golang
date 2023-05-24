abstract class IApiTask {
  Future getTasks();
  Future getTask(int id);
  Future createTask(dynamic data);
  Future deleteTask(int id);
  Future updateTask(int id, dynamic data);
}
