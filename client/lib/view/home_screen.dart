import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewsmodels/task_viewmodel.dart';

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
                  Text(taskViewModel.taskListData.length.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await taskViewModel.getTask();
                      },
                      child: const Text("get task"))
                ],
              ));
        },
      ),
    );
  }
}
