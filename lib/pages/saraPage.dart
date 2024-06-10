import 'package:danshjoyar/pages/EditAccount.dart';
import 'package:flutter/material.dart';

class sara extends StatefulWidget {
  const sara({super.key});

  @override
  State<sara> createState() => _SaraState();
}

class _SaraState extends State<sara> {
  List<Task> tasks = List<Task>.generate(
      10, (index) => Task('Task ${index + 1}', DateTime.now()));
  List<Task> doneTasks = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<int>(
               iconColor: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem(

                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.contact_mail_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Contact Us")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("About Us")
                    ],
                  ),

                ),

                PopupMenuItem(

                  value: 3,
                  child: Row(
                    children: [
                      Icon(Icons.transit_enterexit),
                      SizedBox(
                        width: 10,
                      ),
                      Text("GitHub")
                    ],
                  ),
                ),
               ],
              color: Colors.white,
              onSelected: (value) {
                if (value == 1) {

                } else if (value == 2) {
                  // _showDialog(context);
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 35,
                color: Colors.white,
              ),
              tooltip: 'Open Edit Account',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAccount(
                      password: "",
                      username: "",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "lib/asset/images/casey-horner-4rDCa5hBlCs-unsplash.jpg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.height / 10,
                  MediaQuery.of(context).size.height / 25,
                  MediaQuery.of(context).size.height / 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryBox(
                            icon: Icon(Icons.school),
                            text: " Exam:",
                            width: 110),
                        _buildSummaryBox(
                            icon: Icon(Icons.task),
                            text: " DeadLine:",
                            width: 100),
                        _buildSummaryBox(
                            icon: Icon(Icons.star),
                            text: " Best Score:",
                            width: 110),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryBox(
                          icon: Icon(Icons.restore_from_trash_outlined),
                          text: " Worst Score:",
                        ),
                        _buildSummaryBox(
                          icon: Icon(Icons.done_outlined),
                          text: "Done:",
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Current Tasks:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              leading: Icon(Icons.task_outlined),
                              title: Text(tasks[index].name,
                                  style: TextStyle(fontSize: 18)),
                              subtitle: Text(tasks[index]
                                  .dateTime
                                  .toLocal()
                                  .toString()
                                  .split(" ")
                                  .first),
                              trailing: IconButton(
                                icon: Icon(Icons.circle_outlined),
                                onPressed: () {
                                  setState(() {
                                    doneTasks.add(tasks[index]);
                                    tasks.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Completed Tasks:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: doneTasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white.withOpacity(0.5),
                            child: ListTile(
                              leading: Icon(Icons.done),
                              title: Text(doneTasks[index].name,
                                  style: TextStyle(fontSize: 18)),
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
        ),
      ),
    );
  }

  Widget _buildSummaryBox(
      {required String text, required Icon icon, double width = 120}) {
    return Container(
      width: width,
      height: 100, // Increased height to accommodate icon and text
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.shade200,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Modified here
          IconTheme(
            data: IconThemeData(
              color: Colors.black, // Icon color
              size: 50, // Icon size
            ),
            child: icon,
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String name;
  DateTime dateTime;

  Task(this.name, this.dateTime);
}
