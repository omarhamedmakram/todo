import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/net_work/my_data_base.dart';
import 'package:todo/model/add_task_model.dart';

import '../../update_task/update_task.dart';

class TaskItem extends StatefulWidget {
  final AddTaskModel addTaskModel;

  const TaskItem({super.key, required this.addTaskModel});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (value) {
              MyDataBase.deleteTask(widget.addTaskModel);
            },
            //   padding: EdgeInsets.all(20)
            borderRadius: BorderRadius.circular(25.0),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SizedBox(
            width: 4,
          ),
          SlidableAction(
            onPressed: (value) {
              Navigator.of(context).pushNamed(UpdateTask.routeName,
                  arguments: widget.addTaskModel);
            },
            padding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            borderRadius: BorderRadius.circular(25.0),
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'Update',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                color: widget.addTaskModel.isDone == true
                    ? Colors.green
                    : Colors.blue,
                height: 70,
                width: 3,
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.addTaskModel.title}",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.addTaskModel.isDone == true
                            ? Colors.green
                            : Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                      Text(
                        "${widget.addTaskModel.time}Am",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              widget.addTaskModel.isDone == true
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          widget.addTaskModel.isDone = false;
                          MyDataBase.UpdateTask(AddTaskModel(
                            time: widget.addTaskModel.time,
                            date: widget.addTaskModel.date,
                            details: widget.addTaskModel.details,
                            title: widget.addTaskModel.title,
                            id: widget.addTaskModel.id,
                            isDone: false,
                          )).then((value) {
                            print("Update Task");
                          });
                        });
                      },
                      child: Text(
                        "Done !",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        widget.addTaskModel.isDone = true;
                        MyDataBase.UpdateTask(AddTaskModel(
                          time: widget.addTaskModel.time,
                          date: widget.addTaskModel.date,
                          details: widget.addTaskModel.details,
                          title: widget.addTaskModel.title,
                          id: widget.addTaskModel.id,
                          isDone: true,
                        )).then((value) {
                          print("Update Task");
                        });
                        setState(() {});
                      },
                      child: Icon(Icons.check))
            ],
          ),
        ),
      ),
    );
  }
}
