import 'package:flutter/material.dart';

class Task {
  final String text;
  final String time;

  Task(this.text, this.time);
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> goal = [
    'Meditate',
    'Study for Math exam',
    'Sleep 8 hours',
    'Design demo for product',
  ];

  List<Task> todoList = [
    Task('Learn UX', '10:00 AM'),
    Task('Marketing project at school', '12:00 PM')
  ];

  List<bool> isPressList = [];

  @override
  void initState() {
    super.initState();
    isPressList = List<bool>.generate(todoList.length, (index) => false, growable: true);
  }

  void addGoal(String index) {
    setState(() {
      goal.add(index);
    });
  }

  void addTask(String text, String time) {
    setState(() {
      todoList.add(Task(text, time));
      isPressList.add(false);
    });
  }

  void showAddDialogue() {
    TextEditingController taskController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add new Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: "Enter task",
                ),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: "Enter time",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addTask(taskController.text, timeController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void removeTask(int index) {
    setState(() {
      todoList.removeAt(index);
      isPressList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showAddDialogue,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "GOALS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: goal.map((goalText) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(goalText),
                      ],
                    ),
                  );
                }).toList(),
              ),
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.redAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TASKS",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "86 %",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8), // Spacing between text and lines
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 20,
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 20,
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: todoList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: isPressList[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPressList[index] = value!;
                                      if (value) {
                                        removeTask(index);
                                      }
                                    });
                                  },
                                ),
                                title: Text(todoList[index].text),
                                subtitle: Text(todoList[index].time),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


