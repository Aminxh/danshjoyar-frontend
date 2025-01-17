import 'package:danshjoyar/pages/classaPage.dart';
import 'package:danshjoyar/pages/KaraPage.dart';
import 'package:danshjoyar/pages/khabaraPage.dart';
import 'package:danshjoyar/pages/saraPage.dart';
import 'package:danshjoyar/pages/tamrina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainPageHandler extends StatelessWidget {
  String username;

  String password;

  mainPageHandler({required this.username, required this.password, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyanAccent,

            tabs: [
              Tab(icon: Icon(CupertinoIcons.home)),
              Tab(icon: Icon(Icons.task_outlined)),
              Tab(icon: Icon(Icons.class_)),
              Tab(icon: Icon(CupertinoIcons.news)),
              Tab(icon: Icon(CupertinoIcons.pen))
            ],
          ),
          body: TabBarView(
            children: [sara(username: username, password: password), Kara(username), classa(username: username,), khabara(), tamrina(username)],
          ),
        ),
      ),
    );
  }
}