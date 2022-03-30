import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loginflutter/ui/personalInfo_screen.dart';

class CustomDrawer extends StatelessWidget {
  String name;
  String email;
  CustomDrawer(this.name, this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        //color: Colors.white,
        child: ListView(children: [
          DrawerHeader(child: buildDrawerHeader(name: name, email: email)),
          buildDrawerItem(
            title: "Personal Information",
            leading: Icons.person,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalInfoScreen(name)));
              //Navigator.of(context).pop();
            },
          ),
          buildDrawerItem(
            title: "Settings",
            leading: Icons.settings,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          buildDrawerItem(
            title: "About VFA",
            leading: Icons.info,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ]),
      ),
    );
  }

  Widget buildDrawerItem(
      {required String title, required IconData leading, VoidCallback? onTap}) {
    const color = Colors.lightBlue;
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      leading: Icon(
        leading,
        color: color,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerHeader({required String name, required String email}) {
    const color = Colors.white;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: PhysicalModel(
          color: Colors.blue,
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            PhysicalModel(
              color: color,
              borderRadius: BorderRadius.circular(20),
              elevation: 1,
              shadowColor: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: color, fontSize: 20),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(color: color, fontSize: 20),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
