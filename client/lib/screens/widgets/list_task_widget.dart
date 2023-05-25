import 'package:client/screens/widgets/modal_bottomsheet_widget.dart';
import 'package:flutter/material.dart';

import '../../app/colors/colors.dart';
import '../../viewmodels/viewmodel_task.dart';

class ListTaskWidget extends StatelessWidget {
  final TaskViewModel taskViewModel;
  const ListTaskWidget({Key? key, required this.taskViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: taskViewModel.taskList.length,
        itemBuilder: ((context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Material(
                    child: Ink(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.transparent,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: ExpansionTile(
                          title: Text(taskViewModel.taskList[index].title),
                          controlAffinity: ListTileControlAffinity.leading,
                          trailing: GestureDetector(
                              onTap: () {
                                var data = {
                                  'done': !taskViewModel.taskList[index].done
                                };
                                taskViewModel.updateTaskDone(
                                    taskViewModel.taskList[index].id, data);
                              },
                              child: taskViewModel.taskList[index].done
                                  ? const Icon(Icons.radio_button_checked)
                                  : const Icon(Icons.radio_button_off)),
                          tilePadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          children: <Widget>[
                            ListTile(
                                title: Text(
                                    taskViewModel.taskList[index].description)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottonSheetComponent(
                                            context,
                                            taskViewModel,
                                            taskViewModel.taskList[index].id,
                                            true);
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(
                                            color: ColorsTheme.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        taskViewModel.deleteTask(
                                            taskViewModel.taskList[index].id);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        }));
  }
}
