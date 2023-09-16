import 'package:flutter/material.dart';
import 'package:todo/core/net_work/my_data_base.dart';
import 'package:todo/core/service/toast.dart';
import 'package:todo/model/add_task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  var fromKey = GlobalKey<FormState>();
  var selectedTime = TimeOfDay.now();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Form(
        key: fromKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Task", style: theme.textTheme.titleLarge),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 4) {
                    return "please Enter your task";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    labelText: "Enter your task",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 4,
                controller: detailsController,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 4) {
                    return "please Enter your Details";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                    labelText: "Enter your details",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Selected Date", style: theme.textTheme.titleLarge),
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    ShowSelectedTimePicker();
                  },
                  child: Text(
                    "${selectedTime.hour} : ${selectedTime.minute}",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Selected Time", style: theme.textTheme.titleLarge),
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    ShowSelectedDatePicker();
                  },
                  child: Text(
                    "${selectedDate.year} "
                    "/${selectedDate.month} /"
                    "${selectedDate.day}",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                    textDirection: TextDirection.rtl,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        AddTaskModel addTaskModel = AddTaskModel(
                            title: titleController.text,
                            details: detailsController.text,
                            date: selectedDate.toString(),
                            time: selectedTime.toString());
                        MyDataBase.addTask(addTaskModel).then((value) {
                          Tost.tost("A task has been added");
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("Add Task", style: theme.textTheme.titleLarge)),
              )
            ],
          ),
        ),
      ),
    );
  }

  ShowSelectedTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          selectedTime = value;
        }
      });
    });
  }

  ShowSelectedDatePicker() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((value) {
      setState(() {
        if (value != null) {
          selectedDate = value;
        }
      });
    });
  }
}
