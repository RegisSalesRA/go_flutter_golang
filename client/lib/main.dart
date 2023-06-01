import 'package:client/repository/task_repository.dart';
import 'package:client/services/http_service.dart';
import 'package:client/viewmodels/viewmodel_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/config/app_theme.dart';

void main() {
//  final viewModel =
  //    TaskViewModel(repository: TaskRepository(ClientHttpService()));

  runApp(MultiProvider(providers: [
    //  ChangeNotifierProvider<TaskViewModel>.value(value: viewModel),

    Provider<ClientHttpService>(
      create: (_) => ClientHttpService(),
    ),
    Provider<TaskRepository>(
      create: (context) {
        final clientHttpService =
            Provider.of<ClientHttpService>(context, listen: false);
        return TaskRepository(clientHttpService);
      },
    ),
    ChangeNotifierProvider<TaskViewModel>(
      create: (context) {
        final newsService = Provider.of<TaskRepository>(context, listen: false);
        return TaskViewModel(repository: newsService);
      },
    ),
  ], child: const AppConfig()));
}
