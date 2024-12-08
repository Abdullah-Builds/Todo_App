import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayTasks extends StatefulWidget {
  const DisplayTasks(this.tasks, {super.key});
  final List<String> tasks;

  @override
  DisplayTasksState createState() => DisplayTasksState();
}

class DisplayTasksState extends State<DisplayTasks> {
  late List<String> tasks;

  @override
  void initState() {
    super.initState();
    tasks = widget.tasks;
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);

    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                margin: const EdgeInsets.all(11.0),
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          tasks[index],
                          style: GoogleFonts.lato(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          removeTask(index);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text(''),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
