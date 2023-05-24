import 'package:client/screens/widgets/list_task_done_widget.dart';
import 'package:client/screens/widgets/list_task_widget.dart';
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
  String title = "";
  int _cIndex = 0;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  void initState() {
    Provider.of<TaskViewModel>(context, listen: false).getTasks();
    super.initState();
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
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 10,
                            width: 70,
                            decoration: const BoxDecoration(
                                color: ColorsTheme.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }
}
