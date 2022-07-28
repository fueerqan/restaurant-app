import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/shared_prefs/shared_pref_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    getSavedScheduleStatus();
    super.initState();
  }

  void getSavedScheduleStatus() async {
    SchedulingProvider.isScheduled =
        await SharedPrefHelper.isScheduleActivated();
  }

  void customDialog(BuildContext context,
      {String title = "Coming Soon!",
      String content = "This feature will be coming soon!"}) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigation.back();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigation.back();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Scheduling Restaurant Recommendation'),
              trailing: ChangeNotifierProvider<SchedulingProvider>(
                create: (_) => SchedulingProvider(),
                child: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: SchedulingProvider.isScheduled,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
