import 'package:flutter/material.dart';

import '../../app/colors/colors.dart';

Future<void> showModalBottonSheetComponent(
    BuildContext context, var viewModelTask, int? id, bool edit) {
  return showModalBottomSheet<void>(
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
          key: viewModelTask.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: viewModelTask.title,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      hintText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: viewModelTask.description,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      hintText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  child: Text(
                    edit ? 'Update Task' : 'Create Task',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (id == null) {
                      if (viewModelTask.formKey.currentState!.validate()) {
                        var data = {
                          "title": viewModelTask.title.text,
                          "description": viewModelTask.description.text
                        };
                        viewModelTask.createTask(data);
                        viewModelTask.cleanFields();
                        Navigator.pop(context);
                      }
                    }

                    if (id != null) {
                      if (viewModelTask.formKey.currentState!.validate()) {
                        var data = {
                          "title": viewModelTask.title.text,
                          "description": viewModelTask.description.text
                        };
                        viewModelTask.updateTask(id, data);
                        viewModelTask.cleanFields();
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
