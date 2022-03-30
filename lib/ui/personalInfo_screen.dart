import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  String name;
  PersonalInfoScreen(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
    );
  }
}
