import 'package:client/screens/widgets/list_task_done_widget.dart';
import 'package:client/screens/widgets/list_task_widget.dart';
import 'package:client/screens/widgets/modal_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/colors/colors.dart';
import '../viewmodels/viewmodel_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskViewModel viewModelTask;
  String title = "";
  int _cIndex = 0;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModelTask = Provider.of<TaskViewModel>(context, listen: false);
    viewModelTask.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Home Screen",
              style: TextStyle(color: ColorsTheme.primaryColor),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Consumer<TaskViewModel>(
            builder: (context, taskViewModel, child) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      if (_cIndex == 0) {
                        return ListTaskWidget(
                          taskViewModel: taskViewModel,
                        );
                      }

                      if (_cIndex == 1) {
                        return ListTaskDoneWidget(
                          taskViewModel: taskViewModel,
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ));
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: ColorsTheme.primaryColor,
            selectedIconTheme:
                const IconThemeData(color: ColorsTheme.primaryColor),
            currentIndex: _cIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.radio_button_checked,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.radio_button_off,
                  ),
                  label: 'Power')
            ],
            onTap: (index) {
              _incrementTab(index);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottonSheetComponent(
                  context, viewModelTask, null, false);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }
}
