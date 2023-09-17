import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/modules/task_tab/widget/task_item.dart';

import '../../core/net_work/my_data_base.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  var selectedData = DateTime.now();
  bool isDone = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Localizations.override(
          context: context,
          locale: Locale("en"),
          child: CalendarTimeline(
            initialDate: selectedData,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedData = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
        ),
        SizedBox(
          height: 6,
        ),
        StreamBuilder(
          stream: MyDataBase.getTask(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(""));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var tasks = snapshot.data!.docs.map((e) => e.data()).toList();
            if (tasks.isEmpty) {
              return Center(child: Text("Tasks is Empty"));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Localizations.override(
                    context: context,
                    locale: Locale("en"),
                    child: TaskItem(addTaskModel: tasks[index])),
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
