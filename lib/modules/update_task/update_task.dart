import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/net_work/firebase_detuitles/database/my_data_base.dart';
import '../../core/service/toast.dart';
import '../../model/add_task_model.dart';
class UpdateTask extends StatefulWidget {
  static const String routeName = "Update";

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  var titleController = TextEditingController();

  var detailsController = TextEditingController();

  var fromKey = GlobalKey<FormState>();

  var selectedTime = TimeOfDay.now();

  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var args = ModalRoute.of(context)?.settings.arguments as AddTaskModel;

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.todo),
        ),
        body: Localizations.override(
          context: context,
          locale: Locale("en"),
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            color: theme.canvasColor,
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
                      child: Text("Selected Date",
                          style: theme.textTheme.titleLarge),
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
                      child: Text("Selected Time",
                          style: theme.textTheme.titleLarge),
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
                                  id: args.id,
                                  title: titleController.text,
                                  isDone: false,
                                  details: detailsController.text,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  time:
                                      "${selectedTime.hour} : ${selectedTime.minute}",
                                  date: DateUtils.dateOnly(selectedDate)
                                      .millisecondsSinceEpoch);
                              MyDataBase.UpdateTask(addTaskModel).then((value) {
                                Tost.ShowTost(
                                  massage: "Update Task ",
                                  toastGravity: ToastGravity.TOP,
                                );
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text("Save Changes",
                              style: theme.textTheme.titleLarge)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
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
