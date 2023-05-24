import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/viewmodel_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Home Screen"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(taskViewModel.taskList.length.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await taskViewModel.getTask(6);
                      },
                      child: const Text("get task")),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await taskViewModel.getTasks();
                      },
                      child: const Text("get task")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var data = {
                          "title": "title update 10",
                          "description": "description title 10"
                        };
                        await taskViewModel.createTask(data);
                      },
                      child: const Text("create task")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var data = {
                          "title": "title update 77",
                          "description": "description title 77"
                        };
                        await taskViewModel.updateTask(6, data);
                      },
                      child: const Text("Update task")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await taskViewModel.deleteTask(11);
                      },
                      child: const Text("Delete task"))
                ],
              ));
        },
      ),
    );
  }
}
