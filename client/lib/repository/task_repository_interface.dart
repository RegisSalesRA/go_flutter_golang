abstract class IApiTask {
  Future getTask();
  Future createTask(dynamic data);
  Future deleteTask(int id);
  Future updateTask(int id, dynamic data);
}
