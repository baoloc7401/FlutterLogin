import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:loginflutter/models/login_info_json.dart';
import 'package:loginflutter/store/activity.dart';
import 'package:loginflutter/store/activity_list.dart';
import 'package:mobx/mobx.dart';
import 'package:grouped_list/grouped_list.dart';

class MyActivityList extends StatefulWidget {
  final Login_Info_Json login_info;
  @observable
  Activity_List? activity_list;
  MyActivityList(this.login_info, this.activity_list, {Key? key})
      : super(key: key);

  @override
  State<MyActivityList> createState() => _MyActivityListState();
}

class _MyActivityListState extends State<MyActivityList> {
  Icon getIconByType(String ActivityTypes) {
    switch (ActivityTypes) {
      case "CHECK_IN":
        return const Icon(
          Icons.work,
          color: Colors.lightBlue,
        );
      case "CHECK_OUT":
        return const Icon(
          Icons.work_off,
          color: Colors.redAccent,
        );
      case "GO_OUT":
        return const Icon(
          Icons.pause_circle,
          color: Colors.redAccent,
        );
      case "COME_BACK":
        return const Icon(
          Icons.play_circle,
          color: Colors.lightBlue,
        );
      default:
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("My Activities List")),
      ),
      drawer: CustomDrawer(
          widget.login_info.user.userFullName, widget.login_info.user.vfaEmail),
      body: Center(child: _listViewBuilder()),
    );
  }

  Widget _listViewBuilder() => Observer(
        builder: (context) => ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              _activityItemsBuilder(index),
          separatorBuilder: (BuildContext context, int index) {
            if (DateFormat('yyyy-MM-dd').format(DateTime.parse(
                    widget.activity_list!.Activities![index].createdAt)) !=
                DateFormat('yyyy-MM-dd').format(DateTime.parse(widget
                    .activity_list!
                    .Activities![
                        (index + 1 == widget.activity_list!.Activities!.length)
                            ? 0
                            : index + 1]
                    .createdAt))) {
              return ListTile(
                tileColor: Colors.lightBlue.withOpacity(0.1),
                title: Center(
                  child: Text(
                    "Day ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.activity_list!.Activities![index + 1].createdAt))}",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              );
            } else {
              return const Divider();
            }
          },
          itemCount: (widget.activity_list != null)
              ? widget.activity_list!.Activities!.length
              : 0,
        ),
      );
  Widget _activityItemsBuilder(int index) {
    return Observer(
        builder: (context) => ListTile(
              leading: getIconByType(
                  widget.activity_list!.Activities![index].activityTypes),
              title: Text(
                widget.activity_list!.Activities![index].activityTypes
                    .replaceAll(RegExp('[\\W_]+'), ' '),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.activity_list!.Activities![index].activityDescription,
              ),
            ));
  }
}
