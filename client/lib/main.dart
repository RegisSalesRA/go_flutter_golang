import 'package:client/repository/task_repository.dart';
import 'package:client/services/http_service.dart';
import 'package:client/viewmodels/viewmodel_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/config/app_theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TaskViewModel>(
        create: (context) =>
            TaskViewModel(repository: TaskRepository(ClientHttpService()))),
  ], child: const AppConfig()));
}
